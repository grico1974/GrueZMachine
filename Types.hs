module Types where

newtype BitNumber = BitNumber Int
newtype BitSize = BitSize Int
data Bit = Zero | One deriving (Eq)