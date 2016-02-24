# Flathead - a Haskell ZMachine
A Haskell implementation of [Eric Lippert's](http://ericlippert.com/) OCaml ZMachine. Eric's series starts here: [West of House](http://ericlippert.com/2016/02/01/west-of-house/). You can find Eric's implementation [here](https://github.com/ericlippert/flathead).

The branches will be in sync with Eric's, that should make following both projects easier. I wont' have time to blog about it as I go along so I'll explain any significant decisiones I may take here.

To build the project I'll be using the windows and mac Haskell platform. You can download it at [Haskell Language](https://www.haskell.org/)

Disclaimer: I've started this project to begin learning Haskell. I am in no way experienced with the language nor with OCaml so this will be a pure learning experience of the functional world. I'd appreciate any lost soul who happens to stumble upon this project and knows about Haskell to give any constructive feedback about how well or awfully bad I'm porting Eric's code.

-----------------------

It seems that *Zstring* decoding is a little bit more involved than what we saw in the last episode.

Eric's implementation is perfect to showcase one of the most amazing features of functional languages (although we have already been using it since day one): pattern matching. In Haskell, as I'm pretty sure happens in OCaml, there is whole pletora of ways to use pattern matching in functions. [Syntax in Functions](http://learnyouahaskell.com/syntax-in-functions) is a great place to start reading about the subject.

Something to note is that Haskell falls behind OCaml when it comes to compile time "safety" while pattern matching. I find it pretty convenient that in OCaml the compiler will balk if certain patterns are not handled. This feature allows you to identify stupid bugs, or even better, deeper logic bugs at compile time. This is not the case in Haskell, where the following code will compile just fine:

    data State = Blue | Green | Orange deriving (Show)

    match :: Int -> State -> (String, State)
    match n state = 
       case (n, state) of 
          (_, Green) -> ("Green", Blue)
          (_, Blue) -> ("Blue", Orange)

    >> match 4 Green
    >> ("Green", "Blue")
    >> match 4, Orange
    >> *** Exception: D:\LearningHaskell\learning.hs:(5,4)-(7,35): Non-exhaustive patterns in case
    
I've chosen to port Eric's code defining different function bodies of `process_Zchar` for each argument pattern. In my opinion this looks like the cleanest approach. Eric's implementation is somewhat similar (at least syntax wise) to Haskell's *case expressions* but I will skip using them here.

Something I haven't quite figured out is why Eric is using the `Zchar` type. I see very little danger in using `Int` in what is, after all, a nested call never exposed to the outside. I will therefore skip using `Zchar` but will keep, commented out, the type definition in *Types.hs* in case it is used further on.
