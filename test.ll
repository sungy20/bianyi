; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...) 

declare i32 @"scanf"(i8* %".1", ...) 

define i32 @"fun"(i32 %".1") 
{
fun:
  %".3" = alloca i32
  store i32 %".1", i32* %".3"
  %".5" = load i32, i32* %".3"
  %".6" = add i32 %".5", 1
  ret i32 %".6"
}

define i32 @"main"() 
{
main:
  %".2" = call i32 @"fun"(i32 0)
  ret i32 %".2"
}
