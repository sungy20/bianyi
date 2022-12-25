; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...) 

define i32 @"main"() 
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  store i8 40, i8* %".3"
  %".5" = getelementptr [100 x i8], [100 x i8]* %".2", i32 1, i32 1
  store i8 49, i8* %".5"
  %".7" = getelementptr [100 x i8], [100 x i8]* %".2", i32 2, i32 2
  store i8 43, i8* %".7"
  %".9" = getelementptr [100 x i8], [100 x i8]* %".2", i32 3, i32 3
  store i8 49, i8* %".9"
  %".11" = getelementptr [100 x i8], [100 x i8]* %".2", i32 4, i32 4
  store i8 41, i8* %".11"
  %".13" = getelementptr [100 x i8], [100 x i8]* %".2", i32 5, i32 5
  store i8 0, i8* %".13"
  %".15" = alloca i32
  store i32 0, i32* %".15"
  %".17" = load [100 x i8], [100 x i8]* %".2"
  %".18" = icmp eq [100 x i8] %".17", 0
  br i1 %".18", label %"main.if", label %"main.endif"
main.if:
  store i32 1, i32* %".15"
  br label %"main.endif"
main.endif:
  %".22" = load i32, i32* %".15"
  ret i32 %".22"
}
