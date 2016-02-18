# Flathead - a Haskell ZMachine
A Haskell implementation of [Eric Lippert's](http://ericlippert.com/) OCaml ZMachine. Eric's series starts here: [West of House](http://ericlippert.com/2016/02/01/west-of-house/). You can find Eric's implementation [here](https://github.com/ericlippert/flathead).

The branches will be in sync with Eric's, that should make following both projects easier. I wont' have time to blog about it as I go along so I'll explain any significant decisiones I may take here.

Ok let's get started. This branch will cover Eric's first 3 blogs in the series:

[West of house](http://ericlippert.com/2016/02/01/west-of-house/)

[North of house](http://ericlippert.com/2016/02/03/north-of-house/)

[Forest path](http://ericlippert.com/2016/02/05/forest_path/)
	
Worth noting that allthough Eric keeps his code as clean as possible with very little explicit typing, I wont do the same with Haskell. I am relatively new to the language so explicitly typing is a safety net for me at this moment. Haskell's typing is not very intrusive to begin with so it will be perfectly fine.

Lightweight type wrappers can be done via the `newtype` keyword in Haskell. Almost equivalent is the `data` keyword. Among other slight differences, the latter allows you to define more than one constructor, something that can't be done with `newtype`. I've implemented `Bit` to showcase this diference.

`type` is another option Haskell offers to create wrapper types, but this just creates an alias to another type and both can be used indifferently which defeats the prupose of why Eric is creating them to begin with. For example, in Haskell, `String` is just an alias of `[Char]`
