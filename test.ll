; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

define i32 @"repeat"(i32 %".1", i8* %".2")
{
repeat:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %".6" = alloca i8*
  store i8* %".2", i8** %".6"
  %".8" = load i32, i32* %".4"
  %".9" = load i8*, i8** %".6"
  %".10" = getelementptr i8, i8* %".9", i32 %".8"
  %".11" = load i8, i8* %".10"
  %".12" = zext i8 %".11" to i32
  ret i32 %".12"
}

define i32 @"get"(i8* %".1")
{
get:
  %".3" = alloca i8*
  store i8* %".1", i8** %".3"
  %".5" = load i8*, i8** %".3"
  %".6" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%s\5cn\22", i32 0, i32 0), i8* %".5")
  %".7" = load i8*, i8** %".3"
  %".8" = call i32 @"repeat"(i32 2, i8* %".7")
  ret i32 %".8"
}

@"\22%s\5cn\22" = global [4 x i8] c"%s\0a\00"
define i32 @"main"()
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  store i8 48, i8* %".3"
  %".5" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 1
  store i8 52, i8* %".5"
  %".7" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 2
  store i8 56, i8* %".7"
  %".9" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 3
  store i8 50, i8* %".9"
  %".11" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 4
  store i8 53, i8* %".11"
  %".13" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 5
  store i8 48, i8* %".13"
  %".15" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 6
  store i8 0, i8* %".15"
  %".17" = alloca i32
  store i32 0, i32* %".17"
  br label %"main.while_cond"
main.while_cond:
  %".20" = load i32, i32* %".17"
  %".21" = icmp slt i32 %".20", 5
  br i1 %".21", label %"main.while_body", label %"main.while_end"
main.while_body:
  %".23" = load i32, i32* %".17"
  %".24" = load i32, i32* %".17"
  %".25" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 %".24"
  %".26" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([14 x i8], [14 x i8]* @"\22res[%d] = %c\5cn\22", i32 0, i32 0), i32 %".23", i8* %".25")
  %".27" = load i32, i32* %".17"
  %".28" = add i32 %".27", 1
  store i32 %".28", i32* %".17"
  br label %"main.while_cond"
main.while_end:
  %".31" = load [100 x i8], [100 x i8]* %".2"
  %".32" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([10 x i8], [10 x i8]* @"\22res = %s\5cn\22", i32 0, i32 0), [100 x i8]* %".2")
  %".33" = load [100 x i8], [100 x i8]* %".2"
  %".34" = alloca [100 x i8]
  store [100 x i8] %".33", [100 x i8]* %".34"
  %".36" = getelementptr [100 x i8], [100 x i8]* %".34", i32 0, i32 0
  %".37" = alloca i8*
  store i8* %".36", i8** %".37"
  %".39" = load i8*, i8** %".37"
  %".40" = call i32 @"get"(i8* %".39")
  ret i32 %".40"
}

@"\22res[%d] = %c\5cn\22" = global [14 x i8] c"res[%d] = %c\0a\00"
@"\22res = %s\5cn\22" = global [10 x i8] c"res = %s\0a\00"