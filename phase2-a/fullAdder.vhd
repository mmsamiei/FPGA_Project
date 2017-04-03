Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FullAdder is
	
	port(A, B, carry_in: in std_logic;
	sum, carry_out: out std_logic);
	
end entity FullAdder;

architecture behavioural of FullAdder is
	
begin
	sum <= A xor B xor carry_in;
	carry_out <= (A and B) or (A and carry_in) or (B and carry_in);
end architecture behavioural;
