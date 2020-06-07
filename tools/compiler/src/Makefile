
LEX = alex
YACC = happy
GHC = ghc

OBJS = Exptype.o Scmlex.o Parser.o Compiler.o

.SUFFIXES: .hi .hs

.hs:
	$(GHC) --make $<

all: sc tst_lex tst_parser tst_compiler tst_scm2c

sc: Main.hs Convert.hs  Compiler.hs Scmlex.hs Parser.hs
	$(GHC) --make Main.hs -o sc
# .PHONY: tst_scm2c tst_compiler tst_parser tst_lex

tst_scm2c: tst_scm2c.hs Convert.hs Compiler.hs Exptype.hs Builtin.hs CSrc.hs
	$(GHC) --make tst_scm2c.hs -o tst_scm2c	

tst_compiler: tst_compiler.hs Exptype.hs Parser.hs  Compiler.hs SVM.hs Builtin.hs
	$(GHC) --make tst_compiler.hs -o tst_compiler

tst_parser: tst_parser.hs Exptype.hs Scmlex.hs Parser.hs
	$(GHC) --make tst_parser.hs -o tst_parser

tst_lex: tst_lex.hs Scmlex.hs
	$(GHC) --make tst_lex.hs -o tst_lex

Scmlex.hs: Scmlex.x
	$(LEX) Scmlex.x

Parser.hs: Parser.y
	$(YACC) Parser.y

clean:
	rm -rf *.hi *.o
