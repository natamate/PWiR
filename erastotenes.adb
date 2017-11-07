with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random, Lista, Ada.Numerics.Elementary_Functions;
use Ada.Text_IO, Ada.Integer_Text_IO, Lista;

procedure Erastotenes is


N: Integer;
   Sq : Integer;
   W: Integer;
   Sign: Character;
Sito : Elem_Ptr := Null;

begin
   Put_Line("Please put a natural number");
   N := Integer'Value(Get_Line);
   for I in 1..N loop
      Insert(Sito, I);
   end loop;

   Sq := Integer(Ada.Numerics.Elementary_Functions.Sqrt(Float(N)));
   for I in 2 .. Sq loop
      if (Contains(Sito, I)) then
         W := I*I;
         while (W <= N) loop
            Remove(Sito, W);
            W := W + I;
         end loop;
      end if;
   end loop;

   Show(Sito);

   Put_Line("Press the Key to end");
   Get_Immediate (Sign);
end Erastotenes;

