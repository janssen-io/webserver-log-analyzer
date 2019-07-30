:- ['domain.pl'].
:- ['io.pl'].
:- ['known.pl'].

error(_, _, Status, _, _, _, _) :- Status >= 400.

unauthorized(401).
unauthorized(403).
notfound(404).
success(Status) :- Status >= 200 , Status < 300.

foreign(Country) :- Country \= "NL".
national(Country) :- Country = "NL".

virtual(Server) :- Server \= "_".

plist([]) :- false.
plist([X|Xs]) :-
    write_ln(X)
    , plist(Xs).

all_ip(Is) :-
    setof(
        Country-Ip
        , A^B^C^D^E^(l(A, Ip, B, C, D, E, Country))
        , Is).

high_risk(Server, Ip, Status, Uri) :-
    medium_risk(Server, Ip, Status, _, _, Uri, _),
    Uri \= "/",
    Uri \= "/minio/",
    \+ string_concat(_, ".gif", Uri),
    \+ string_concat("/themes/", _, Uri),
    \+ string_concat("/icons/", _, Uri),
    \+ string_concat("/.well-known/", _, Uri),
    \+ string_concat("/img/", _, Uri),
    Uri \= "/login".

medium_risk(Server, Ip, Status) :-
    low_risk(Server, Ip),
    success(Status).

low_risk(Server, Ip) :-
    l(Server, Ip, _, _, _, _, _)
    , unknown(Ip)
    , virtual(Server).

% use include/3, exlude/3, partition/4
filter(_, [], []).
filter(P, [X|Xs], [X|Ys]) :- call(P, X), filter(P, Xs, Ys), !.
filter(P, [_|Xs], Ys) :- filter(P, Xs, Ys).

% todo: build menu to load log files
o() :- read(F), consult(F).
