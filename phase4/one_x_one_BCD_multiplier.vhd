Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity one_x_one_BCD_multiplier is
	
	port(A, B: in std_logic_vector (3 downto 0);
	result: out std_logic_vector (7 downto 0));
	
end entity one_x_one_BCD_multiplier;

architecture structural of one_x_one_BCD_multiplier is
	
	component HalfAdder is
        port(A, B: in std_logic;
			sum, carry_out: out std_logic);
    end component;
	
	component FullAdder is 
		port(A, B, carry_in: in std_logic;
			sum, carry_out: out std_logic);
	end component;
	
	component two_x_two_multiplier is
		port(A, B: in std_logic_vector (1 downto 0);
			result: out std_logic_vector (3 downto 0));
	end component;
	
	
	
	signal s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34:std_logic;
	begin
		Multiplier_1: two_x_two_multiplier port map(A(0)=>B(0),A(1)=>B(1),B(0)=>A(0),B(1)=>A(1),result(0)=>s1,result(1)=>s2,result(2)=>s3,result(3)=>s4);
		Multiplier_2: two_x_two_multiplier port map(A(0)=>B(0),A(1)=>B(1),B(0)=>A(2),B(1)=>A(3),result(0)=>s5,result(1)=>s6,result(2)=>s7,result(3)=>s8);
		Multiplier_3: two_x_two_multiplier port map(A(0)=>B(2),A(1)=>B(3),B(0)=>A(0),B(1)=>A(1),result(0)=>s9,result(1)=>s10,result(2)=>s11,result(3)=>s12);
		Multiplier_4: two_x_two_multiplier port map(A(0)=>B(2),A(1)=>B(3),B(0)=>A(2),B(1)=>A(3),result(0)=>s13,result(1)=>s14,result(2)=>s15,result(3)=>s16);
		Adder_1: FullAdder port map(A=>s3,B=>s5,carry_in=>s9,sum=>s17,carry_out=>s18);
		Adder_2: FullAdder port map(A=>s4,B=>s6,carry_in=>s10,sum=>s19,carry_out=>s20);
		Adder_3: FullAdder port map(A=>s20,B=>s7,carry_in=>s11,sum=>s21,carry_out=>s22);
		Adder_4: HalfAdder port map(A=>s18,B=>s19,sum=>s23,carry_out=>s24);
		Adder_5: FullAdder port map(A=>s24,B=>s21,carry_in=>s13,sum=>s25,carry_out=>s26);
		Adder_6: FullAdder port map(A=>s22,B=>s8,carry_in=>s12,sum=>s27,carry_out=>s28);
		Adder_7: FullAdder port map(A=>s28,B=>s30,carry_in=>s15,sum=>s31,carry_out=>s32);
		Adder_8: FullAdder port map(A=>s26,B=>s27,carry_in=>s14,sum=>s29,carry_out=>s30);
		Adder_9: HalfAdder port map(A=>s32,B=>s16,sum=>s33,carry_out=>s34);
		result(7 downto 0) <= (s33,s31,s29,s25,s23,s17,s2,s1); 
		
end architecture structural;