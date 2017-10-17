-module(nacia).
-compile([export_all]).

mapa() -> #{"a"=> 1, "b"=> 2, "c"=> 3}.

map_append(Key, Value, Map) -> Map#{Key => Value}.

map_update(Key,Value,Map) -> Map#{Key := Value}.

map_append_or_update(Key, Map) ->
	case maps:is_key(Key,Map) of
		true -> 
			Value = maps:get(Key, Map),
			map_update(Key, Value + 1, Map);
		false -> 
			map_append(Key, 1, Map)
	end.
			
map_add([], Map) -> Map;
map_add([H|T], Map) ->
	UpdatedMap = map_append_or_update(H, Map), 
	map_add(T, UpdatedMap).
			
map_display(Map) -> list_display(maps:to_list(Map)).

list_display([]) -> io:write("");
list_display([{K,V}|T]) -> 
	io:format(" ~p => ~w ~n", [K,V]), 
	list_display(T).
	
read_file(FileName) ->
	{_,Text} = file:read_file(FileName),
	Text.
	
map_file(FileName, Map) ->
	Text = read_file(FileName),
	String = binary_to_list(Text),
	%Separators = [' ', "\n", ",", "."],
	Separators = " ,.\n",
	ListOfWords = string:tokens(String, Separators),
	map_add(ListOfWords,Map).
	
map_wildcard([], Map) -> Map; 	
map_wildcard([H|T], Map) -> 
	UpdatedMap = map_file(H, Map),
	map_wildcard(T, UpdatedMap).
	
map_alus([], Map, _) -> Map;
map_alus([H|T], Map, BigMap) ->
	UpdatedMap = map_file(H, Map),
	NewBigMap = map_add(H, UpdatedMap),
	map_alus(T, UpdatedMap, NewBigMap).
