; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

declare i32 @"scanf"(i8* %".1", ...)

define i32 @"main"()
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = load [100 x i8], [100 x i8]* %".2"
  %".4" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%s\22", i32 0, i32 0), [100 x i8]* %".2")
  %".5" = load [100 x i8], [100 x i8]* %".2"
  %".6" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%s\5cn\22", i32 0, i32 0), [100 x i8]* %".2")
  ret i32 0
}

@"\22%s\22" = global [3 x i8] c"%s\00"
@"\22%s\5cn\22" = global [4 x i8] c"%s\0a\00"