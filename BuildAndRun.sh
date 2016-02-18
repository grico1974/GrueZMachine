#! /bin/bash
find . -type f -iname \*.hi -delete
find . -type f -iname \*.o -delete
ghc Grue
find . -type f -iname \*.hi -delete
find . -type f -iname \*.o -delete
open Grue