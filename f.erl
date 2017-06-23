-module(f).

-compile([export_all]).

main() ->
    io:format("~n Welcome to FLAMES Program ~n Play With Kabali !!! ~n Know Your Relationship Status ~n ~n"),    
	P = io:get_line(" Enter the boy name : "),
	Validation=name(P),
	Q = io:get_line(" Enter the boy name : "),	
	Validation1=name(Q),
	Check_alpha=check_alphabets(P),
	Check_alpha1=check_alphabets(Q),
	%io:format("~n P is ~p and Q is ~p ~n",[P,Q]),
	if
		Validation =:= 1 , Validation1 =:= 1 , Check_alpha =:= 1 , Check_alpha1 =:= 1 ->
		    P1=space(P),
			Q1=space(Q),
			pass(string:to_lower(P1),string:to_lower(Q1));
		true ->
			io:format("~n Sorry, Please Enter a Name in alphabets ~n")
	end.		
	
	
pass(P,Q) ->
	Boy_length=length(P),
	Girl_length=length(Q),
	Total=Boy_length+Girl_length,
	%io:format("~n Total size is ~p ~n",[Total]),
	Increment=0,
    check(P,P,Q,Q,Total,Increment).
	
check([],_P,_Q,_Q,Total,Increment) ->
	Final_Total=Total-Increment,
	%io:format("~n Final_Total is ~p ~n",[Final_Total]),
	iterate(Final_Total);

check([H|_T],P,Q,Q,Total,Increment) ->
    %io:format("~n inside check T is ~p ~n",[T]),
	remove(H,P,Q,Q,Total,Increment).
	

remove(_H,P,Q,[],Total,Increment) ->
  %io:format("~n after Q is empty ~n P is ~p ~n",[P]),
  [_H1|T1]=P,
  %io:format("~n T1 is ~p ~n",[T1]),
  check(T1,T1,Q,Q,Total,Increment);
  
	
remove(H,P,Q,[F|L],Total,Increment) ->
    %io:format("~n Before if P is ~p ~n",[P]),
	if 
		H =:= F ->
		    %io:format("~n H is ~c ~n F is ~c ~n",[H,F]),
		    P1=lists:delete(H,P),
			Q1=lists:delete(F,Q),
			Increment1=Increment+2,			
			%io:format("~n H is ~c ~n Increment is ~p ~n P1 is ~p ~n Q1 is ~p ~n",[H,Increment,P1,Q1]),
			check(P1,P1,Q1,Q1,Total,Increment1);
			
		H =/= F ->
		    %io:format("~n H is ~c ~n F is ~c ~n Increment is ~p ~n P is ~p ~n",[H,F,Increment,P]),			
			remove(H,P,Q,L,Total,Increment)
	end.
		
	

iterate(Num)->
	if 
		Num =:= 0 ->
			io:format("~n Both the name are same ~n"),
			iterate(Num,"flames",0);
		Num =/= 0 ->
			iterate(Num,"flames",0)
	end.

iterate(Num,List,Offset) ->
    if 
		List =:= ok ->
			ok;
		List =/= ok ->
			Length=length(List),
			Num2 = case((Num + Offset) rem Length) of
				0 ->
					Length;
				_ ->
					(Num + Offset) rem Length
				end,
			%io:format("~n Num2 is ~p and List is ~p ~n",[Num2,List]),
			List1=delete1(Num2,List),
			iterate(Num,List1,Num2 - 1)
	end.

delete1(N,List) ->
    Remstring=string:substr(List,N),
	if 
		Remstring =:= [] ->
			io:format(" ");
			
		Remstring =/= [] ->		
			[H|_T]=Remstring,
			%io:format("~n deleted string is  ~c ~n ",[H]),
			List2=lists:delete(H,List),
			%io:format("~n ~p ~n ",[List2]),
			L=length(List2),
			case L of 
				1 ->
					output(List2);
				_ ->
					List2
			end
	end.

	
output(A) ->
	%io:format("output is ~p",[A]),
	case A of
		"f" -> io:format("~n You Both are Friends ~n");
		"l" -> io:format("~n You Both are Lovers ~n ");
		"a" -> io:format("~n You Both are in Affection ~n");
		"m" -> io:format("~n You Both Will Marry ~n");
		"e" -> io:format("~n You Both are Enemies ~n");
		"s" -> io:format("~n She is Sister to You ~n")
	end.
	
	
name(A) ->
	try
		Z=list_to_integer(A),
		0
		catch
			_:_ ->	
				try 
					Z1=list_to_float(A),
						0
					catch
						_:_ ->
							1
			end
   end.
	
space(Y) ->	
	X1 = [ X || X <- Y,X =/= 32 ],
	X1.

check_alphabets([]) ->
  1;
	
check_alphabets([H|T]) ->
  if
     H > 64 , H < 91 ; H =:= 32 ; H =:= 10 -> 
					check_alphabets(T);
	 
	 H > 96 , H < 123 ; H =:= 32 ; H =:= 10 -> 
					check_alphabets(T);
	 true ->
		 0
  end. 
