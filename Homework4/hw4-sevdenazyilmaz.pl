/* Author: Sevdenaz Yılmaz 30300
   Date: December 5, 2024
   Description: Solution for parrot kidnapping puzzle using Prolog */

% Facts - People
man(gencer).
man(can).
man(rasim).

woman(beyza).
woman(canan).
woman(meryem).

person(X) :- man(X); woman(X).

% Helper predicate for ensuring different elements
different([], _).
different([H|T], X) :- H \= X, different(T, X).

all_different([]).
all_different([H|T]) :- different(T, H), all_different(T).

% Clue predicates - Each clue is a separate rule
clue1(CarriedOnion, OwnsRedbag) :-
    CarriedOnion \= OwnsRedbag.

clue2(OwnsRedbag, CarriedCookies, CarriedChocolate, CarriedAvocado) :-
    man(OwnsRedbag),
    OwnsRedbag \= CarriedCookies,
    OwnsRedbag \= CarriedChocolate,
    OwnsRedbag \= CarriedAvocado.

clue3(OwnsBluebag, OwnsYellowbag) :-
    member((OwnsBluebag, OwnsYellowbag), [(beyza, meryem), (meryem, beyza)]).

clue4(CarriedAvocado, OwnsBluebag, OwnsOrangebag) :-
    CarriedAvocado \= beyza,
    CarriedAvocado \= gencer,
    CarriedAvocado \= OwnsBluebag,
    CarriedAvocado \= OwnsOrangebag.

clue5(CarriedCookies, OwnsYellowbag) :-
    woman(CarriedCookies),
    CarriedCookies = OwnsYellowbag.

clue6(OwnsPurplebag) :-
    member(OwnsPurplebag, [can, gencer]).

clue7(CarriedChocolate, OwnsOrangebag) :-
    CarriedChocolate \= OwnsOrangebag.

clue8(OwnsYellowbag, OwnsGreenbag) :-
    OwnsYellowbag \= meryem,
    OwnsGreenbag \= meryem.

clue9(CarriedOnion) :-
    CarriedOnion = gencer.

clue10(CarriedNuts, OwnsGreenbag) :-
    CarriedNuts = OwnsGreenbag.

% Main predicate to solve the puzzle
guilty(Kidnapper) :-
    % Initialize variables with most constrained first
    clue9(CarriedOnion),
    clue3(OwnsBluebag, OwnsYellowbag),
    clue5(CarriedCookies, OwnsYellowbag),
    clue6(OwnsPurplebag),
    
    % Get remaining bag owners
    person(OwnsGreenbag),
    person(OwnsOrangebag),
    person(OwnsRedbag),
    
    % Get remaining food carriers
    person(CarriedAvocado),
    person(CarriedChocolate),
    person(CarriedGarlic),
    person(CarriedNuts),
    
    % Apply all clues
    clue1(CarriedOnion, OwnsRedbag),
    clue2(OwnsRedbag, CarriedCookies, CarriedChocolate, CarriedAvocado),
    clue4(CarriedAvocado, OwnsBluebag, OwnsOrangebag),
    clue7(CarriedChocolate, OwnsOrangebag),
    clue8(OwnsYellowbag, OwnsGreenbag),
    clue10(CarriedNuts, OwnsGreenbag),
    
    % Ensure all assignments are different
    all_different([OwnsBluebag, OwnsGreenbag, OwnsOrangebag, 
                  OwnsPurplebag, OwnsRedbag, OwnsYellowbag]),
    all_different([CarriedAvocado, CarriedChocolate, CarriedCookies,
                  CarriedGarlic, CarriedNuts, CarriedOnion]),
    
    % The kidnapper is the person who owns the green bag
    Kidnapper = OwnsGreenbag,
    
    % Print all relations in specified order
    print_results(OwnsBluebag, OwnsGreenbag, OwnsOrangebag, OwnsPurplebag,
                 OwnsRedbag, OwnsYellowbag, CarriedAvocado, CarriedChocolate,
                 CarriedCookies, CarriedGarlic, CarriedNuts, CarriedOnion,
                 Kidnapper).

% Helper predicate for printing results in specified order
print_results(BB, GB, OB, PB, RB, YB, AV, CH, CO, GA, NU, ON, K) :-
    format('Bluebag is owned by ~w~n', [BB]),
    format('Greenbag is owned by ~w~n', [GB]),
    format('Orangebag is owned by ~w~n', [OB]),
    format('Purplebag is owned by ~w~n', [PB]),
    format('Redbag is owned by ~w~n', [RB]),
    format('Yellowbag is owned by ~w~n', [YB]),
    format('Avocado is carried by ~w~n', [AV]),
    format('Chocolate is carried by ~w~n', [CH]),
    format('Cookies is carried by ~w~n', [CO]),
    format('Garlic is carried by ~w~n', [GA]),
    format('Nuts is carried by ~w~n', [NU]),
    format('Onion is carried by ~w~n', [ON]),
    format('Kidnapper is ~w~n', [K]).