; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

declare i32 @"scanf"(i8* %".1", ...)

define i32 @"sort"(i32 %".1", i32* %".2")
{
sort:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %".6" = alloca i32*
  store i32* %".2", i32** %".6"
  %".8" = alloca i32
  store i32 0, i32* %".8"
  br label %"sort.while_cond"
sort.while_cond:
  %".11" = load i32, i32* %".4"
  %".12" = sub i32 %".11", 1
  %".13" = load i32, i32* %".8"
  %".14" = icmp slt i32 %".13", %".12"
  br i1 %".14", label %"sort.while_body", label %"sort.while_end"
sort.while_body:
  %".16" = load i32, i32* %".8"
  %".17" = add i32 %".16", 1
  store i32 %".17", i32* %".8"
  br label %"sort.while_cond"
sort.while_end:
  %".20" = alloca i32
  store i32 0, i32* %".20"
  br label %"sort.while_end.while_cond"
sort.while_end.while_cond:
  %".23" = load i32, i32* %".4"
  %".24" = sub i32 %".23", 1
  %".25" = load i32, i32* %".20"
  %".26" = icmp slt i32 %".25", %".24"
  br i1 %".26", label %"sort.while_end.while_body", label %"sort.while_end.while_end"
sort.while_end.while_body:
  %".28" = load i32, i32* %".20"
  %".29" = add i32 %".28", 1
  %".30" = alloca i32
  store i32 %".29", i32* %".30"
  br label %"sort.while_end.while_body.while_cond"
sort.while_end.while_end:
  store i32 0, i32* %".20"
  br label %"sort.while_end.while_end.while_cond"
sort.while_end.while_body.while_cond:
  %".33" = load i32, i32* %".30"
  %".34" = load i32, i32* %".4"
  %".35" = icmp slt i32 %".33", %".34"
  br i1 %".35", label %"sort.while_end.while_body.while_body", label %"sort.while_end.while_body.while_end"
sort.while_end.while_body.while_body:
  %".37" = load i32, i32* %".20"
  %".38" = load i32*, i32** %".6"
  %".39" = getelementptr i32, i32* %".38", i32 %".37"
  %".40" = load i32, i32* %".30"
  %".41" = load i32*, i32** %".6"
  %".42" = getelementptr i32, i32* %".41", i32 %".40"
  %".43" = load i32, i32* %".39"
  %".44" = load i32, i32* %".42"
  %".45" = icmp sgt i32 %".43", %".44"
  br i1 %".45", label %"sort.while_end.while_body.while_body.if", label %"sort.while_end.while_body.while_body.endif"
sort.while_end.while_body.while_end:
  %".71" = load i32, i32* %".20"
  %".72" = add i32 %".71", 1
  store i32 %".72", i32* %".20"
  br label %"sort.while_end.while_cond"
sort.while_end.while_body.while_body.if:
  %".47" = load i32, i32* %".20"
  %".48" = load i32*, i32** %".6"
  %".49" = getelementptr i32, i32* %".48", i32 %".47"
  %".50" = alloca i32
  %".51" = load i32, i32* %".49"
  store i32 %".51", i32* %".50"
  %".53" = load i32, i32* %".20"
  %".54" = load i32*, i32** %".6"
  %".55" = getelementptr i32, i32* %".54", i32 %".53"
  %".56" = load i32, i32* %".30"
  %".57" = load i32*, i32** %".6"
  %".58" = getelementptr i32, i32* %".57", i32 %".56"
  %".59" = load i32, i32* %".58"
  store i32 %".59", i32* %".55"
  %".61" = load i32, i32* %".30"
  %".62" = load i32*, i32** %".6"
  %".63" = getelementptr i32, i32* %".62", i32 %".61"
  %".64" = load i32, i32* %".50"
  store i32 %".64", i32* %".63"
  br label %"sort.while_end.while_body.while_body.endif"
sort.while_end.while_body.while_body.endif:
  %".67" = load i32, i32* %".30"
  %".68" = add i32 %".67", 1
  store i32 %".68", i32* %".30"
  br label %"sort.while_end.while_body.while_cond"
sort.while_end.while_end.while_cond:
  %".77" = load i32, i32* %".4"
  %".78" = sub i32 %".77", 1
  %".79" = load i32, i32* %".20"
  %".80" = icmp slt i32 %".79", %".78"
  br i1 %".80", label %"sort.while_end.while_end.while_body", label %"sort.while_end.while_end.while_end"
sort.while_end.while_end.while_body:
  %".82" = load i32, i32* %".20"
  %".83" = add i32 %".82", 1
  store i32 %".83", i32* %".20"
  br label %"sort.while_end.while_end.while_cond"
sort.while_end.while_end.while_end:
  ret i32 0
}

