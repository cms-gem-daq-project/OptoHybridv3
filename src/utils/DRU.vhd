library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dru is
port(
  clk1x : in  std_logic;                    -- 80 MHz clock
  clk2x : in  std_logic;                    -- 160 MHz clock
  i     : in  std_logic_vector(7 downto 0); -- 8-bit input, the even bits are inverted!
  o     : out std_logic_vector(7 downto 0); -- 8-bit recovered output
  vo    : out std_logic);                   -- valid data out
end dru;

architecture behavioral of dru is

  signal e4                                     : std_logic_vector(3 downto 0):=(others=>'0');

  signal data_in_delay,data_in_delay_uninverted : std_logic_vector(7 downto 0):=(others=>'0');
  signal data7_delay_delay                      : std_logic:='0';
  signal phase_sel_state                        : std_logic_vector(1 downto 0):="00";

  signal positive_bitslip                       : std_logic;
  signal negative_bitslip                       : std_logic;

  signal fifo_s1                                : std_logic_vector(2 downto 0):="000";
  signal fifo_s2                                : std_logic_vector(4 downto 0):="00000";
  signal fifo_s3                                : std_logic_vector(4 downto 0):="00000";

  signal rxsh                                   : std_logic_vector(6 downto 0):=(others=>'0');
  signal rxdata                                 : std_logic_vector(7 downto 0):=(others=>'0');
  signal rxcnt                                  : unsigned(3 downto 0):=(others=>'0');
  signal rxvalid                                : std_logic:='0';

  attribute use_clock_enable                    : string;
  attribute use_clock_enable of fifo_s2         : signal is "no";

  type   bitslip_state_t is (slip_pos, slip_neg, slip_none);
  signal bitslip_state     : bitslip_state_t := slip_none;
  signal bitslip_state_dly : bitslip_state_t := slip_none;

