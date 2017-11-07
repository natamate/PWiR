with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4Tree is
   type Node is
      record
         Data: Integer := 0;
         Left : access Node := Null;
         Right: access Node := Null;
      end record;

   type Node_Ptr is access all Node;

   type Wektor is array (Integer range <>) of Integer;

   procedure Pre_Order(Tree: access Node) is
   begin
      Put(Tree.Data,4);
      New_Line;
      if (Tree.Left /= Null) then
         Pre_Order(Tree.Left);
      end if;
      if (Tree.Right /= Null) then
            Pre_Order(Tree.Right);
      end if;
   end Pre_Order;


   procedure Show_Tree(Tree: access Node ) is
      Tmp : access Node := Tree;
   begin
      if (Tmp = Null) then
         Put_Line("Tree is empty");
         return;
      else
         Put_Line("Tree: ");
      end if;
         Pre_Order(Tmp);
   end Show_Tree;

   procedure Insert(Tree: in out Node_Ptr; D: in Integer) is
       E : Node_Ptr := new Node;
   begin
      if (Tree = Null) then
         E.all := (D, Null, Null);
         Tree := E;
         return;
      end if;

      if (D < Tree.Data) then
         Insert(Tree.Left, D);
      else
         Insert(Tree.Right, D);
      end if;
   end Insert;


   procedure InsertRandom(Tree: in out Node_Ptr; M: in Integer; N: in Integer) is
      subtype Num_Type is Integer range 0 .. M;
      package Random_Num is new Ada.Numerics.Discrete_Random(Num_Type);
      use Random_Num;
      Value : Integer := 0;
      Gen: Generator;
   begin
     Reset(Gen);
     for I in 1..N loop
       Value := Random(Gen);
       Insert(Tree, Value);
     end loop;

   end InsertRandom;

   function Search(Tree: access Node; X: in Integer) return Boolean is
      Tmp : access Node := Tree;
   begin
      if (Tmp = Null) then
         return false;
      end if;

      if (Tmp.Data = X) then
         return true;
      elsif (X < Tmp.Data) then
            return Search(Tmp.Left, X);
      else
            return Search(Tmp.Right, X);
      end if;

         return false;

   end Search;

   procedure Find_Predecessor(Tree: in out Node_Ptr; X: out Integer) is
   begin
      if (Tree.Right = NULL) then
         X := Tree.Data;
         Tree := Tree.Left;
      else
         Find_Predecessor(Tree.Right, X);
      end if;
   end Find_Predecessor;


   procedure Remove(Tree: in out Node_Ptr; X: in Integer) is
      begin
      if (X < Tree.Data) then
         Remove(Tree.Left, X);
      elsif (X > Tree.Data) then
         Remove(Tree.Right, X);
      else
         if (Tree.Left = NULL and Tree.Right = NULL) then
            Tree := NULL;
         elsif Tree.Right = NULL then
            Tree := Tree.Left;
         elsif Tree.Left = NULL then
            Tree := Tree.Right;
         else
            Find_Predecessor(Tree.Left, Tree.Data);
         end if;
      end if;
      EXCEPTION
        WHEN Constraint_Error =>     -- Obj not found in the given tree
        RETURN;
   end Remove;


   procedure Push(Tab: in out Wektor; Tree: in out Node_Ptr; Counter : in out Integer) is
   begin
      if (Tree = null) then return;
      end if;

      Push(Tab,Tree.Left, Counter);
      Tab(Counter) := Tree.Data;
      Counter := Counter + 1;
      Push(Tab,Tree.Right, Counter);

   end Push;

   procedure SortTab(Tab: in out Wektor) is
      Size: Integer := Tab'Length;
      Tmp: Integer;
   begin
      loop
         for I in 1 .. Size - 1 loop
            if (Tab(I) > Tab(I+1)) then
               Tmp := Tab(I);
               Tab(I) := Tab(I+1);
               Tab(I+1) := Tmp;
            end if;
         end loop;
         Size := Size -1 ;
         exit when (Size <= 1);
      end loop;

   end SortTab;

   function TreeSize(Tree: in out Node_Ptr) return Integer is
      X: Integer := 0;
   begin
      if (Tree = Null) then
         return 0;
      end if;

      return 1 + TreeSize(Tree.Left) + TreeSize(Tree.Right);
   end TreeSize;

   procedure BuildTree(Tree: in out Node_Ptr; Tab: in out Wektor; Start: in Integer; TheEnd: in Integer) is
   Mid: Integer;
   begin
      if (Start > TheEnd) then
         return;
      end if;
      Mid := ((Start+TheEnd)/2);
      insert(Tree, Tab(Mid));
      BuildTree(Tree.left, Tab, Start, Mid - 1);
      BuildTree(Tree.Right, Tab, Mid+1, TheEnd);

   end BuildTree;

   procedure BalancedTree(Tree: in out Node_Ptr) is
      Size: Integer := TreeSize(Tree)+1;
      W1 : Wektor (1..Size);
      Counter : Integer := 1;
   begin
      Push(W1,Tree,Counter);
      SortTab(W1);
      Tree := Null;
      BuildTree(Tree, W1, 1, Size-1);


   end BalancedTree;

   Tree : Node_Ptr := Null;

begin
   Show_Tree(Tree);
   InsertRandom(Tree, 10, 10);
   Show_Tree(Tree);
   Put_Line("Tree contains 1 : " & Search(Tree, 1)'Img);
   BalancedTree(Tree);
   Show_Tree(Tree);

 --  Remove(Tree,1);
 --  Show_Tree(Tree);
 --  Remove(Tree,3);
 --  Show_Tree(Tree);
 --  Remove(Tree,5);
 --  Show_Tree(Tree);
 --  Remove(Tree,6);
 --  Show_Tree(Tree);
 --  Put_Line("After remove tree contains 1 : " & Search(Tree, 1)'Img);

end Lab4Tree;
