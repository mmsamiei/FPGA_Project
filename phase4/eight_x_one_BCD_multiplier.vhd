library IEEE;
use IEEE.std_logic_1164.all;

entity eight_x_one_BCD_multiplier is 
	port(
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(3 downto 0);
		result : out std_logic_vector(35 downto 0)
	);
end eight_x_one_BCD_multiplier;

architecture structural of eight_x_one_BCD_multiplier is

component one_x_one_BCD_multiplier is
		port(A, B: in std_logic_vector (3 downto 0);
		result: out std_logic_vector (7 downto 0));
    end component;
	
component BCD4bit_adder is
	port(a: in std_logic_vector(3 downto 0);	
		b : in std_logic_vector(3 downto 0);
		carry_in : in std_logic;
		result : out std_logic_vector(3 downto 0);
		carry_out : out std_logic );
end component;
	
component Binary8bit_to_BCD8bit is
	port(a: in std_logic_vector(7 downto 0);	--binary
		result : out std_logic_vector(7 downto 0));		--BCD
end component Binary8bit_to_BCD8bit;

type temp_muls_type is array (0 to 7) of std_logic_vector(7 downto 0);
signal temp_muls : temp_muls_type;
signal bcd_temp_muls : temp_muls_type;
signal temp_carry_out: std_logic_vector(7 downto 0):="00000000";
signal over_flow: std_logic;
begin
	
	small_multiplier: one_x_one_BCD_multiplier port map(A=>a(4*0+3 downto 4*0),B=>b(3 downto 0),result=>temp_muls(0)(7 downto 0));
	bin_to_bcd: Binary8bit_to_BCD8bit port map(a=>temp_muls(0)(7 downto 0),result=>bcd_temp_muls(0)(7 downto 0));
	bcd_adder: BCD4bit_adder port map(a=>"0000", b=>bcd_temp_muls(0)(3 downto 0),carry_in=>'0',result=>result(4*0+3 downto 4*0),carry_out=>temp_carry_out(0));
	

	generate_small_multipliers:
	for i in 1 to 7 generate
		small_multiplier_i: one_x_one_BCD_multiplier port map(A=>a(4*i+3 downto 4*i),B=>b(3 downto 0),result=>temp_muls(i)(7 downto 0));
		bin_to_bcd_i: Binary8bit_to_BCD8bit port map(a=>temp_muls(i)(7 downto 0),result=>bcd_temp_muls(i)(7 downto 0));
		bcd_adder_i: BCD4bit_adder port map(a=>bcd_temp_muls(i-1)(7 downto 4), b=>bcd_temp_muls(i)(3 downto 0),carry_in=>temp_carry_out(i-1),result=>result(4*i+3 downto 4*i),carry_out=>temp_carry_out(i));
	end generate generate_small_multipliers;
	
	bcd_adder_8: BCD4bit_adder port map(a=>bcd_temp_muls(8-1)(7 downto 4), b=>"0000",carry_in=>temp_carry_out(8-1),result=>result(4*8+3 downto 4*8),carry_out=>over_flow);
end structural;