#! /bin/bash
find . -type f -iname \*.hi -delete
find . -type f -iname \*.o -delete
ghc flathead
find . -type f -iname \*.hi -delete
find . -type f -iname \*.o -delete
open flathead