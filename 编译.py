import sys
from antlr4 import *
from C2LLVMLexer import C2LLVMLexer
from C2LLVMParser import C2LLVMParser
 
def main(argv):
    input_stream = FileStream(argv[1])
    lexer = C2LLVMLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = C2LLVMParser(stream)
    #tree = parser.startRule()
 
if __name__ == '__main__':
    main(sys.argv)