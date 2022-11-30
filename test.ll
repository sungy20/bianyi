; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

declare i32 @"scanf"(i8* %".1", ...)

define i32 @"main"()
{
main:
  %".2" = alloca i32
  %".3" = load i32, i32* %".2"
  %".4" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32 %".3")
  %".5" = alloca i32
  store i32 0, i32* %".5"
  %".7" = alloca [100 x i32], i32 100
  br label %"main.while_cond"
main.while_cond:
  %".9" = load i32, i32* %".5"
  %".10" = load i32, i32* %".2"
  %".11" = sub i32 %".10", 1
  %".12" = icmp slt i32 %".9", %".11"
  br i1 %".12", label %"main.while_body", label %"main.while_end"
main.while_body:
  %".14" = load i32, i32* %".5"
  %".15" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".14"
  %".16" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d,\22", i32 0, i32 0), i32* %".15")
  br label %"main.while_cond"
main.while_end:
  %".18" = load i32, i32* %".2"
  %".19" = sub i32 %".18", 1
  %".20" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".19"
  %".21" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32* %".20")
  br label %"main.while_end.while_cond"
main.while_end.while_cond:
  %".23" = load i32, i32* %".5"
  %".24" = load i32, i32* %".2"
  %".25" = sub i32 %".24", 1
  %".26" = icmp slt i32 %".23", %".25"
  br i1 %".26", label %"main.while_end.while_body", label %"main.while_end.while_end"
main.while_end.while_body:
  %".28" = load i32, i32* %".5"
  %".29" = add i32 %".28", 1
  %".30" = alloca i32
  store i32 %".29", i32* %".30"
  br label %"main.while_end.while_body.while_cond"
main.while_end.while_end:
  store i32 0, i32* %".5"
  br label %"main.while_end.while_end.while_cond"
main.while_end.while_body.while_cond:
  %".33" = load i32, i32* %".30"
  %".34" = load i32, i32* %".2"
  %".35" = icmp slt i32 %".33", %".34"
  br i1 %".35", label %"main.while_end.while_body.while_body", label %"main.while_end.while_body.while_end"
main.while_end.while_body.while_body:
  %".37" = load i32, i32* %".5"
  %".38" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".37"
  %".39" = load i32, i32* %".30"
  %".40" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".39"
  %".41" = load i32, i32* %".38"
  %".42" = load i32, i32* %".40"
  %".43" = icmp sgt i32 %".41", %".42"
  br i1 %".43", label %"main.while_end.while_body.while_body.if", label %"main.while_end.while_body.while_body.endif"
main.while_end.while_body.while_end:
  %".65" = load i32, i32* %".5"
  %".66" = add i32 %".65", 1
  store i32 %".66", i32* %".5"
  br label %"main.while_end.while_cond"
main.while_end.while_body.while_body.if:
  %".45" = load i32, i32* %".5"
  %".46" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".45"
  %".47" = load i32, i32* %".46"
  %".48" = alloca i32
  store i32 %".47", i32* %".48"
  %".50" = load i32, i32* %".5"
  %".51" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".50"
  %".52" = load i32, i32* %".30"
  %".53" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".52"
  %".54" = load i32, i32* %".53"
  store i32 %".54", i32* %".51"
  %".56" = load i32, i32* %".30"
  %".57" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".56"
  %".58" = load i32, i32* %".48"
  store i32 %".58", i32* %".57"
  br label %"main.while_end.while_body.while_body.endif"
main.while_end.while_body.while_body.endif:
  %".61" = load i32, i32* %".30"
  %".62" = add i32 %".61", 1
  store i32 %".62", i32* %".30"
  br label %"main.while_end.while_body.while_cond"
main.while_end.while_end.while_cond:
  %".71" = load i32, i32* %".5"
  %".72" = load i32, i32* %".2"
  %".73" = sub i32 %".72", 1
  %".74" = icmp slt i32 %".71", %".73"
  br i1 %".74", label %"main.while_end.while_end.while_body", label %"main.while_end.while_end.while_end"
main.while_end.while_end.while_body:
  %".76" = load i32, i32* %".5"
  %".77" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".76"
  %".78" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d,\22", i32 0, i32 0), i32* %".77")
  br label %"main.while_end.while_end.while_cond"
main.while_end.while_end.while_end:
  %".80" = load i32, i32* %".2"
  %".81" = sub i32 %".80", 1
  %".82" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 %".81"
  %".83" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32* %".82")
  %".84" = getelementptr [100 x i32], [100 x i32]* %".7", i32 0, i32 3
  %".85" = load i32, i32* %".84"
  ret i32 %".85"
}

@"\22%d\22" = global [3 x i8] c"%d\00"
@"\22%d,\22" = global [4 x i8] c"%d,\00"