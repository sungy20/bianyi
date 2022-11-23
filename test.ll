; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...) 

define i32 @"main"() 
{
main:
  %".2" = alloca i32
  store i32 1, i32* %".2"
  %".4" = alloca [5 x i8]
  store [5 x i8] c"shit\00", [5 x i8]* %".4"
  %".6" = load i32, i32* %".2"
  ret i32 %".6"
}
