# Flathead - a Haskell ZMachine
A Haskell implementation of [Eric Lippert's](http://ericlippert.com/) OCaml ZMachine. Eric's series starts here: [West of House](http://ericlippert.com/2016/02/01/west-of-house/). You can find Eric's implementation [here](https://github.com/ericlippert/flathead).

The branches will be in sync with Eric's, that should make following both projects easier. I wont' have time to blog about it as I go along so I'll explain any significant decisiones I may take here.

Ok so now we have type safe bit twiddling, yay!. Next step is making ourselves an immutable byte array that will represent the dynamic memory of what we will later call the stroy state of the ZMachine.

Code of this branch follows part four of Eric's bloq series: [Up a tree](http://ericlippert.com/2016/02/09/up-a-tree/)

Eric uses strings in his implementation. Thinking ahead, and knowing that the information contained in ImmutableBytes will be read from a file, I've decided to implement `ImmutableBytes` with `ByteString` which is what you get when you read a file in binary mode in `Haskell`. `ByteString` is essentially a collection of `Word8`, a fancy name for `Byte`. Thus, my `IntMap` will bind ints to bytes to keep casting to a minimum.

The `read_Byte` and `write_Bytes` functions will return and take an `Int` to keep consistency with Eric's implementation although I am not quite sure why he decided to do it this way and not directly return / take a byte / char.