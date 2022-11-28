; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

define i32 @"main"()
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  store i8 97, i8* %".3"
  %".5" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 1
  store i8 115, i8* %".5"
  %".7" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 2
  store i8 100, i8* %".7"
  %".9" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 3
  store i8 97, i8* %".9"
  %".11" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 4
  store i8 115, i8* %".11"
  %".13" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 5
  store i8 100, i8* %".13"
  %".15" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 6
  store i8 0, i8* %".15"
  %".17" = alloca i32
  store i32 111415, i32* %".17"
  %".19" = load [100 x i8], [100 x i8]* %".2"
  %".20" = load i32, i32* %".17"
  %".21" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([12 x i8], [12 x i8]* @"\22asdasd%s%d\5cn\22", i32 0, i32 0), [100 x i8]* %".2", i32 %".20")
  ret i32 0
}

@"\22asdasd%s%d\5cn\22" = global [12 x i8] c"asdasd%s%d\0a\00"