library IEEE;
use IEEE.std_logic_1164.all;

entity BCD4bit_adder is
	port(a: in std_logic_vector(3 downto 0);	
		b : in std_logic_vector(3 downto 0);
		carry_in : in std_logic;
		result : out std_logic_vector(3 downto 0);
		carry_out : out std_logic );
end entity BCD4bit_adder;

architecture structural of BCD4bit_adder is

component FullAdder is 
		port(A, B, carry_in: in std_logic;
			sum, carry_out: out std_logic);
	end component;

signal temp_result : std_logic_vector(3 downto 0) := "0000";
signal temp_carry_out : std_logic_vector(3 downto 0) := "0000";
signal final_result : std_logic_vector(3 downto 0) := "0000";
signal final_carry_out : std_logic_vector(3 downto 0) := "0000";
signal needFix : std_logic;

begin
	FA_0 : FullAdder port map (A=>a(0),B=>b(0),sum=>temp_result(0),carry_in=>carry_in,carry_out=>temp_carry_out(0));
	
	generate_adders:
	for i in 1 to 3 generate
		FA_i : FullAdder port map (A=>a(i),B=>b(i),sum=>temp_result(i),carry_in=>temp_carry_out(i-1),carry_out=>temp_carry_out(i));
	end generate generate_adders;
	
	needFix <= (temp_result(3) and temp_result(1)) or (temp_result(3) and temp_result(2)) or temp_carry_out(3);
	
	final_result(0)<=temp_result(0);
	final_carry_out(0)<='0';
	
	generate_FAFixi:
	for i in 1 to 3 generate
		
		label_1:
		if i /= 3 generate
			FAFixi_i : FullAdder port map (A=>temp_result(i),B=>needFix,sum=>final_result(i),carry_in=>final_carry_out(i-1),carry_out=>final_carry_out(i));
		end generate label_1;
		
		label_2:
		if i = 3 generate
		FAFixi_i : FullAdder port map (A=>temp_result(i),B=>'0',sum=>final_result(i),carry_in=>final_carry_out(i-1),carry_out=>final_carry_out(i));
		end generate label_2;
		
	end generate generate_FAFixi;
		
	result <= final_result;
	carry_out <= temp_carry_out(3) or final_carry_out(3);
	
end architecture structural;

