library ieee;
library utils;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use utils.funciones.all;

--* @brief Contador sincrónico ascendente módulo M programable
--*
--* La entrada <var>max_count_i</var> debe tomar valores entre 0 y M - 1.
--* La salida <var>max_o</var> se levanta si <var>run_i</var> = '1' y 
--* <var>count_o</var> = <var>max_count_i</var>

entity mod_m_counter_prog is
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
end entity;

architecture rtl of mod_m_counter_prog is
  
  signal r_reg  : unsigned(ceil2power(M-1)-1 downto 0);
  signal r_next : unsigned(ceil2power(M-1)-1 downto 0);

begin
  process(clk_i, reset_i)
  begin
    if (clk_i'event and clk_i = '1') then
      if (reset_i = '1') then
        r_reg <= (others => '0');
      elsif run_i = '1' then
        r_reg <= r_next;
      end if;
    end if;
  end process;

  r_next <= (others => '0') when r_reg = unsigned(max_count_i) else
                r_reg + 1;
  
  max_o <= '1' when r_reg = unsigned(max_count_i) and (run_i = '1') else
           '0';
  
  count_o <= std_logic_vector(r_reg);

end architecture;
