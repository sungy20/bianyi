; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...) 

define i32 @"main"() 
{
main:
  %".2" = alloca i32
  store i32 0, i32* %".2"
  ret i32 1
}
