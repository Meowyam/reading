asp via cnl processing (rolf schwitter)

goal: translate cnl problem to asp program and solve!

~ writing asp programs ~

"a) Specifying rules that generate answer sets which represent potential solu-
tions;
b) Specifying constraints that eliminate those answer sets which do not corre-
spond to actual solutions;
c) Specifying which atoms of the answer sets should be included in the output.
"

more complex programs:
d) definition part, to specify auxiliary rules for parts a/b
e) optimisation statements that compute cost of solution

~ our example is the marathon puzzle ~
summary: bunch of rules, eg. a is before b but b is not the last, etc.
         which runner is in which position?

written in full natural language

puzzle (in full natural language) -> normalise -> translate into formal target notation -> use asp solver to find solution

~ they used cnl peng light and followed the methodology for writing asp programs above ~

1: concept assertion, eg. runner(dominique)
2: existential sentences, eg. positions(1..6)
3: universal sentence with cardinality constraint in object posiiton, eg. 
every runner is allocated to exactly one position
4: commands, eg. (false <- Q) "reject that xx is in 00 position"
(translates into a constraint)
5: conditional sentence, eg. if x is in pos 0 then xx is xxxx

~ evaluation ~

they used clingo to combine the asp grounder and solver
generates 1 answer set as solution

~ improvements ~
include: use as few variables as possible
avoid built-in comparison predicates

~ question answering ~

brave reasoning: answer needs to be found in at least one answer set
cautious reasoning: answer needs to be found in every answer set

***

annotating answer-set programs in lana (Language for ANnotating Answer-set programs)

LANA: "group rules realated in meaning into coherent blocks"

*group rules into blocks
 - grouping has no semantical effects

*unit tests

*declare names and arities of predicates within block
*declare input and output signatures
^ can be used by ide or syntax checking & code completion

*declare domains of term arguments
^ automated type checking

*annotations have form of asp comment "%"
 with additional * : "%*"

~~their example is battleship ~~

rules grouped using the @block keyword

* can declare names and arities of predicates
* declarative : predicates form input signature of block
              : defined relations form output signature
* (pg 7 has table overview of lana based on bnf)

declare predicates:
* @term declares variable names,
* @from specifies type of variable
* @with : rule body (eg. %** @with integer(#V), #V>1, #V<10 *%
integer(1..1000).)
* future work: extend so have predefined names for basic types like str or int
* can nest blocks
* @precon for preconditions (conditions for any input)
* @postcon for conditions for output

~ testing ~
unit-tests
%**
@testcase ShipTopLeftCorner -- name
a ship is horizontally placed at the top-left corner -- description
@scope Guess -- list of block names
@testatoms goalShip @trueinatleast 1 --rule that defines goalShip
*%
goalShip :- ship(1,1,1,4).
* @trueinatleast n, @trueinatmost n, @trueinall n (and the corresponding false)
* can @testanswerset or @testnoanswerset instead of testatoms

* tdd

~ aspdoc ~

generates html documentation file with meta-info in an asp

~ aspunit ~

run test cases

