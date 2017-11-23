-- Napisz  obsługę bufora wieloelementowego (N) na typie chronionym do komunikacji Producent-Konsument. Zastosuj bufor do komunikacji Prod-Kons.
with Ada.Text_IO;
use Ada.Text_IO;

procedure Lab7_1 is

type TBuf is array (Integer range <>) of Character;

protected type Buf(Size : Integer) is
	entry Put(Sign : in Character);
	entry Get(Sign : out Character);

 	private
 		B : TBuf(1..Size);
 		Counter  : Integer:=0;
 		IndexPut   : Integer:=1;
 		IndexGet : Integer:=1;
end Buf;


protected body Buf is
entry Put(Sign : in Character)
when Counter<Size is begin
	B(IndexPut) := Sign;
	IndexPut := IndexPut+1;
	Counter := Counter+1;
end Put;

entry Get(Sign: out Character)
when Counter>0 is begin
	IndexGet := IndexPut;
	Counter := Counter - 1;
	IndexPut := IndexPut - 1;
	Sign := B(IndexGet);
end Get;
end Buf;

Buforek: Buf(5);

task Producent; 

task body Producent is
  Cl : Character := 's';
begin  
  Put_Line("$ wstawiam: znak = '" & Cl & "'");
  Buforek.Put(Cl);
  Put_Line("$ wstawiłem...");
end Producent;

task Konsument; 

task body Konsument is
  Cl : Character := ' ';
begin  
  Put_Line("# pobiorę...");
  Buforek.Get(Cl);
  Put_Line("# pobrałem: znak = '" & Cl & "'");
end Konsument;

begin
	Put_Line("Lab7_1 main procedure");
	
end Lab7_1;
