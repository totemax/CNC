--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:46:38 05/24/2016
-- Design Name:   
-- Module Name:   C:/Users/Kovac/Documents/XilinxP/Assembler/test_assembler.vhd
-- Project Name:  Assembler
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Assembler
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_assembler IS
END test_assembler;
 
ARCHITECTURE behavior OF test_assembler IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Assembler
    PORT(
         clk, reset: in std_logic;
			  brec : in  std_logic_vector (7 downto 0);
           rec_pending : in  std_logic;
           btrans : out   std_logic_vector(7 downto 0);
           tstart : out  std_logic;
           t_done, order_done : in  std_logic;
			  rec_done : out  std_logic;
           instruccion : out  std_logic_vector (1 downto 0);
           datox : out  std_logic_vector (7 downto 0);
           datoy : out  std_logic_vector (7 downto 0);
           datoz : out  std_logic_vector (7 downto 0);
			  order_pending: out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Brec : std_logic_vector(7 downto 0) := (others => '0');
   signal rec_pending : std_logic := '0';
   signal t_done : std_logic := '0';
	signal reset : std_logic := '0';
	signal order_pending : std_logic := '0';

 	--Outputs
   signal Btrans : std_logic_vector(7 downto 0);
   signal Tstart : std_logic;
   signal rec_done : std_logic;
   signal Instruccion : std_logic_vector(1 downto 0);
   signal DatoX : std_logic_vector(7 downto 0);
   signal DatoY : std_logic_vector(7 downto 0);
   signal DatoZ : std_logic_vector(7 downto 0);
	signal order_done : std_logic;
--   signal DatoRadio : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Assembler PORT MAP (
          clk => clk,
          Brec => Brec,
          rec_pending => rec_pending,
          Btrans => Btrans,
          Tstart => Tstart,
          t_done => t_done,
          rec_done => rec_done,
          Instruccion => Instruccion,
          DatoX => DatoX,
          DatoY => DatoY,
          DatoZ => DatoZ,
			 order_pending => order_pending,
			 reset => reset,
			 order_done => order_done
--          DatoRadio => DatoRadio
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rec_pending<='1';
      wait for 10 ns;
		rec_pending<='0';
		brec<="01010011"; --instruc
		wait for 10 ns;
		rec_pending<='1';
		wait for 10 ns;
		rec_pending<='0';
		wait for 10 ns;
		brec<="00110000";
		wait for 30 ns;
		brec<="00110000"; --x
		wait for 30 ns;
		brec<="00110000";
		wait for 30 ns;
		rec_pending<='1';
		wait for 10 ns;
		
				
		wait for 50 ns;
		order_done <= '1';
		
		
		brec<="00000000";
		wait for 30 ns;
		rec_pending<='0';
		brec<="00110001";
		wait for 30 ns;
		brec<="00110001"; --y
		wait for 30 ns;
		brec<="00110001";		
		wait for 30 ns;
		
		rec_pending<='1';
		brec<="00000000";
		wait for 30 ns;
		
		rec_pending<='0';
		brec<="00110011";
		wait for 30 ns;
		brec<="00110011"; --z
		wait for 30 ns;
		brec<="00110011";
		wait for 30 ns;
		rec_pending<='1';
		
      wait for clk_period*10;

      -- insert stimulus here 
		assert false report "Fin test" severity failure;

      wait;
   end process;

END;