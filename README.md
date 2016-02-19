# Grue - a Haskell ZMachine
A Haskell implementation of [Eric Lippert's](http://ericlippert.com/) OCaml ZMachine. Eric's series starts here: [West of House](http://ericlippert.com/2016/02/01/west-of-house/). You can find Eric's implementation [here](https://github.com/ericlippert/flathead).

The branches will be in sync with Eric's, that should make following both projects easier. I wont' have time to blog about it as I go along so I'll explain any significant decisiones I may take here.

To build the project I'll be using the windows and mac Haskell platform. You can download it at [Haskell Language](https://www.haskell.org/)

Disclaimer: I've started this project to begin learning Haskell. I am in no way experienced with the language nor with OCaml so this will be a pure learning experience of the functional world. I'd appreciate any lost soul who happens to stumble upon this project and knows about Haskell to give any constructive feedback about how well or awfully bad I'm porting Eric's code.

Ok let's get started. This branch will cover Eric's first 3 blogs in the series:

[West of house](http://ericlippert.com/2016/02/01/west-of-house/)

[North of house](http://ericlippert.com/2016/02/03/north-of-house/)

[Forest path](http://ericlippert.com/2016/02/05/forest_path/)

-----------------------------------------------------

First off let me say that although Eric keeps his code as clean as possible with very little explicit typing, I wont do the same with Haskell. I am relatively new to the language so explicitly typing is a safety net for me at the moment. Haskell's typing is not very intrusive to begin with so it will be perfectly fine. I will only skip explicit typing when it gets in the way *and* its very obvious what the inferred type is.

Lightweight type wrappers can be implemented via the `newtype` keyword in Haskell. Almost equivalent is the `data` keyword. Among other subtle differences, the latter allows you to define more than one constructor, something that can't be done with `newtype`. I've implemented `Bit` to showcase this diference. If you want more details on the subject, check out this great SO [answer](http://stackoverflow.com/a/5889784/767890).

`type` is another option Haskell offers to create wrapper types, but this just creates an alias of another type and both can be used indifferently which defeats the purpose of why Eric is creating them to begin with. For example, in Haskell, `String` is just an alias of `[Char]` and any function `Foo :: String -> String` is exactly the same as `Foo :: [Char] -> [Char]`. Therefore all list functions work right out of the box with strings: string concatenation `++` is simply the list concatenation function `(++) :: [a] -> [a] -> [a]`.

Another interesting feature is that `Bit` has a `deriving (Eq)` clause. What is up with that? You can think of deriving as similar to implementing a certain interface. `Eq` is a type class and enables different `Bit`s to be tested for equality. In Haskell language, you would say `Bit` is an instance of class `Eq`. It is important to note that wrapper types *do not* inherit the wrapped type's "implemented" type classes: You can not test for equality two `BitNumner`s out of the box, even though you can obviously test two `Int`s.

The default implementation for testing equality would be to test the constructor arguments for equality. In `Bit` there are no arguments so equality is based upon which constructor is used. Ordering (type class `Ord`) would be based by the order you wrote said constructors.
