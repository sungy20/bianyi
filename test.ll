; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

define i32 @"huiwen"(i8* %".1")
{
huiwen:
  %".3" = getelementptr i8, i8* %".1", i32 4
  %".4" = load i8, i8* %".3"
  %".5" = sext i8 %".4" to i32
  ret i32 %".5"
}

define i32 @"main"()
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  store i8 49, i8* %".3"
  %".5" = getelementptr [100 x i8], [100 x i8]* %".2", i32 1, i32 1
  store i8 50, i8* %".5"
  %".7" = getelementptr [100 x i8], [100 x i8]* %".2", i32 2, i32 2
  store i8 51, i8* %".7"
  %".9" = getelementptr [100 x i8], [100 x i8]* %".2", i32 3, i32 3
  store i8 50, i8* %".9"
  %".11" = getelementptr [100 x i8], [100 x i8]* %".2", i32 4, i32 4
  store i8 49, i8* %".11"
  %".13" = getelementptr [100 x i8], [100 x i8]* %".2", i32 5, i32 5
  store i8 0, i8* %".13"
  %".15" = load [100 x i8], [100 x i8]* %".2"
  %".16" = alloca [100 x i8]
  store [100 x i8] %".15", [100 x i8]* %".16"
  %".18" = getelementptr [100 x i8], [100 x i8]* %".16", i32 0, i32 0
  %".19" = call i32 @"huiwen"(i8* %".18")
  %".20" = alloca i32
  store i32 %".19", i32* %".20"
  %".22" = load i32, i32* %".20"
  ret i32 %".22"
}
