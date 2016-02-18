module Types where

newtype BitNumber = BitNumber Int
newtype BitSize = BitSize Int
data Bit = Zero | One deriving (Eq)
newtype ByteAddress = ByteAddress Int
newtype WordAddress = WordAddress Int
newtype AbbreviationNumber = AbbreviationNumber Int
newtype AbbreviationTableBase = AbbreviationTableBase Int
newtype WordZstringAddress = WordZstringAddress Int --Compressed pointer
newtype ZstringAddress = ZstringAddress Int --Uncompressed pointer