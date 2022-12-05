; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

declare i32 @"scanf"(i8* %".1", ...)

define i32 @"print"(i32 %".1", i32* %".2")
{
print:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %".6" = alloca i32*
  store i32* %".2", i32** %".6"
  %".8" = alloca i32
  store i32 0, i32* %".8"
  br label %"print.while_cond"
print.while_cond:
  %".11" = load i32, i32* %".4"
  %".12" = sub i32 %".11", 1
  %".13" = load i32, i32* %".8"
  %".14" = icmp slt i32 %".13", %".12"
  br i1 %".14", label %"print.while_body", label %"print.while_end"
print.while_body:
  %".16" = load i32, i32* %".8"
  %".17" = load i32*, i32** %".6"
  %".18" = getelementptr i32, i32* %".17", i32 %".16"
  %".19" = load i32, i32* %".18"
  %".20" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d,\22", i32 0, i32 0), i32 %".19")
  %".21" = load i32, i32* %".8"
  %".22" = add i32 %".21", 1
  store i32 %".22", i32* %".8"
  br label %"print.while_cond"
print.while_end:
  %".25" = load i32, i32* %".4"
  %".26" = sub i32 %".25", 1
  %".27" = load i32*, i32** %".6"
  %".28" = getelementptr i32, i32* %".27", i32 %".26"
  %".29" = load i32, i32* %".28"
  %".30" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d\5cn\22", i32 0, i32 0), i32 %".29")
  ret i32 0
}

@"\22%d,\22" = global [4 x i8] c"%d,\00"
@"\22%d\5cn\22" = global [4 x i8] c"%d\0a\00"
define i32 @"change"(i32 %".1", i32* %".2")
{
change:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %".6" = alloca i32*
  store i32* %".2", i32** %".6"
  %".8" = load i32, i32* %".4"
  %".9" = load i32*, i32** %".6"
  %".10" = call i32 @"print"(i32 %".8", i32* %".9")
  %".11" = load i32*, i32** %".6"
  %".12" = getelementptr i32, i32* %".11", i32 2
  store i32 101, i32* %".12"
  %".14" = load i32*, i32** %".6"
  %".15" = load i32, i32* %".4"
  %".16" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([38 x i8], [38 x i8]* @"\22--------change change asd[2]:%d;n:%d\5cn\22", i32 0, i32 0), i32* %".14", i32 %".15")
  %".17" = load i32, i32* %".4"
  %".18" = load i32*, i32** %".6"
  %".19" = call i32 @"print"(i32 %".17", i32* %".18")
  ret i32 0
}

@"\22--------change change asd[2]:%d;n:%d\5cn\22" = global [38 x i8] c"--------change change asd[2]:%d;n:%d\0a\00"
define i32 @"sort"(i32 %".1", i32* %".2")
{
sort:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %".6" = alloca i32*
  store i32* %".2", i32** %".6"
  %".8" = load i32*, i32** %".6"
  %".9" = load i32, i32* %".4"
  %".10" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([38 x i8], [38 x i8]* @"\22=================in sort asd:%d;n:%d\5cn\22", i32 0, i32 0), i32* %".8", i32 %".9")
  %".11" = load i32, i32* %".4"
  %".12" = load i32*, i32** %".6"
  %".13" = call i32 @"print"(i32 %".11", i32* %".12")
  %".14" = load i32*, i32** %".6"
  %".15" = getelementptr i32, i32* %".14", i32 1
  store i32 10, i32* %".15"
  %".17" = load i32*, i32** %".6"
  %".18" = load i32, i32* %".4"
  %".19" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([45 x i8], [45 x i8]* @"\22=================sort change asd[1]:%d;n:%d\5cn\22", i32 0, i32 0), i32* %".17", i32 %".18")
  %".20" = load i32, i32* %".4"
  %".21" = load i32*, i32** %".6"
  %".22" = call i32 @"print"(i32 %".20", i32* %".21")
  %".23" = load i32, i32* %".4"
  %".24" = load i32*, i32** %".6"
  %".25" = call i32 @"change"(i32 %".23", i32* %".24")
  %".26" = load i32*, i32** %".6"
  %".27" = load i32, i32* %".4"
  %".28" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([50 x i8], [50 x i8]* @"\22=================out change int sort asd:%d;n:%d\5cn\22", i32 0, i32 0), i32* %".26", i32 %".27")
  %".29" = load i32, i32* %".4"
  %".30" = load i32*, i32** %".6"
  %".31" = call i32 @"print"(i32 %".29", i32* %".30")
  ret i32 0
}

