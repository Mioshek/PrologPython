% three_biggest_one_digit(+Lista, -Wynik)
% Dla danej listy liczb (Lista), ten predykat zwraca trzy największe liczby jednocyfrowe w liście wynikowej (Wynik).
% Jako argumenty przyjmuje Listę liczb i zwraca Listę trzech największych liczb jednocyfrowych.
three_biggest_one_digit([], []).  
three_biggest_one_digit([X], [X]) :-
    is_one_digit(X).
three_biggest_one_digit(Lista, Wynik) :-
    filter_one_digit(Lista, JednoCyfrowe),
    remove_duplicates(JednoCyfrowe, UnikalneJednoCyfrowe),
    sort(UnikalneJednoCyfrowe, Posortowane),
    reverse(Posortowane, Malejaco),
    take_first_three(Malejaco, WynikMalejaco),
    reverse(WynikMalejaco, Wynik),
    !.

% Predykat filter_one_digit(+Lista, -Przefiltrowane)
% Dla danej listy liczb (Lista), ten predykat filtruje tylko liczby jednocyfrowe
% i zwraca je w przefiltrowanej liście.
filter_one_digit([], []).  
filter_one_digit([X | Reszta], Przefiltrowane) :-
    is_one_digit(X),
    filter_one_digit(Reszta, PrzefiltrowaneReszta),
    append([X], PrzefiltrowaneReszta, Przefiltrowane).
filter_one_digit([_ | Reszta], Przefiltrowane) :-
    filter_one_digit(Reszta, Przefiltrowane).

% remove_duplicates_acc(+Lista, +Akumulator, -Wynik)
% Predykat pomocniczy dla remove_duplicates/2. Usuwa zduplikowane elementy z listy.
remove_duplicates_acc([], Akumulator, Akumulator).  
remove_duplicates_acc([X | Reszta], Akumulator, Wynik) :-
    member(X, Akumulator),
    remove_duplicates_acc(Reszta, Akumulator, Wynik).
remove_duplicates_acc([X | Reszta], Akumulator, Wynik) :-
    \+ member(X, Akumulator),
    append(Akumulator, [X], ZaktualizowanyAkumulator),
    remove_duplicates_acc(Reszta, ZaktualizowanyAkumulator, Wynik).

% remove_duplicates(+Lista, -Wynik)
% Dla danej listy liczb (Lista), ten predykat usuwa zduplikowane elementy i
% zwraca wynikową listę w Wyniku.
remove_duplicates(Lista, Wynik) :-
    remove_duplicates_acc(Lista, [], Wynik).

% take_first_three_acc(+Lista, +Akumulator, -Wynik)
% Predykat pomocniczy dla take_first_three/2. Pobiera pierwsze trzy elementy z listy.
take_first_three_acc(_, Wynik, Wynik) :-
    length(Wynik, 3),
    !.  % Zakończ rekurencję, gdy długość akumulowanej listy wynosi 3.
take_first_three_acc([X | Reszta], Akumulator, Wynik) :-
    append(Akumulator, [X], ZaktualizowanyAkumulator),
    take_first_three_acc(Reszta, ZaktualizowanyAkumulator, Wynik).

% take_first_three(+Lista, -Wynik)
% Dla danej listy liczb (Lista), ten predykat pobiera pierwsze trzy elementy
% i zwraca je w liście Wynik.
take_first_three(Lista, Wynik) :-
    take_first_three_acc(Lista, [], Wynik).

% is_one_digit(+Liczba)
% Predykat sprawdzający, czy liczba jest jednocyfrowa.
is_one_digit(Liczba) :-
    number(Liczba),
    Liczba >= 0,
    Liczba < 10.

% is_one_digit(+Liczba)
% Predykat sprawdzający, czy liczba jest dwucyfrowa.
is_two_digit(Number) :-
    Number >= 10,
    Number < 100.

%Predykat divisible_by_all sprawdza, czy dana liczba jest podzielna przez wszystkie elementy listy dzielników.
% Iteruje przez każdy dzielnik na liście i zapewnia, że wynik operacji modulo (`Number mod Divider`) wynosi 0 dla każdego dzielnika.
divisible_by_all(Number, Dividers) :-
    forall(member(Divider, Dividers), 0 is Number mod Divider).

% filter_numbers(+Liczby, +Dzielniki, -Wynik)
% Dla danej listy liczb (Liczby) i listy dzielników (Dzielniki), ten predykat zwraca listę liczb z Liczby,
% które są podzielne przez wszystkie elementy z Dzielniki.
filter_numbers(Liczby, Dzielniki, Wynik) :-
    findall(Liczba, (member(Liczba, Liczby), is_two_digit(Liczba), divisible_by_all(Liczba, Dzielniki)), Wynik).

% first_n_elements(+Lista, +N, -Wynik)
% Zwraca pierwsze N elementów z danej listy (Lista) w Wyniku.
first_n_elements(_, 0, []).  
first_n_elements([H | T], N, [H | Wynik]) :-
    N > 0,
    NoweN is N - 1,
    first_n_elements(T, NoweN, Wynik).

% main(+Liczby, -Wynik)
% Główny predykat, który przyjmuje listę liczb (Liczby) i zwraca listę czterech liczb,
% które są jednocześnie dwucyfrowe i dzielą się przez trzy największe liczby jednocyfrowe.
main(Liczby, Wynik) :-
	three_biggest_one_digit(Liczby, NajwiekszeJednoCyfrowe),
	filter_numbers(Liczby, NajwiekszeJednoCyfrowe, Dzielne),
	sort(Dzielne, Posortowane),
    first_n_elements(Posortowane, 4, Wynik).