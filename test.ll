; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...) 

define i32 @"main"() 
{
main:
  %".2" = alloca i8, i32 5
  %".3" = alloca i8*
  store i8* %".2", i8** %".3"
  ret i32 1
}
