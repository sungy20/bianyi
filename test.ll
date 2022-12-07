; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

%"node" = type {i8, i32}
declare i32 @"printf"(i8* %".1", ...) 

define i32 @"main"() 
{
main:
  %".2" = alloca %"node"
  %".3" = alloca %"node"*
  store %"node"* %".2", %"node"** %".3"
  %".5" = getelementptr %"node"*, %"node"** %".3", i32 1
  %".6" = bitcast %"node"** %".5" to i32*
  store i32 2, i32* %".6"
  %".8" = getelementptr %"node"*, %"node"** %".3", i32 1
  %".9" = bitcast %"node"** %".8" to i32*
  %".10" = load i32, i32* %".9"
  ret i32 %".10"
}
