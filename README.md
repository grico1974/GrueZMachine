# Flathead - a Haskell ZMachine
A Haskell implementation of [Eric Lippert's](http://ericlippert.com/) OCaml ZMachine. Eric's series starts here: [West of House](http://ericlippert.com/2016/02/01/west-of-house/). You can find Eric's implementation [here](https://github.com/ericlippert/flathead).

The branches will be in sync with Eric's, that should make following both projects easier. I wont' have time to blog about it as I go along so I'll explain any significant decisiones I may take here.

To build the project I'll be using the windows and mac Haskell platform. You can download it at [Haskell Language](https://www.haskell.org/)

Disclaimer: I've started this project to begin learning Haskell. I am in no way experienced with the language nor with OCaml so this will be a pure learning experience of the functional world. I'd appreciate any lost soul who happens to stumble upon this project and knows about Haskell to give any constructive feedback about how well or awfully bad I'm porting Eric's code.

Code of this branch follows part five six and seven of Eric's bloq series:

[Up a tree](http://ericlippert.com/2016/02/09/up-a-tree/)

[Behind house](http://ericlippert.com/2016/02/10/behind-house/)

[Kitchen](http://ericlippert.com/2016/02/12/kitchen/)

Oh, oh, we now have to load up a .z3 file, and therefore interact with the real world...*IO*. In Haskell things are very very different when it comes to *IO* interaction. I am still trying to get my head around how it all works, but suffice to say that in order to keep all my implementation as pure as possible, I'll leave the loading action of the file inside `main` where I can leverage the *IO monad* and make things work. When I have a deeper understanding I might need to alter some code, but I'll leave that for later hoping I'm not making a mistake that will require a deep code refactoring of all my implementation.

`Story` implementation is quite straightforward, not much to comment.
