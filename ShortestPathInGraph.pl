% The definition of a graph.
edge(a, d, 50).
edge(b, c, 90).
edge(d, f, 60).
edge(f, e, 70).
edge(f, b, 80).
edge(c, b, 120).
edge(e, b, 90).
edge(e, c, 20).
edge(d, c, 60).
edge(f, a, 100).

% Defining a rule that finds the shortest path in a graph.
shortest_path(Start, End, Path, Distance) :-
    dijkstra([(0, Start)], End, [], Path, Distance).

% Dijkstra's rule is used to find the shortest path in a graph.
dijkstra([(Dist, End)|_], End, Visited, Path, Dist) :-
    reverse([End|Visited], Path).
dijkstra([(Dist, Curr)|Rest], End, Visited, Path, Distance) :-
    member((Dist, Curr), Visited) ->
        dijkstra(Rest, End, Visited, Path, Distance);
        findall((NewDist, Next), (
            edge(Curr, Next, EdgeDistance),
            \+ member((_, Next), Visited),
            NewDist is Dist + EdgeDistance
        ), NextList),
        append(Rest, NextList, Queue),
        sort(Queue, QueueSorted),
        dijkstra(QueueSorted, End, [(Dist, Curr)|Visited], Path, Distance).


% Query execution
?- shortest_path(a, b, Path, Distance).