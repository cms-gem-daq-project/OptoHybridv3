--=================================================================================================--
--##################################   Module Information   #######################################--
--=================================================================================================--
--                                                                                       
-- Company:               CERN (PH-ESE-BE)                                                        
-- Engineer:              Manoel Barros Marin (manoel.barros.marin@cern.ch) (m.barros.marin@ieee.org)
--                        (Original design by P. Vichoudis (CERN) & M. Barros Marin)                                                                                                   
--
-- Project Name:          GBT-FPGA                                                                
-- Module Name:           Xilinx Virtex 6 - GBT RX_FRAMECLK phase aligner                                     
--                                                                                                 
-- Language:              VHDL'93                                                           
--                                                                                                 
-- Target Device:         Xilinx Virtex 6                                                        
-- Tool version:          ISE 14.5                                                                    
--                                                                                                 
-- Version:               3.1                                                                     
--
-- Description:            
--
-- Versions history:      DATE         VERSION   AUTHOR            DESCRIPTION
--
--                        15/05/2013   3.0       M. Barros Marin   First .vhd module definition
--
--                        12/10/2014   3.1       M. Barros Marin   Version for Xilinx Virtex 6     
--
-- Additional Comments:                                                                               
--
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! IMPORTANT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!                                                                                           !!
-- !! * The different parameters of the GBT Bank are set through:                               !!  
-- !!   (Note!! These parameters are vendor specific)                                           !!                    
-- !!                                                                                           !!
-- !!   - The MGT control ports of the GBT Bank module (these ports are listed in the records   !!
-- !!     of the file "<vendor>_<device>_gbt_bank_package.vhd").                                !! 
-- !!     (e.g. xlx_v6_gbt_bank_package.vhd)                                                    !!
-- !!                                                                                           !!  
-- !!   - By modifying the content of the file "<vendor>_<device>_gbt_bank_user_setup.vhd".     !!
-- !!     (e.g. xlx_v6_gbt_bank_user_setup.vhd)                                                 !! 
-- !!                                                                                           !! 
-- !! * The "<vendor>_<device>_gbt_bank_user_setup.vhd" is the only file of the GBT Bank that   !!
-- !!   may be modified by the user. The rest of the files MUST be used as is.                  !!
-- !!                                                                                           !!  
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--
--=================================================================================================--
--#################################################################################################--
--=================================================================================================--

-- IEEE VHDL standard library:
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Custom libraries and packages:
use work.vendor_specific_gbt_bank_package.all;

--=================================================================================================--
--#######################################   Entity   ##############################################--
--=================================================================================================--

entity gbt_rx_frameclk_phalgnr is   
   port ( 
      
      --=======--
      -- Reset --
      --=======-- 
   
      RESET_I                                   : in  std_logic;
      
      --===============--
      -- Clocks scheme --
      --===============--

      RX_WORDCLK_I                              : in  std_logic;         
      RX_FRAMECLK_O                             : out std_logic;   -- Comment: Phase aligned 40MHz output.     

      --=========--
      -- Control --
      --=========--
      
      SYNC_ENABLE_I                             : in  std_logic;       
      SYNC_I                                    : in  std_logic;
      ------------------------------------------
      PLL_LOCKED_O                              : out std_logic;
      DONE_O                                    : out std_logic

   );
end gbt_rx_frameclk_phalgnr;

--=================================================================================================--
--####################################   Architecture   ###########################################-- 
--=================================================================================================--

architecture behavioral of gbt_rx_frameclk_phalgnr is   

   --================================ Signal Declarations ================================--   
   
   signal reset_from_orGate                     : std_logic;
   ---------------------------------------------
   signal rxFrameClk_from_pllCtrl               : std_logic;      
   signal pllLocked_from_pllCtrl                : std_logic;      
   ---------------------------------------------
   signal numberSteps_from_main                 : std_logic_vector(RXFRAMECLK_STEPS_MSB downto 0);
   signal setNumberSteps_from_main              : std_logic;
   signal doPhaseShift_from_main                : std_logic;

   --=====================================================================================--      
   
