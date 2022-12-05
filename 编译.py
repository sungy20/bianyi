import sys
from antlr4 import *
from antlr_about.C2LLVMLexer import C2LLVMLexer
from antlr_about.C2LLVMParser import C2LLVMParser
from generator.generator import LLVMGenerator
 
def makeTree(filename):
    input_stream = FileStream(filename)
    lexer = C2LLVMLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = C2LLVMParser(stream)
    tree = parser.start()
    return tree
 
name = 'source\\array_func.c'
if __name__ == '__main__':
    tree = makeTree(name)
    gen = LLVMGenerator()
    gen.visit(tree)
    gen.save("test.ll")