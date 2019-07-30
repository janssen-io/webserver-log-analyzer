:- ['domain.pl'].

save(File, Records) :-
    csv_write_file(File, Records, []).
