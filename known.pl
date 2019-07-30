:- dynamic known(_).

local(Ip) :- atom_prefix(Ip, "192.168.178.").

known(Ip) :- local(Ip).
unknown(Ip):- not(known(Ip)).
