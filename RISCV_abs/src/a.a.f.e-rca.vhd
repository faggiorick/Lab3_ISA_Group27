library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity RCA is 
	generic(N     :    integer := data_size); 
	Port(
		A	: In	std_logic_vector(N-1 downto 0);
		B	: In	std_logic_vector(N-1 downto 0);
		Ci	: In	std_logic;
		S	: Out	std_logic_vector(N-1 downto 0);
		Co	: Out	std_logic);
end RCA; 

architecture STRUCTURAL of RCA is

  signal STMP : std_logic_vector(N-1 downto 0);	-- sum temp
  signal CTMP : std_logic_vector(N downto 0);	-- carry temp

  component FA is
  Port( A:	In	std_logic;
	 	B:	In	std_logic;
	 	Ci:	In	std_logic;
	 	S:	Out	std_logic;
	 	Co:	Out	std_logic);
  end component; 

begin

	CTMP(0) 	<= Ci;		-- carry in -> carry temp LSB
	S 		<= STMP;
	Co 		<= CTMP(N);	-- carry out -> carry temp MSB
	  
	ADDER1: for I in 1 to N generate
		FAI : FA 
			Port Map (A(I-1), B(I-1), CTMP(I-1), STMP(I-1), CTMP(I)); 
	end generate;

end STRUCTURAL;


