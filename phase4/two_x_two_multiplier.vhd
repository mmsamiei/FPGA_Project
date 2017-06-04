Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity two_x_two_multiplier is
	
	port(A, B: in std_logic_vector (1 downto 0);
	result: out std_logic_vector (3 downto 0));
	
end entity two_x_two_multiplier;

architecture structural of two_x_two_multiplier is
	
	component HalfAdder is
        port(A, B: in std_logic;
			sum, carry_out: out std_logic);
    end component;
	
	signal result_signal:std_logic_vector(3 downto 0);
	signal temp_one,temp_two,temp_three:std_logic;-- for saving product of multiplication of terms
	signal medial_carry_out : std_logic;

	begin
		result_signal(0)<=A(0)and B(0);
		temp_one <= A(1) and B(0);
		temp_two <= A(0) and B(1);
		temp_three <= A(1) and B(1);
		half_adder_1: HalfAdder port map(A=> temp_one, B=> temp_two, sum=>result_signal(1), carry_out=>medial_carry_out);
		half_adder_2: HalfAdder port map(A=> medial_carry_out, B=> temp_three, sum=> result_signal(2), carry_out=>result_signal(3));
		result<= result_signal;
end architecture structural;
