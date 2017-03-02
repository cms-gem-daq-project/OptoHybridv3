library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity sem_mon is
port(
    clk_i               : in std_logic;
    heartbeat_o         : out std_logic;
    initialization_o    : out std_logic;
    observation_o       : out std_logic;
    correction_o        : out std_logic;
    classification_o    : out std_logic;
    injection_o         : out std_logic;
    essential_o         : out std_logic;
    uncorrectable_o     : out std_logic
);
end sem_mon;

architecture behavioral of sem_mon is

    -- Not working without...
    component sem
    port(
        status_heartbeat        : out std_logic;
        status_initialization   : out std_logic;
        status_observation      : out std_logic;
        status_correction       : out std_logic;
        status_classification   : out std_logic;
        status_injection        : out std_logic;
        status_essential        : out std_logic;
        status_uncorrectable    : out std_logic;
        monitor_txdata          : out std_logic_vector(7 downto 0);
        monitor_txwrite         : out std_logic;
        monitor_txfull          : in std_logic;
        monitor_rxdata          : in std_logic_vector(7 downto 0);
        monitor_rxread          : out std_logic;
        monitor_rxempty         : in std_logic;
        icap_busy               : in std_logic;
        icap_o                  : in std_logic_vector(31 downto 0);
        icap_csb                : out std_logic;
        icap_rdwrb              : out std_logic;
        icap_i                  : out std_logic_vector(31 downto 0);
        icap_clk                : in std_logic;
        icap_request            : out std_logic;
        icap_grant              : in std_logic;
        fecc_crcerr             : in std_logic;
        fecc_eccerr             : in std_logic;
        fecc_eccerrsingle       : in std_logic;
        fecc_syndromevalid      : in std_logic;
        fecc_syndrome           : in std_logic_vector(12 downto 0);
        fecc_far                : in std_logic_vector(23 downto 0);
        fecc_synbit             : in std_logic_vector(4 downto 0);
        fecc_synword            : in std_logic_vector(6 downto 0)
    );
    end component;

    signal fecc_crcerr              : std_logic;
    signal fecc_eccerr              : std_logic;
    signal fecc_eccerrsingle        : std_logic;
    signal fecc_syndromevalid       : std_logic;
    signal fecc_syndrome            : std_logic_vector(12 downto 0);
    signal fecc_far                 : std_logic_vector(23 downto 0);
    signal fecc_synbit              : std_logic_vector(4 downto 0);
    signal fecc_synword             : std_logic_vector(6 downto 0);

    signal icap_o                   : std_logic_vector(31 downto 0);
    signal icap_i                   : std_logic_vector(31 downto 0);
    signal icap_busy                : std_logic;
    signal icap_csb                 : std_logic;
    signal icap_rdwrb               : std_logic;
  
begin

    --=========--
    --== sem ==--
    --=========--

    sem_core_inst : sem
    port map(
        status_heartbeat        => heartbeat_o,
        status_initialization   => initialization_o,
        status_observation      => observation_o,
        status_correction       => correction_o,
        status_classification   => classification_o,
        status_injection        => injection_o,
        status_essential        => essential_o,
        status_uncorrectable    => uncorrectable_o,
        monitor_txdata          => open,
        monitor_txwrite         => open,
        monitor_txfull          => '0',
        monitor_rxdata          => (others => '0'),
        monitor_rxread          => open,
        monitor_rxempty         => '1',
        fecc_crcerr             => fecc_crcerr,
        fecc_eccerr             => fecc_eccerr,
        fecc_eccerrsingle       => fecc_eccerrsingle,
        fecc_syndromevalid      => fecc_syndromevalid,
        fecc_syndrome           => fecc_syndrome,
        fecc_far                => fecc_far,
        fecc_synbit             => fecc_synbit,
        fecc_synword            => fecc_synword,
        icap_o                  => icap_o,
        icap_i                  => icap_i,
        icap_busy               => icap_busy,
        icap_csb                => icap_csb,
        icap_rdwrb              => icap_rdwrb,
        icap_clk                => clk_i,
        icap_request            => open,
        icap_grant              => '1'
    );

    --==========--
    --== fecc ==--
    --==========--
    
    frame_ecc_inst : frame_ecc_virtex6
    generic map (
        frame_rbt_in_filename   => "none",
        farsrc                  => "efar"
    )
    port map (
        crcerror                => fecc_crcerr,
        eccerror                => fecc_eccerr,
        eccerrorsingle          => fecc_eccerrsingle,
        far                     => fecc_far,
        synbit                  => fecc_synbit,
        syndrome                => fecc_syndrome,
        syndromevalid           => fecc_syndromevalid,
        synword                 => fecc_synword
    );
    
    --==========--
    --== ICAP ==--
    --==========--

    icap_inst : icap_virtex6
    generic map (
        sim_cfg_file_name   => "none",
        device_id           => x"ffffffff",
        icap_width          => "x32"
    )
    port map (
        busy                => icap_busy,
        o                   => icap_o,
        clk                 => clk_i,
        csb                 => icap_csb,
        i                   => icap_i,
        rdwrb               => icap_rdwrb
    );   
    
end behavioral;