begin
  process(clk2x)
  begin
    if rising_edge(clk2x) then

      data_in_delay<=i;

      e4(0)<=(data_in_delay(0) xnor data_in_delay(1)) or (data_in_delay(4) xnor data_in_delay(5));
      e4(1)<=(data_in_delay(1) xnor data_in_delay(2)) or (data_in_delay(5) xnor data_in_delay(6));
      e4(2)<=(data_in_delay(2) xnor data_in_delay(3)) or (data_in_delay(6) xnor data_in_delay(7));
      e4(3)<=(data_in_delay(3) xnor data_in_delay(4)) or (data_in_delay_uninverted(7) xnor data_in_delay(0));

      data_in_delay_uninverted<=data_in_delay xor x"55";

      data7_delay_delay<=data_in_delay_uninverted(7);

    end if;
  end process;

  process (clk2x)
  begin
    if rising_edge(clk2x) then

      case phase_sel_state is

        when "00"=>if e4(0)='1' then
                     phase_sel_state<="10";
                   elsif e4(3)='1' then
                     phase_sel_state<="01";
                   end if;
        when "01"=>if e4(1)='1' then
                     phase_sel_state<="00";
                   elsif e4(0)='1' then
                     phase_sel_state<="11";
                   end if;
        when "11"=>if e4(2)='1' then
                     phase_sel_state<="01";
                   elsif e4(1)='1' then
                     phase_sel_state<="10";
                   end if;
        when "10"=>if e4(3)='1' then
                     phase_sel_state<="11";
                   elsif e4(2)='1' then
                     phase_sel_state<="00";
                   end if;
        when others=>null;

      end case;

      if (phase_sel_state="10" and e4(3)='0' and e4(2)='1') then negative_bitslip <='1';
      else                                                       negative_bitslip <='0';
      end if;

      if (phase_sel_state="00" and e4(3)='0' and e4(0)='1') then positive_bitslip <='1';
      else                                                       positive_bitslip <='0'; -- transition from 00 to 10
      end if;

      if    (negative_bitslip = '1')                          then bitslip_state <=  slip_neg;
      elsif (positive_bitslip = '1')                          then bitslip_state <=  slip_pos;
      elsif (negative_bitslip = '0' and positive_bitslip='0') then bitslip_state <=  slip_none;
      end if;

      case phase_sel_state is
        when "00"   => fifo_s1 <= data7_delay_delay & data_in_delay_uninverted(0) & data_in_delay_uninverted(4);
        when "01"   => fifo_s1 <= data7_delay_delay & data_in_delay_uninverted(1) & data_in_delay_uninverted(5);
        when "11"   => fifo_s1 <= data7_delay_delay & data_in_delay_uninverted(2) & data_in_delay_uninverted(6);
        when "10"   => fifo_s1 <= data7_delay_delay & data_in_delay_uninverted(3) & data_in_delay_uninverted(7);
        when others => null;
      end case;

    end if;
  end process;

  process(clk2x)
  begin
    if rising_edge(clk2x) then

        case bitslip_state is
          when slip_neg  => fifo_s2 <= fifo_s2(4-1 downto 0) & fifo_s1(0);          -- negative bitslip
          when slip_none => fifo_s2 <= fifo_s2(4-2 downto 0) & fifo_s1(1 downto 0); -- no bitslip
          when slip_pos  => fifo_s2 <= fifo_s2(4-3 downto 0) & fifo_s1(2 downto 0); -- positive bitslip
          when others    => null;
        end case;

    end if;

  end process;


  process(clk1x)
  begin
    if rising_edge(clk1x) then

      fifo_s3<=fifo_s2;
      bitslip_state_dly <= bitslip_state;

      case bitslip_state_dly is

        when slip_neg => -- negative bitslip; add 3 bits

          rxsh<=rxsh(rxsh'high-3 downto rxsh'low)&fifo_s3(2 downto 0);

                    if rxcnt=5 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high-2 downto rxsh'low)&fifo_s3(2 downto 0);
                      rxcnt<=to_unsigned(0,rxcnt'length);
                    elsif rxcnt=6 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high-1 downto rxsh'low)&fifo_s3(2 downto 1);
                      rxcnt<=to_unsigned(1,rxcnt'length);
                    elsif rxcnt=7 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high downto rxsh'low)&fifo_s3(2);
                      rxcnt<=to_unsigned(2,rxcnt'length);
                    else
                      rxvalid<='0';
                      rxcnt<=rxcnt+3;
                    end if;

        when slip_none => -- no bitslip; add 4 bits

          rxsh<=rxsh(rxsh'high-4 downto rxsh'low)&fifo_s3(3 downto 0);

                    if rxcnt=4 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high-3 downto rxsh'low)&fifo_s3(3 downto 0);
                      rxcnt<=to_unsigned(0,rxcnt'length);
                    elsif rxcnt=5 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high-2 downto rxsh'low)&fifo_s3(3 downto 1);
                      rxcnt<=to_unsigned(1,rxcnt'length);
                    elsif rxcnt=6 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high-1 downto rxsh'low)&fifo_s3(3 downto 2);
                      rxcnt<=to_unsigned(2,rxcnt'length);
                    elsif rxcnt=7 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high downto rxsh'low)&fifo_s3(3);
                      rxcnt<=to_unsigned(3,rxcnt'length);
                    else
                      rxvalid<='0';
                      rxcnt<=rxcnt+4;
                    end if;

        when slip_pos => -- positive bitslip; add 5 bits

          rxsh<=rxsh(rxsh'high-5 downto rxsh'low)&fifo_s3(4 downto 0);

                    if rxcnt=3 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high-4 downto rxsh'low)&fifo_s3(4 downto 0);
                      rxcnt<=to_unsigned(0,rxcnt'length);
                    elsif rxcnt=4 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high-3 downto rxsh'low)&fifo_s3(4 downto 1);
                      rxcnt<=to_unsigned(1,rxcnt'length);
                    elsif rxcnt=5 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high-2 downto rxsh'low)&fifo_s3(4 downto 2);
                      rxcnt<=to_unsigned(2,rxcnt'length);
                    elsif rxcnt=6 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high-1 downto rxsh'low)&fifo_s3(4 downto 3);
                      rxcnt<=to_unsigned(3,rxcnt'length);
                    elsif rxcnt=7 then
                      rxvalid<='1';
                      rxdata<=rxsh(rxsh'high downto rxsh'low)&fifo_s3(4);
                      rxcnt<=to_unsigned(4,rxcnt'length);
                    else
                      rxvalid<='0';
                      rxcnt<=rxcnt+5;
                    end if;

        when others=>null;

      end case;
    end if;
  end process;

  vo<=rxvalid;
  o <= rxdata;


end behavioral;