--=================================================================================================--
begin                 --========####   Architecture Body   ####========-- 
--=================================================================================================--

   --==================================== User Logic =====================================--

   --===============--
   -- PLL & Control --
   --===============--
   
   pllCtrl: entity work.gbt_rx_frameclk_phalgnr_ctrl
      port map (   
         RESET_I                                => RESET_I,         
         ---------------------------------------
         RX_WORDCLK_I                           => RX_WORDCLK_I,      
         RX_FRAMECLK_O                          => rxFrameClk_from_pllCtrl,              
         ---------------------------------------
         NUMBERSTEPS_I                          => numberSteps_from_main,
         SETNUMSTEPS_I                          => setNumberSteps_from_main,
         INCDEC_PHASE_I                         => '0',
         DOPHASESHIFT_I                         => doPhaseShift_from_main,   
         PLLLOCKED_O                            => pllLocked_from_pllCtrl,
         PHASESHIFTDONE_O                       => DONE_O   
      );
   
   RX_FRAMECLK_O                                <= rxFrameClk_from_pllCtrl;   
   PLL_LOCKED_O                                 <= pllLocked_from_pllCtrl;
   
   --==============--
   -- Main process --
   --==============--
   
   reset_from_orGate                            <= RESET_I or (not pllLocked_from_pllCtrl);
   
   main: process(reset_from_orGate, RX_WORDCLK_I)
      variable cnState                          : integer range 0 to 3;
      variable psState                          : integer range 0 to 6;      
      variable stepCnt                          : unsigned(RXFRAMECLK_STEPS_MSB downto 0);      
      variable stepsFound                       : boolean;
      variable slowClk_r2, slowClk_r            : std_logic;
      variable sync_r2   , sync_r               : std_logic;     
   begin
      if reset_from_orGate = '1' then      
         cnState                                := 0;    
         psState                                := 0;    
         ---------------------------------------      
         stepCnt                                := (others => '0');
         stepsFound                             := false;
         ---------------------------------------      
         numberSteps_from_main                  <= (others => '0');
         setNumberSteps_from_main               <= '0';
         doPhaseShift_from_main                 <= '0';
         --------------------------------------- 
         slowClk_r2                             := '0';    
         slowClk_r                              := '0';
         sync_r2                                := '1';    
         sync_r                                 := '1';          
      elsif rising_edge(RX_WORDCLK_I) then      
         numberSteps_from_main                  <= std_logic_vector(stepCnt);
         ---------------------------------------
         if SYNC_ENABLE_I = '1' then      
            case psState is
               when 0 => setNumberSteps_from_main <= '0'; doPhaseShift_from_main <= '0'; if stepsFound = true then psState := 1; end if;
               when 1 => setNumberSteps_from_main <= '0'; doPhaseShift_from_main <= '0';                           psState := 2;
               when 2 => setNumberSteps_from_main <= '1'; doPhaseShift_from_main <= '0';                           psState := 3;
               when 3 => setNumberSteps_from_main <= '0'; doPhaseShift_from_main <= '0';                           psState := 4;
               when 4 => setNumberSteps_from_main <= '0'; doPhaseShift_from_main <= '1';                           psState := 5;
               when 5 => setNumberSteps_from_main <= '0'; doPhaseShift_from_main <= '0';                           psState := 6;
               when others => null; 
            end case;   
            ------------------------------------
            case cnState is
               when 0 => if (sync_r2    = '0') and (sync_r    = '1') then cnState := 1; end if;
               when 1 => if (slowClk_r2 = '0') and (slowClk_r = '1') then cnState := 2; else stepCnt := stepCnt + 1; end if;
               when 2 => stepsFound := true;                              cnState := 3;
               when others => null;
            end case;   
         end if;
         ---------------------------------------
         slowClk_r2 := slowClk_r; slowClk_r := rxFrameClk_from_pllCtrl;
         sync_r2    := sync_r;    sync_r    := SYNC_I;
      end if;
   end process;

--=====================================================================================--
end behavioral;
--=================================================================================================--
--#################################################################################################--
--=================================================================================================--