@"\22=================in sort asd:%d;n:%d\5cn\22" = global [38 x i8] c"=================in sort asd:%d;n:%d\0a\00"
@"\22=================sort change asd[1]:%d;n:%d\5cn\22" = global [45 x i8] c"=================sort change asd[1]:%d;n:%d\0a\00"
@"\22=================out change int sort asd:%d;n:%d\5cn\22" = global [50 x i8] c"=================out change int sort asd:%d;n:%d\0a\00"
define i32 @"main"()
{
main:
  %".2" = alloca i32
  %".3" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32* %".2")
  %".4" = load i32, i32* %".2"
  %".5" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([7 x i8], [7 x i8]* @"\22n:%xd\5cn\22", i32 0, i32 0), i32 %".4")
  %".6" = alloca i32
  store i32 0, i32* %".6"
  %".8" = alloca [100 x i32], i32 100
  %".9" = getelementptr [100 x i32], [100 x i32]* %".8", i32 0, i32 0
  %".10" = getelementptr [100 x i32], [100 x i32]* %".8", i32 0, i32 0
  %".11" = load i32, i32* %".10"
  %".12" = alloca i32
  store i32 %".11", i32* %".12"
  %".14" = load i32, i32* %".12"
  %".15" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([12 x i8], [12 x i8]* @"\22&asd[0]:%x\5cn\22", i32 0, i32 0), i32 %".14")
  br label %"main.while_cond"
main.while_cond:
  %".17" = load i32, i32* %".2"
  %".18" = sub i32 %".17", 1
  %".19" = load i32, i32* %".6"
  %".20" = icmp slt i32 %".19", %".18"
  br i1 %".20", label %"main.while_body", label %"main.while_end"
main.while_body:
  %".22" = load i32, i32* %".6"
  %".23" = getelementptr [100 x i32], [100 x i32]* %".8", i32 0, i32 %".22"
  %".24" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d,\22", i32 0, i32 0), i32* %".23")
  %".25" = load i32, i32* %".6"
  %".26" = add i32 %".25", 1
  store i32 %".26", i32* %".6"
  br label %"main.while_cond"
main.while_end:
  %".29" = load i32, i32* %".2"
  %".30" = sub i32 %".29", 1
  %".31" = getelementptr [100 x i32], [100 x i32]* %".8", i32 0, i32 %".30"
  %".32" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32* %".31")
  %".33" = load i32, i32* %".2"
  %".34" = load [100 x i32], [100 x i32]* %".8"
  %".35" = alloca [100 x i32]
  store [100 x i32] %".34", [100 x i32]* %".35"
  %".37" = getelementptr [100 x i32], [100 x i32]* %".35", i32 0, i32 0
  %".38" = call i32 @"print"(i32 %".33", i32* %".37")
  %".39" = load i32, i32* %".2"
  %".40" = load [100 x i32], [100 x i32]* %".8"
  %".41" = alloca [100 x i32]
  store [100 x i32] %".40", [100 x i32]* %".41"
  %".43" = getelementptr [100 x i32], [100 x i32]* %".41", i32 0, i32 0
  %".44" = call i32 @"sort"(i32 %".39", i32* %".43")
  %".45" = load i32, i32* %".2"
  %".46" = load [100 x i32], [100 x i32]* %".8"
  %".47" = alloca [100 x i32]
  store [100 x i32] %".46", [100 x i32]* %".47"
  %".49" = getelementptr [100 x i32], [100 x i32]* %".47", i32 0, i32 0
  %".50" = call i32 @"print"(i32 %".45", i32* %".49")
  %".51" = load i32, i32* %".12"
  %".52" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([12 x i8], [12 x i8]* @"\22&asd[0]:%x\5cn\22", i32 0, i32 0), i32 %".51")
  ret i32 0
}

@"\22%d\22" = global [3 x i8] c"%d\00"
@"\22n:%xd\5cn\22" = global [7 x i8] c"n:%xd\0a\00"
@"\22&asd[0]:%x\5cn\22" = global [12 x i8] c"&asd[0]:%x\0a\00"