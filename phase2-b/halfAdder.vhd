Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity HalfAdder is
	
	port(A, B: in std_logic;
	sum, carry_out: out std_logic);
	
end entity HalfAdder;

architecture behavioural of HalfAdder is
	
begin
	sum <= A xor B ;
	carry_out <= (A and B);
end architecture behavioural;
