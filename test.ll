; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"main"()
{
entry:
  %".2" = alloca i32
  store i32 100, i32* %".2"
  %".4" = load i32, i32* %".2"
  ret i32 %".4"
}
