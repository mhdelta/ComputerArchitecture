library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Processor is
    Port ( rst : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end Processor;

architecture Behavioral of Processor is

signal out_nPC: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal data_in: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal pc_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal im_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal seu_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal imm13_aux: STD_LOGIC_VECTOR(12 downto 0):=(others=>'0');--en formato3 
																--el inmmediato va del bit 0 al 12
																
signal crs1_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');			
signal crs2_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');		
signal mux_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');			
signal cpu_out: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');
signal alu_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');

COMPONENT PC
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;
		DAT_in : IN std_logic_vector(31 downto 0);          
		DAT_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Sumador
	PORT(
		operador1 : IN std_logic_vector(31 downto 0);
		operador2 : IN std_logic_vector(31 downto 0);          
		resultado : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT IM
	PORT(
		rst : in  STD_LOGIC;
		addr : IN std_logic_vector(31 downto 0);          
		data : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Mod5Seu
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		SEUimm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MUX
	PORT(
		Crs2 : IN std_logic_vector(31 downto 0);
		SEUimm13 : IN std_logic_vector(31 downto 0);
		i : IN std_logic;          
		Oper2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RF
	PORT(
		rst : in  STD_LOGIC;
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0); 
		dwr : IN std_logic_vector(31 downto 0); 		
		ORs1 : OUT std_logic_vector(31 downto 0);
		ORs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		Oper1 : IN std_logic_vector(31 downto 0);
		Oper2 : IN std_logic_vector(31 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);          
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT CU
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		aluop : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

begin

	Inst_PC: PC PORT MAP(
		rst => rst,
		clk => clk,
		DAT_in => out_nPC,
		DAT_out => pc_out
	);
	
	Inst_nPC: PC PORT MAP(
		rst => rst,
		clk => clk,
		DAT_in => data_in,
		DAT_out => out_nPC
	);
	
	Inst_Sumador: Sumador PORT MAP(
		operador1 => "00000000000000000000000000000001",
		operador2 => pc_out,
		resultado => data_in
	);
	
	Inst_IM: IM PORT MAP(
		rst => rst,
		addr => pc_out,
		data => im_out
	);
	
	Inst_SEU: Mod5Seu PORT MAP(
		imm13 => im_out(12 downto 0),
		SEUimm32 => seu_out
	);
	
	Inst_MUX: MUX PORT MAP(
		Crs2 => crs2_aux,
		SEUimm13 => seu_out,
		i => im_out(13),
		Oper2 => mux_out
	);
	
	Inst_RF: RF PORT MAP( 
		rst => rst,
		rs1 => im_out(18 downto 14),
		rs2 => im_out(4 downto 0),
		rd => im_out(29 downto 25),
		dwr => alu_out,
		ORs1 => crs1_aux,
		ORs2 => crs2_aux
	);
	
	Inst_ALU: ALU PORT MAP(
		Oper1 => crs1_aux,
		Oper2 => mux_out,
		ALUOP => cpu_out,
		Salida => alu_out
	);
	
	Inst_CU: CU PORT MAP(
		op => im_out(31 downto 30),
		op3 => im_out(24 downto 19),
		aluop => cpu_out
	);
	
data_out <= alu_out;

end Behavioral;
