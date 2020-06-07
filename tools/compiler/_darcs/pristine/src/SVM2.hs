
module SVM2 (
            Info(..),
            RawInstr(..),
            
            ScmAss,
            mergeSource,
            Instruction,
            getInfo,
            getRawInstr,
            setInfo,
            setRawInstr,
            nop
           )
    where

import Scheme

-- class Operand operand where
--     getOperands:: SvmInstr operand -> [operand]
--     getOperands (Instr _ _ oprands) = oprands

-- Definition of SVM instructions
data RawInstr = FetchConst Datum 
              | MakeClosure Sym Formals [Instruction]
              | LookupVar Sym
              | Label [Char]
              | NewBind Sym
              | ReBind Sym
              | LeaveProc 
              | Apply 
              | CallBuiltin Sym Int
              | PushCont [Char]
              | Push 
              | MoveSp Int
              | AccStack Int
              | IfTrue [Instruction] [Instruction]
              | IfFalse [Instruction] [Instruction]
              | Goto [Char]
              | BlankLn      -- make output file more readable
              | Nop          -- same as `BlankLn'
                deriving (Eq, Show)

data Info = Info {
                  comments :: String,
                  line :: Int,
                  column :: Int
                 }
            deriving (Eq, Show)

nullInfo = Info {
                 comments = "",
                 line = 0,
                 column = 0
                 }

data Instruction = Instr {
                          info :: Info,
                          instr :: RawInstr
                         }
                   deriving (Eq, Show)

nop :: Instruction
nop = Instr nullInfo BlankLn

-- a temp function that will be removed in the future
-- makeInstr :: Instr -> Instruction
-- makeInstr = Instr Info

getInfo :: Instruction -> Info
getInfo = info

getRawInstr :: Instruction -> RawInstr
getRawInstr = instr

setInfo :: Instruction -> Info -> Instruction
setInfo (Instr _ instr) info = Instr info instr

setRawInstr :: Instruction -> RawInstr -> Instruction
setRawInstr (Instr info _) instr = Instr info instr

type ScmAss = [Instruction]

mergeSource :: ScmAss -> ScmAss -> ScmAss
mergeSource = (++)

-- getOperands :: (Operand operand) => SvmInstr operand -> [operand]
-- getOperands = operands

-- convertInstr::SvmInstr -> [String]

-- setReg :: String -> String -> String
-- setReg reg rval = "g_svm.reg_" ++ reg ++ " = " ++ rval ++ ";"

-- convert (FetchConst datum) symbol = [setReg "value" symbol]
-- convert Make
