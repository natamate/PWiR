-- zadania1.adb

with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure Zad6_1 is
	
task Zadanie_A is
	entry Start;
	entry Koniec;
end Zadanie_A;  

task Zadanie_B is
	entry Start;
end Zadanie_B;

function GenericN(I:Integer) return Float is
     subtype Num_Type is Integer range 0 .. 5;
     package Random_Num is new Ada.Numerics.Discrete_Random(Num_Type);
     use Random_Num;
     Wart : Float := 0.0;
     Gen: Generator;
begin
   Reset(Gen);
   Wart := Float(Random(Gen));
   return Wart;
end GenericN;

task body Zadanie_A is	
begin
  accept Start;
  Put_Line("Random= " & GenericN(1)'Img);
  accept Koniec;
  Put_Line("Koncze");
end Zadanie_A;

task body Zadanie_B is	
begin
  accept Start;
  loop
	  Zadanie_A.Start;
          delay(1.0);
          Zadanie_A.Koniec;
  end loop;	  
  Zadanie_A.Koniec;
end Zadanie_B;

begin
  Put("P_PG ");
  Zadanie_B.Start;
   --Zadanie_B.Start;
  Put("K_PG ");  
end Zad6_1;
	  	
