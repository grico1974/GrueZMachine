# Grue - a Haskell ZMachine
A Haskell implementation of [Eric Lippert's](http://ericlippert.com/) OCaml ZMachine. Eric's series starts here: [West of House](http://ericlippert.com/2016/02/01/west-of-house/). You can find Eric's implementation [here](https://github.com/ericlippert/flathead).

The branches will be in sync with Eric's, that should make following both projects easier. I wont' have time to blog about it as I go along so I'll explain any significant decisiones I may take here.

To build the project I'll be using the windows and mac Haskell platform. You can download it at [Haskell Language](https://www.haskell.org/)

Disclaimer: I've started this project to begin learning Haskell. I am in no way experienced with the language nor with OCaml so this will be a pure learning experience of the functional world. I'd appreciate any lost soul who happens to stumble upon this project and knows about Haskell to give any constructive feedback about how well or awfully bad I'm porting Eric's code.

Code of this branch follows part five six and seven of Eric's bloq series:

[Up a tree](http://ericlippert.com/2016/02/09/up-a-tree/)

[Behind house](http://ericlippert.com/2016/02/10/behind-house/)

[Kitchen](http://ericlippert.com/2016/02/12/kitchen/)

------------------------------

Oh, oh, we now have to load up a .z3 file, and therefore interact with the real world...*IO*. In Haskell things are very very different when it comes to *IO* interaction.

Basically what happens is that anything that comes from the *real world* is not pure; that is, two calls to the same function with the same arguments are not bound to give back the same result (somebody might edit or delete a file between calls for example). In Haskell's perfect inner world, all functions are pure, which means that, given the same input, the function is guaranteed to always give back the same output. This makes sense because if you examine closely any given function written in Haskell you will notice that they *have no state* so to speak; all the information is right there in the function, so given the same input it necessarily has to output the same result every time. A direct consequence of this is that order of execution does not matter whereas in the realworld it obviously does; you can't process a file before reading it, and you cant process a user's input before actually having him/her input something.

Anything returned from an impure function (*IO* interaction) is "tagged" with an `IO` "badge". For instance, `ByteString.readFile` does not return a `ByteString`, it returns an `IO ByteString` which is not the same type at all; any function taking a `ByteString` will *not* admit a `IO ByteString`. `IO ByteString` essentially means "I am an *IO* action that will return a `ByteString`". `main` for instance has type `IO ()`. Huh? What is that? Well it essentially means "I am an *IO* action that doesn't return anything relevant". `()` is the empty tuple which basically means nothing.

Thankfully you can plug in pure and impure functions, otherwise Haskell programs wouldn't be all that useful. I am not going to get into the theory behind it, Kliesli categories, arrows and such. If you really want to start learning the theory behind all of this, start with this fabulous post: [Why do monads matter] (https://cdsmith.wordpress.com/2012/04/18/why-do-monads-matter/). Suffice to say that inside an *IO* action (say `main` for instance), while using *do* notation, you can extract the "wrapped *IO* type with the `<-` operator: `myPureWorld <- theRealWorld`.

And now you'll ask, what is `do` notation? Well `do` notation is just a very convenient syntactic sugar that enables you to write imperative like code in Haskell where execution order *is* enforced, something that is obviously *very* handy when dealing with *IO* actions.

That said, `Story` implementation is quite straightforward, so not much more to comment.
