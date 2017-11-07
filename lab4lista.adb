with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4Lista is

type Element is
  record
    Data : Integer := 0;
    Next : access Element := Null;
  end record;

type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:");
  end if;
  while L /= Null loop
    Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
    New_Line;
    L := L.Next;
  end loop;
end Print;

procedure Insert(List : in out Elem_Ptr; D : in Integer) is
  E : Elem_Ptr := new Element;
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List);
  List := E;
end Insert;

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is
  ( new Element'(D,List) );

-- do napisania !!
procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is
      Tmp : Elem_Ptr;
      E : Elem_Ptr := new Element;
   begin
      -- spr head
   if (List.Data > D) then
         E.all := (D, List);
         List := E;
         return;
   end if;

   Tmp := List;
   while (Tmp.Next /= Null) loop
      if (Tmp.Next.Data > D) then
        E.all := (D, Tmp.Next);
        Tmp.Next := E;
        exit;
      end if;

         Tmp := Tmp.Next;
         if (Tmp.Next = Null) then
            E.all := (D, Null);
            Tmp.Next := E;
            exit;
         end if;

   end loop;

end Insert_Sort;


procedure GenericN(List : in out Elem_Ptr; N : in Integer; M: in Integer) is
     subtype Num_Type is Integer range 0 .. M;
     package Random_Num is new Ada.Numerics.Discrete_Random(Num_Type);
     use Random_Num;
     Wart : Integer := 0;
     Gen: Generator;
begin
   Reset(Gen);
     for I in 1..N loop
       Wart := Random(Gen);
       Insert_Sort(List, Wart);
     end loop;
end GenericN;


   function If_Contains(List : in out Elem_Ptr; X: in Integer) return Boolean is
      Tmp: Elem_Ptr;
   begin
      if (List.Data = X) then
         return true;
      end if;

      Tmp := List;
      while (Tmp.Next /= Null) loop
         if (Tmp.Next.Data = X) then
            return true;
         end if;

         Tmp := Tmp.Next;
      end loop;

      return false;
   end If_Contains;


   procedure Remove_Elem (List: in out Elem_Ptr; X: in Integer) is
      Tmp: Elem_Ptr;
   begin
      if (List.Data = X) then
         List := List.Next;
         return;
      end if;

      Tmp := List;
      while (Tmp.Next /= Null) loop
         if (Tmp.Next.Data = X) then
            Tmp.Next := Tmp.Next.Next;
            return;
         end if;
         Tmp := Tmp.Next;
      end loop;

   end Remove_Elem;

   function  ListLength(List: in out Elem_Ptr) return Integer is
      Tmp: Elem_Ptr;
      Length : Integer := 0;
   begin
      Tmp := List;
      while (Tmp /= Null) loop
         Length := Length + 1;
         Tmp := Tmp.Next;
      end loop;

      return Length;
   end ListLength;


Lista : Elem_Ptr := Null;

begin
  Print(Lista);
  Lista := Insert(Lista, 21);
  Print(Lista);
  Insert_Sort(Lista, 20);
  Print(Lista);
  for I in reverse 1..12 loop
  Insert_Sort(Lista, I);
  end loop;
  GenericN(Lista,10,30);
  Print(Lista);

   Put_Line("List contains 20: " & If_Contains(Lista,20)'Img);
   Remove_Elem(Lista, 20);
   Put_Line("After remove List contains 20: " & If_Contains(Lista,20)'Img);
end Lab4Lista;
