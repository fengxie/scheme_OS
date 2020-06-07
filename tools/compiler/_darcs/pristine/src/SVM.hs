
module SVM (
            Code(..),
            Info(..),
            Instr,
            
            ScmAss,
            Instruction,
            makeInstr,
            getInfo,
            getInstr,
            putInfo,
            putInstr,
            emptyInstr
           )
    where

import Exptype

-- class Operand operand where
--     getOperands:: SvmInstr operand -> [operand]
--     getOperands (Instr _ _ oprands) = oprands

-- Definition of SVM instructions
data Code = FetchConst Datum
          | MakeClosure Sym Formals [Code]
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
          | IfTrue [Code] [Code]
          | IfFalse [Code] [Code]
          | Goto [Char]
          | BlankLn             -- make output file more readable
          | Nop                 -- same as `BlankLn'
            deriving (Eq, Show)

type Instr = Code

data Info = Info
            deriving (Eq, Show)

-- data Operator = Nop
--               | Fetch
--               | MakeClosure
--               | LookupVar
--               | Label
--               | NewBind
--               | ReBind
--               | LeaveProc
--               | Apply
--               | CallBuiltin
--               | PushCont
--               | Push
--               | MoveSp
--               | AccStack
--               | IfTrue
--               | IfFalse
--               | Goto
--               | MultCond
--                 deriving (Eq, Show)

data Instruction = Instr {
                          info::Info,
                          instr::Instr
                         }
                   deriving (Eq, Show)

-- a temp function that will be removed in the future
makeInstr :: Code -> Instruction
makeInstr = Instr Info

getInfo :: Instruction -> Info
getInfo = info

getInstr :: Instruction -> Instr
getInstr = instr

putInfo :: Instruction -> Info -> Instruction
putInfo (Instr _ instr) info = Instr info instr

putInstr :: Instruction -> Instr -> Instruction
putInstr (Instr info _) instr = Instr info instr

emptyInstr :: Instruction
emptyInstr = Instr Info BlankLn

type ScmAss = [Instruction]

mergeSource = (++)

-- getOperands :: (Operand operand) => SvmInstr operand -> [operand]
-- getOperands = operands

-- convertInstr::SvmInstr -> [String]

-- setReg :: String -> String -> String
-- setReg reg rval = "g_svm.reg_" ++ reg ++ " = " ++ rval ++ ";"

-- convert (FetchConst datum) symbol = [setReg "value" symbol]
-- convert Make
