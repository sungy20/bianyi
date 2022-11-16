; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"main"()
{
entry:
  %".2" = alloca i32
  store i32 1, i32* %".2"
  ret i32 0
}
