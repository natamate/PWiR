%generacja losowych randomow
%budujemy bst
%te same warunki co w zadaniu w adzie
%zwyczajna - izi
%wyjatkowa - rzuca wyjatek - jak znajdziemy, wtedy nie musi cofac po kolei requrencji tylko wyjatek odrazu wraca
%ad w programie, 2. wyjatek powiazany z procesem - tzw exit, 3. through - wucany do komunikacji
% http://learnyousomeerlang.com/static/erlang/tree.erl

-module(lab5).
%-compile([export_all]).
-export([insertTree/2, isInTree/2, isInTreeThrowing/2, insertListToTree/2, preorder/1, inorder/1, postorder/1, insertXRandom/2]).


insertTree(Data,'nil') -> {Data,'nil','nil'};
insertTree(Data, {Val,Left,Right}) when Data < Val -> {Val,insertTree(Data,Left),Right};
insertTree(Data, {Val,Left,Right}) when Data > Val -> {Val,Left,insertTree(Data,Right)};
insertTree(_, {Val,Left,Right}) -> {Val,Left,Right}.

isInTree(_,'nil') -> false;
isInTree(Data,{Val,_,_}) when Data == Val -> true;
isInTree(Data,{Val,Left,_}) when Data < Val -> isInTree(Data,Left);
isInTree(Data,{Val,_,Right}) when Data > Val -> isInTree(Data,Right).

isInTreeExc(_,'nil') -> throw(false);
isInTreeExc(Data,{Val,_,_}) when Data == Val -> throw(true);
isInTreeExc(Data,{Val,Left,_}) when Data < Val -> isInTree(Data,Left);
isInTreeExc(Data,{Val,_,Right}) when Data > Val -> isInTree(Data,Right).

isInTreeThrowing(Data,Tree) ->
  try
    isInTreeExc(Data,Tree)
  catch
    throw:true -> 'true';
    throw:false -> 'false'
  end.

insertListToTree([],Tree) -> Tree;
insertListToTree([H|T],Tree) -> insertListToTree(T,insertTree(H,Tree)).

preorder('nil') -> [];
preorder({Val,Left,Right}) -> [Val]++preorder(Left)++preorder(Right).

inorder('nil') -> [];
inorder({Val,Left,Right}) -> inorder(Left)++[Val]++inorder(Right).

postorder('nil') -> [];
postorder({Val,Left,Right}) -> postorder(Left)++postorder(Right)++[Val].

insertRandom(Tree) -> insertTree(rand:uniform(99),Tree).

insertXRandom(0,Tree) -> Tree;
insertXRandom(N,Tree) -> insertXRandom(N-1,insertRandom(Tree)).
