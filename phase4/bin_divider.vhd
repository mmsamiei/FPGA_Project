library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all ;


entity bin_divider is 
	port(diviend : in std_logic_vector(31 downto 0);
		divisor : in std_logic_vector(15 downto 0);
		result : out std_logic_vector(15 downto 0);
		DVF : out std_logic);
end entity bin_divider;

architecture RTL of bin_divider is
signal A_sig,Q_sig,B_sig : std_logic_vector(15 downto 0);
begin
	A_sig <= diviend(31 downto 16);
	Q_sig <= diviend(15 downto 0);
	B_sig <= divisor;
	process(A_sig, B_sig, Q_sig)
	Variable A,Q,B : std_logic_vector(15 downto 0);
	variable SC : integer;
	variable Q_S : std_logic;
	variable E : std_logic;
	variable Temp : std_logic_vector(16 downto 0);
	variable Temp_33 : std_logic_vector(32 downto 0);
	

	begin
		A := A_sig;
		B := B_sig;
		Q := Q_sig;
		--
		Q_S := A(15) xor B(15);
		SC := 16;
		Temp := ('1'&A)-('0'&B);
		E := temp(16);
		A := temp(15 downto 0);
		if(E = '1')then
			-- overflow !
			DVF <= '1';
			Temp := ('1'&A)+('0'&B);
			E := temp(16);
			A := temp(15 downto 0);
		else
			DVF <= '0';
			Temp := ('1'&A)+('0'&B);
			E := temp(16);
			A := temp(15 downto 0);
			-- now to right
			Temp_33 := E & A & Q;
			Temp_33 := Temp_33(31 downto 0) & '0';
			E := Temp_33(32);
			A := Temp_33(31 downto 16);
			Q := Temp_33(15 downto 0);
			--
			if(E = '0')then
				Temp := ('1'&A)-('0'&B);
				E := temp(16);
				A := temp(15 downto 0);
				if(E='1')then
					Q(0) := '1';
				else
					Temp := ('1'&A)+('0'&B);
					E := temp(16);
					A := temp(15 downto 0);
				end if;
			else
				A := A - B ;
				Q(0) := '1'; 
			end if;
			SC := SC - 1;
			
			while(SC /= 0)loop
				Temp_33 := E & A & Q;
				Temp_33 := Temp_33(31 downto 0) & '0';
				E := Temp_33(32);
				A := Temp_33(31 downto 16);
				Q := Temp_33(15 downto 0);
				--
				if(E = '0')then
					Temp := ('1'&A)-('0'&B);
					E := temp(16);
					A := temp(15 downto 0);
					if(E='1')then
						Q(0) := '1';
					else
						Temp := ('1'&A)+('0'&B);
						E := temp(16);
						A := temp(15 downto 0);
					end if;
				else
					A := A - B ;
					Q(0) := '1'; 
				end if;
				SC := SC - 1;
			end loop;
			result <= Q;
		end if;
	end process;
end architecture RTL;
