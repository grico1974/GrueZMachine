# GrueZMachine - a Haskell ZMachine
A Haskell implementation of [Eric Lippert's](http://ericlippert.com/) OCaml ZMachine. Eric's series starts here: [West of House](http://ericlippert.com/2016/02/01/west-of-house/). You can find Eric's implementation [here](https://github.com/ericlippert/flathead).

The branches will be in sync with Eric's, that should make following both projects easier. I wont' have time to blog about it as I go along so I'll explain any significant decisiones I may take here.

To build the project I'll be using the windows and mac Haskell platform. You can download it at [Haskell Language](https://www.haskell.org/)

Disclaimer: I've started this project to begin learning Haskell. I am in no way experienced with the language nor with OCaml so this will be a pure learning experience of the functional world. I'd appreciate any lost soul who happens to stumble upon this project and knows about Haskell to give any constructive feedback about how well or awfully bad I'm porting Eric's code.

Code of this branch follows part seven and eight of Eric's bloq series:

[Living room](http://ericlippert.com/2016/02/15/living-room/)

[Attic](http://ericlippert.com/2016/02/17/attic/)

------------------------------

We get to begin learning how strings are compressed in a .z3 file and how we can decode them, although things are more complicated than what may appear in these two episodes.

Recursive methods in Haskell do not require any special keyword like OCaml apparently does. I've chosen the `where` clause to bind the inner functions as I find it easier to read. Note that the order in which you define nested functions in a `where` clause is the opposite of what you would find in a `let-in` clause as in Eric's implementation.

Which reminds me I forgot to point out a convenient difference between Haskell and OCaml, or at least, Eric's implementation. It seems as if OCaml does not have `let-in` "blocks" or maybe Eric is simply not using them. Haskell allows you to use these blocks and not repeatedly use `let` and `in` in every nested binding.
