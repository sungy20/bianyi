; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

declare i32 @"scanf"(i8* %".1", ...)

define i32 @"get"(i32 %".1", i32 %".2")
{
get:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %".6" = alloca i32
  store i32 %".2", i32* %".6"
  %".8" = load i32, i32* %".6"
  ret i32 %".8"
}

define i32 @"main"()
{
main:
  %".2" = alloca i32
  store i32 1, i32* %".2"
  %".4" = alloca i32*
  store i32* %".2", i32** %".4"
  %".6" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([7 x i8], [7 x i8]* @"\22&b:%x\5cn\22", i32 0, i32 0), i32* %".2")
  %".7" = load i32*, i32** %".4"
  %".8" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([6 x i8], [6 x i8]* @"\22a:%x\5cn\22", i32 0, i32 0), i32* %".7")
  %".9" = load i32*, i32** %".4"
  %".10" = alloca i32*
  store i32* %".9", i32** %".10"
  %".12" = load i32*, i32** %".10"
  %".13" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([6 x i8], [6 x i8]* @"\22c:%x\5cn\22", i32 0, i32 0), i32* %".12")
  %".14" = load i32, i32* %".2"
  %".15" = icmp sgt i32 %".14", 0
  br i1 %".15", label %"main.if", label %"main.else"
main.if:
  %".17" = load i32, i32* %".2"
  %".18" = sub i32 %".17", 1
  store i32 %".18", i32* %".2"
  br label %"main.endif"
main.else:
  %".21" = load i32, i32* %".2"
  %".22" = add i32 %".21", 1
  store i32 %".22", i32* %".2"
  br label %"main.endif"
main.endif:
  br label %"main.endif.while_cond"
main.endif.while_cond:
  %".26" = load i32, i32* %".2"
  %".27" = icmp sgt i32 %".26", 0
  br i1 %".27", label %"main.endif.while_body", label %"main.endif.while_end"
main.endif.while_body:
  %".29" = load i32, i32* %".2"
  %".30" = sub i32 %".29", 1
  store i32 %".30", i32* %".2"
  br label %"main.endif.while_cond"
main.endif.while_end:
  %".33" = alloca [100 x i8], i32 100
  %".34" = getelementptr [100 x i8], [100 x i8]* %".33", i32 0, i32 0
  %".35" = load i8, i8* %".34"
  %".36" = zext i8 %".35" to i32
  %".37" = alloca i32
  store i32 %".36", i32* %".37"
  %".39" = load i32, i32* %".37"
  %".40" = load i32, i32* %".2"
  %".41" = call i32 @"get"(i32 %".39", i32 %".40")
  ret i32 0
}

@"\22&b:%x\5cn\22" = global [7 x i8] c"&b:%x\0a\00"
@"\22a:%x\5cn\22" = global [6 x i8] c"a:%x\0a\00"
@"\22c:%x\5cn\22" = global [6 x i8] c"c:%x\0a\00"