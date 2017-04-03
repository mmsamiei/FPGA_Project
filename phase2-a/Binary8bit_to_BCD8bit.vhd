library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;




entity Binary8bit_to_BCD8bit is
	port(a: in std_logic_vector(7 downto 0);	--binary
		result : out std_logic_vector(7 downto 0));		--BCD
end entity Binary8bit_to_BCD8bit;

architecture temporary of Binary8bit_to_BCD8bit is 

procedure get_ones
 (a, decimal : in integer;
  signal ones : out integer) is 
begin
  ones <= a - 10*decimal;
end get_ones;

signal integer_value : integer;
signal Decimal : integer;
signal Ones : integer;
signal decimal_bcd : std_logic_vector(3 downto 0);
signal ones_bcd : std_logic_vector(3 downto 0);

begin 
	integer_value <= to_integer(unsigned(a));
		Decimal <= 
		0 when integer_value >= 0 and integer_value < 10 else 
		1 when integer_value > 10 and integer_value < 20 else 
		2 when integer_value > 20 and integer_value < 30 else 
        3 when integer_value > 30 and integer_value < 40 else 
		4 when integer_value > 40 and integer_value < 50 else 
		5 when integer_value > 50 and integer_value < 60 else 
		6 when integer_value > 60 and integer_value < 70 else 
		7 when integer_value > 70 and integer_value < 80 else 
		8 when integer_value > 80 and integer_value < 90 else
		9 when integer_value > 90 and integer_value < 100 else
		10 when integer_value > 100 else		
        10;
		
		get_ones(integer_value,decimal,ones);
		decimal_bcd <= std_logic_vector(to_unsigned(decimal, 4));
		ones_bcd <= std_logic_vector(to_unsigned(ones, 4));
		result(7 downto 4)<=decimal_bcd;
		result(3 downto 0)<=ones_bcd;
		
end architecture temporary;

