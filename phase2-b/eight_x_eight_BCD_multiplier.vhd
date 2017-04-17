library IEEE;
use IEEE.std_logic_1164.all;

entity eight_x_eight_BCD_multiplier is
    port(
            A,B: in std_logic_vector(31 downto 0);
			clk : in std_logic;
            result: out std_logic_vector(63 downto 0)
        );
end entity;

architecture combinational of eight_x_eight_BCD_multiplier is

component eight_x_one_BCD_multiplier is
	port(
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(3 downto 0);
		result : out std_logic_vector(35 downto 0)
	);
end component eight_x_one_BCD_multiplier;

component BCD4bit_adder is
	port(a: in std_logic_vector(3 downto 0);	
		b : in std_logic_vector(3 downto 0);
		carry_in : in std_logic;
		result : out std_logic_vector(3 downto 0);
		carry_out : out std_logic );
end component BCD4bit_adder;

component BCD16digit_adder is
	port(a: in std_logic_vector(63 downto 0);	
		b : in std_logic_vector(63 downto 0);
		result : out std_logic_vector(63 downto 0) );
end component BCD16digit_adder;

type mul_8x1_type is array (7 downto 0) of std_logic_vector(63 downto 0);
signal temp_muls : mul_8x1_type := (others => (others => '0'));
signal temp_sums : mul_8x1_type := (others => (others => '0'));
signal temp_sums_L2 : mul_8x1_type := (others => (others => '0'));
begin
	GEN_MULS: for i in 0 to 7 generate
		mul8x1_i : eight_x_one_BCD_multiplier port map (a=>A,b=>B(4*i+3 downto 4*i),result=>temp_muls(i)(4*i+35 downto 4*i));
	end generate GEN_MULS;
	
	GEN_SUMS_Level1:
	for i in 0 to 3 generate
	adder_i_L0 : BCD16digit_adder port map(a=>temp_muls(2*i),b=>temp_muls(2*i+1),result=>temp_sums(i));
	end  generate GEN_SUMS_Level1;
	
	GEN_SUMS_Level2:
	for i in 0 to 1 generate
	adder_i_L1 : BCD16digit_adder port map(a=>temp_sums(2*i),b=>temp_sums(2*i+1),result=>temp_sums_L2(i));
	end  generate GEN_SUMS_Level2;
	
	adder_L2 : BCD16digit_adder port map(a=>temp_sums_L2(0),b=>temp_sums_L2(1),result=>result);
	
end architecture combinational;

architecture sequential of eight_x_eight_BCD_multiplier is

component eight_x_one_BCD_multiplier is
	port(
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(3 downto 0);
		result : out std_logic_vector(35 downto 0)
	);
end component eight_x_one_BCD_multiplier;

component BCD16digit_adder is
	port(a: in std_logic_vector(63 downto 0);	
		b : in std_logic_vector(63 downto 0);
		result : out std_logic_vector(63 downto 0) );
end component BCD16digit_adder;

signal temp_result : std_logic_vector(63 downto 0):= (others => '0');
signal temp_mul : std_logic_vector(63 downto 0):= (others => '0');
signal temp_sum : std_logic_vector(63 downto 0):= (others => '0');
signal temp_B : std_logic_vector(31 downto 0) := (others => '0');

signal test : integer := 0 ;

begin
	mul8x1_i : eight_x_one_BCD_multiplier port map (a=>A,b=>temp_B(31 downto 28),result=>temp_mul(35 downto 0));
	sum8dig : BCD16digit_adder port map(a=>temp_result,b=>temp_mul,result=>temp_sum);
	process(A,B,clk)
	variable i : integer := 0 ;
	variable j : integer := 0 ;
	begin
		if(rising_edge(clk))then
			if ( i = 0 )then
				temp_B <= B ; 
				test <= 2 ;
			end if;
			
			if( j = 0 )then
				temp_result <= temp_result(59 downto 0) & "0000";
				j := j +1 ;
				test <= 3 ;
			elsif( j = 1 )then
				temp_result <= temp_sum;
				j := j +1 ;
				test <= 4 ;
			elsif ( j = 2)then
				temp_B <= temp_B(27 downto 0) & "0000"; -- eslaeh counter be jaye tempB
				j := 0 ;
				test <= 5 ;
				i := i + 1;
			end if;

		
		if ( i = 8 )then
			result <= temp_result;
		end if ;
		end if;
	end process;
end architecture sequential;