define i32 @"all_sort"(i32 %".1", i32* %".2")
{
all_sort:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %".6" = alloca i32*
  store i32* %".2", i32** %".6"
  %".8" = load i32, i32* %".4"
  %".9" = load i32*, i32** %".6"
  %".10" = call i32 @"sort"(i32 %".8", i32* %".9")
  %".11" = alloca i32
  store i32 0, i32* %".11"
  br label %"all_sort.while_cond"
all_sort.while_cond:
  %".14" = load i32, i32* %".4"
  %".15" = sub i32 %".14", 1
  %".16" = load i32, i32* %".11"
  %".17" = icmp slt i32 %".16", %".15"
  br i1 %".17", label %"all_sort.while_body", label %"all_sort.while_end"
all_sort.while_body:
  %".19" = load i32, i32* %".11"
  %".20" = add i32 %".19", 1
  store i32 %".20", i32* %".11"
  br label %"all_sort.while_cond"
all_sort.while_end:
  ret i32 0
}

define i32 @"main"()
{
main:
  %".2" = alloca i32
  %".3" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([57 x i8], [57 x i8]* @"\22please key in the total number of numbers to be sorted:\5cn\22", i32 0, i32 0))
  %".4" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([88 x i8], [88 x i8]* @"\22(press enter key every time after you key in one number or divide numbers with spaces)\5cn\22", i32 0, i32 0))
  %".5" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32* %".2")
  %".6" = load i32, i32* %".2"
  %".7" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([6 x i8], [6 x i8]* @"\22n:%d\5cn\22", i32 0, i32 0), i32 %".6")
  %".8" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([36 x i8], [36 x i8]* @"\22please key n numbers to be sorted:\5cn\22", i32 0, i32 0))
  %".9" = alloca i32
  store i32 0, i32* %".9"
  %".11" = alloca [100 x i32], i32 100
  br label %"main.while_cond"
main.while_cond:
  %".13" = load i32, i32* %".2"
  %".14" = sub i32 %".13", 1
  %".15" = load i32, i32* %".9"
  %".16" = icmp slt i32 %".15", %".14"
  br i1 %".16", label %"main.while_body", label %"main.while_end"
main.while_body:
  %".18" = load i32, i32* %".9"
  %".19" = getelementptr [100 x i32], [100 x i32]* %".11", i32 0, i32 %".18"
  %".20" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d,\22", i32 0, i32 0), i32* %".19")
  %".21" = load i32, i32* %".9"
  %".22" = add i32 %".21", 1
  store i32 %".22", i32* %".9"
  br label %"main.while_cond"
main.while_end:
  %".25" = load i32, i32* %".2"
  %".26" = sub i32 %".25", 1
  %".27" = getelementptr [100 x i32], [100 x i32]* %".11", i32 0, i32 %".26"
  %".28" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32* %".27")
  %".29" = load i32, i32* %".2"
  %".30" = load [100 x i32], [100 x i32]* %".11"
  %".31" = getelementptr [100 x i32], [100 x i32]* %".11", i32 0, i32 0
  %".32" = call i32 @"all_sort"(i32 %".29", i32* %".31")
  %".33" = alloca i32*
  %".34" = getelementptr [100 x i32], [100 x i32]* %".11", i32 0, i32 0
  store i32* %".34", i32** %".33"
  store i32 0, i32* %".9"
  %".37" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([31 x i8], [31 x i8]* @"\22sorted numbers are as follow:\5cn\22", i32 0, i32 0))
  br label %"main.while_end.while_cond"
main.while_end.while_cond:
  %".39" = load i32, i32* %".2"
  %".40" = sub i32 %".39", 1
  %".41" = load i32, i32* %".9"
  %".42" = icmp slt i32 %".41", %".40"
  br i1 %".42", label %"main.while_end.while_body", label %"main.while_end.while_end"
main.while_end.while_body:
  %".44" = load i32, i32* %".9"
  %".45" = load i32*, i32** %".33"
  %".46" = getelementptr i32, i32* %".45", i32 %".44"
  %".47" = load i32, i32* %".46"
  %".48" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d,\22", i32 0, i32 0), i32 %".47")
  %".49" = load i32, i32* %".9"
  %".50" = add i32 %".49", 1
  store i32 %".50", i32* %".9"
  br label %"main.while_end.while_cond"
main.while_end.while_end:
  %".53" = load i32, i32* %".2"
  %".54" = sub i32 %".53", 1
  %".55" = load i32*, i32** %".33"
  %".56" = getelementptr i32, i32* %".55", i32 %".54"
  %".57" = load i32, i32* %".56"
  %".58" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d\5cn\22", i32 0, i32 0), i32 %".57")
  ret i32 0
}

@"\22please key in the total number of numbers to be sorted:\5cn\22" = global [57 x i8] c"please key in the total number of numbers to be sorted:\0a\00"
@"\22(press enter key every time after you key in one number or divide numbers with spaces)\5cn\22" = global [88 x i8] c"(press enter key every time after you key in one number or divide numbers with spaces)\0a\00"
@"\22%d\22" = global [3 x i8] c"%d\00"
@"\22n:%d\5cn\22" = global [6 x i8] c"n:%d\0a\00"
@"\22please key n numbers to be sorted:\5cn\22" = global [36 x i8] c"please key n numbers to be sorted:\0a\00"
@"\22%d,\22" = global [4 x i8] c"%d,\00"
@"\22sorted numbers are as follow:\5cn\22" = global [31 x i8] c"sorted numbers are as follow:\0a\00"
@"\22%d\5cn\22" = global [4 x i8] c"%d\0a\00"