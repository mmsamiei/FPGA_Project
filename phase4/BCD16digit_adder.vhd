library IEEE;
use IEEE.std_logic_1164.all;

entity BCD16digit_adder is
	port(a: in std_logic_vector(63 downto 0);	
		b : in std_logic_vector(63 downto 0);
		result : out std_logic_vector(63 downto 0));
end entity BCD16digit_adder;

architecture structural of BCD16digit_adder is 
	
	component BCD4bit_adder is
		port(a: in std_logic_vector(3 downto 0);	
		b : in std_logic_vector(3 downto 0);
		carry_in : in std_logic;
		result : out std_logic_vector(3 downto 0);
		carry_out : out std_logic );
	end component BCD4bit_adder;
	
	signal carry_outs : std_logic_vector(15 downto 0);
	
	begin
	
	adder_0 : BCD4bit_adder port map(a=>a(3 downto 0),b=>b(3 downto 0),carry_in=>'0',result=>result(3 downto 0),carry_out=>carry_outs(0));
	small_adders:
	for i in 1 to 15 generate
		adder_i : BCD4bit_adder port map(a=>a(4*i+3 downto 4*i),b=>b(4*i+3 downto 4*i),carry_in=>carry_outs(i-1),result=>result(4*i+3 downto 4*i),carry_out=>carry_outs(i));
    end generate small_adders;
end architecture structural;
