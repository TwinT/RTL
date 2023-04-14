library ieee;
library utils;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use utils.funciones.all;

--* @brief Testbench de mod_m_counter

entity mod_m_counter_prog_tb is
end entity;

architecture rtl of mod_m_counter_prog_tb is

  constant M : natural := 54;

  -- Component Declaration for the Unit Under Test (UUT)

  component mod_m_counter_prog
    generic(
        M : natural 
        );   
    port(
        clk_i       : in  std_logic;
        reset_i     : in  std_logic;
        run_i       : in  std_logic;
        max_count_i : in  std_logic_vector (ceil2power(M-1)-1 downto 0);
        count_o     : out std_logic_vector (ceil2power(M-1)-1 downto 0);
        max_o       : out std_logic
        );        
  end component;

  --Inputs
  signal clk     : std_logic := '0';
  signal reset   : std_logic := '0';
  signal run     : std_logic := '0';

  --Outputs
  signal q   : std_logic_vector(ceil2power(M)-1 downto 0);
  signal max_count: std_logic_vector(ceil2power(M-1)-1 downto 0);
  signal max : std_logic;

  -- Clock period definitions
  constant clk_period : time := 1 us;
  
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : mod_m_counter_prog
    generic map(M => M)
    port map (
      clk_i        => clk,
      reset_i      => reset,
      run_i        => run,
      max_count_i  => max_count,
      count_o      => q,
      max_o        => max
      );

  -- Clock process definitions
  clk_process : process
  begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
  end process;

  reset   <= '1', '0' after 5 us;
  run <= '0', '1' after 20 us;
  max_count <= std_logic_vector(to_unsigned(14,ceil2power(M-1)));
end;
