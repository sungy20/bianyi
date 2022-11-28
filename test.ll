; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

define i32 @"main"()
{
main:
  %".2" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([8 x i8], [8 x i8]* @"msg", i32 0, i32 0))
  ret i32 0
}

@"msg" = global [8 x i8] c"asdasd\0a\00"