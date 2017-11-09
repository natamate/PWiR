-module(lab5).
-compile([export_all]).

% wstawianie elementu do drzewa
insertTree(Value, nil) -> {Value, nil, nil};
insertTree(Value, {Data, Left, Right}) when Value < Data -> {Data, insertTree(Value, Left), Right};
insertTree(Value, {Data, Left, Right}) when Value > Data -> {Data, Left, insertTree(Value, Right)};
insertTree(_, {Data, Left, Right}) -> {Data, Left, Right}.

%generacja losowego drzewa (liczby)
insertRandom(Tree) -> insertTree(rand:uniform(99),Tree).

insertXRandom(Tree, 0) -> Tree;
insertXRandom(Tree, N) -> insertXRandom(insertRandom(Tree), N-1).

%generacja drzewa z listy
listToTree([],Tree) -> Tree;
listToTree([H|T], Tree) -> listToTree(T, insertTree(H,Tree)).

%zwinięcie drzewa do listy (3 dowolne metody)

preOrder(nil) -> [];
preOrder({Data,Left,Right}) -> [Data] ++ preOrder(Left) ++ preOrder(Right).

inOrder(nil) -> [];
inOrder({Data,Left,Right}) ->  inOrder(Left) ++ [Data] ++ inOrder(Right).

postOrder(nil) -> [];
postOrder({Data,Left,Right}) -> postOrder(Left) ++ postOrder(Right) ++ [Data].

%szukanie elementu w drzewie (wersja "zwyczajna" i wersja "wyjątkowa")
searchX(_, nil) -> false;
searchX(X, {X, _, _}) -> true;
searchX(X, {OtherX, Left, _}) when X < OtherX -> searchX(X, Left);
searchX(X, {OtherX, _, Right}) when X > OtherX -> searchX(X, Right).

ifTreeContains(_, nil) -> throw(false);
ifTreeContains(X, {X, _, _}) -> throw(true);
ifTreeContains(X, {OtherX, Left, _}) when X < OtherX -> ifTreeContains(X, Left);
ifTreeContains(X, {OtherX, _, Right}) when X > OtherX -> ifTreeContains(X, Right).

searchXTry(X, Tree) ->
	try 
		ifTreeContains(X, Tree)
	catch
		throw:true -> 'true';
		throw:false -> 'false'
	end.




