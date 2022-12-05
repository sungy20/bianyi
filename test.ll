; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

declare i32 @"scanf"(i8* %".1", ...)

define i32 @"huiwen"(i8* %".1")
{
huiwen:
  %".3" = alloca i8*
  store i8* %".1", i8** %".3"
  %".5" = load i8*, i8** %".3"
  %".6" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%s\5cn\22", i32 0, i32 0), i8* %".5")
  %".7" = alloca i32
  store i32 0, i32* %".7"
  %".9" = alloca i32
  store i32 0, i32* %".9"
  br label %"huiwen.while_cond"
huiwen.while_cond:
  %".12" = icmp ne i32 1, 0
  br i1 %".12", label %"huiwen.while_body", label %"huiwen.while_end"
huiwen.while_body:
  %".14" = load i32, i32* %".7"
  %".15" = load i8*, i8** %".3"
  %".16" = getelementptr i8, i8* %".15", i32 %".14"
  %".17" = load i8, i8* %".16"
  %".18" = icmp eq i8 %".17", 0
  br i1 %".18", label %"huiwen.while_body.if", label %"huiwen.while_body.endif"
huiwen.while_end:
  %".25" = load i32, i32* %".7"
  %".26" = sdiv i32 %".25", 2
  %".27" = mul i32 %".26", 2
  %".28" = load i32, i32* %".7"
  %".29" = icmp eq i32 %".27", %".28"
  br i1 %".29", label %"huiwen.while_end.if", label %"huiwen.while_end.else"
huiwen.while_body.if:
  br label %"huiwen.while_end"
huiwen.while_body.endif:
  %".21" = load i32, i32* %".7"
  %".22" = add i32 %".21", 1
  store i32 %".22", i32* %".7"
  br label %"huiwen.while_cond"
huiwen.while_end.if:
  %".31" = alloca i32
  store i32 0, i32* %".31"
  br label %"huiwen.while_end.if.while_cond"
huiwen.while_end.else:
  %".64" = alloca i32
  store i32 0, i32* %".64"
  br label %"huiwen.while_end.else.while_cond"
huiwen.while_end.endif:
  %".98" = load i32, i32* %".9"
  ret i32 %".98"
huiwen.while_end.if.while_cond:
  %".34" = icmp ne i32 1, 0
  br i1 %".34", label %"huiwen.while_end.if.while_body", label %"huiwen.while_end.if.while_end"
huiwen.while_end.if.while_body:
  %".36" = load i32, i32* %".31"
  %".37" = load i8*, i8** %".3"
  %".38" = getelementptr i8, i8* %".37", i32 %".36"
  %".39" = load i32, i32* %".7"
  %".40" = load i32, i32* %".31"
  %".41" = sub i32 %".39", %".40"
  %".42" = sub i32 %".41", 1
  %".43" = load i8*, i8** %".3"
  %".44" = getelementptr i8, i8* %".43", i32 %".42"
  %".45" = load i8, i8* %".38"
  %".46" = load i8, i8* %".44"
  %".47" = icmp ne i8 %".45", %".46"
  br i1 %".47", label %"huiwen.while_end.if.while_body.if", label %"huiwen.while_end.if.while_body.endif"
huiwen.while_end.if.while_end:
  br label %"huiwen.while_end.endif"
huiwen.while_end.if.while_body.if:
  %".49" = load i32, i32* %".9"
  ret i32 %".49"
huiwen.while_end.if.while_body.endif:
  %".51" = load i32, i32* %".7"
  %".52" = sdiv i32 %".51", 2
  %".53" = load i32, i32* %".31"
  %".54" = icmp eq i32 %".53", %".52"
  br i1 %".54", label %"huiwen.while_end.if.while_body.endif.if", label %"huiwen.while_end.if.while_body.endif.endif"
huiwen.while_end.if.while_body.endif.if:
  store i32 1, i32* %".9"
  %".57" = load i32, i32* %".9"
  ret i32 %".57"
huiwen.while_end.if.while_body.endif.endif:
  %".59" = load i32, i32* %".31"
  %".60" = add i32 %".59", 1
  store i32 %".60", i32* %".31"
  br label %"huiwen.while_end.if.while_cond"
huiwen.while_end.else.while_cond:
  %".67" = icmp ne i32 1, 0
  br i1 %".67", label %"huiwen.while_end.else.while_body", label %"huiwen.while_end.else.while_end"
huiwen.while_end.else.while_body:
  %".69" = load i32, i32* %".64"
  %".70" = load i8*, i8** %".3"
  %".71" = getelementptr i8, i8* %".70", i32 %".69"
  %".72" = load i32, i32* %".7"
  %".73" = load i32, i32* %".64"
  %".74" = sub i32 %".72", %".73"
  %".75" = sub i32 %".74", 1
  %".76" = load i8*, i8** %".3"
  %".77" = getelementptr i8, i8* %".76", i32 %".75"
  %".78" = load i8, i8* %".71"
  %".79" = load i8, i8* %".77"
  %".80" = icmp ne i8 %".78", %".79"
  br i1 %".80", label %"huiwen.while_end.else.while_body.if", label %"huiwen.while_end.else.while_body.endif"
huiwen.while_end.else.while_end:
  br label %"huiwen.while_end.endif"
huiwen.while_end.else.while_body.if:
  %".82" = load i32, i32* %".9"
  ret i32 %".82"
huiwen.while_end.else.while_body.endif:
  %".84" = load i32, i32* %".7"
  %".85" = sdiv i32 %".84", 2
  %".86" = sub i32 %".85", 1
  %".87" = load i32, i32* %".64"
  %".88" = icmp eq i32 %".87", %".86"
  br i1 %".88", label %"huiwen.while_end.else.while_body.endif.if", label %"huiwen.while_end.else.while_body.endif.endif"
huiwen.while_end.else.while_body.endif.if:
  store i32 1, i32* %".9"
  %".91" = load i32, i32* %".9"
  ret i32 %".91"
huiwen.while_end.else.while_body.endif.endif:
  %".93" = load i32, i32* %".64"
  %".94" = add i32 %".93", 1
  store i32 %".94", i32* %".64"
  br label %"huiwen.while_end.else.while_cond"
}

@"\22%s\5cn\22" = global [4 x i8] c"%s\0a\00"
define i32 @"main"()
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%s\22", i32 0, i32 0), [100 x i8]* %".2")
  %".4" = load [100 x i8], [100 x i8]* %".2"
  %".5" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([9 x i8], [9 x i8]* @"\22 str:%s\5cn\22", i32 0, i32 0), [100 x i8]* %".2")
  %".6" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([10 x i8], [10 x i8]* @"\22 &str:%d\5cn\22", i32 0, i32 0), [100 x i8]* %".2")
  %".7" = load [100 x i8], [100 x i8]* %".2"
  %".8" = alloca [100 x i8]
  store [100 x i8] %".7", [100 x i8]* %".8"
  %".10" = getelementptr [100 x i8], [100 x i8]* %".8", i32 0, i32 0
  %".11" = alloca i8*
  store i8* %".10", i8** %".11"
  %".13" = load i8*, i8** %".11"
  %".14" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([11 x i8], [11 x i8]* @"\22 array:%s\5cn\22", i32 0, i32 0), i8* %".13")
  %".15" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([12 x i8], [12 x i8]* @"\22 &array:%d\5cn\22", i32 0, i32 0), i8** %".11")
  %".16" = alloca i32
  store i32 10, i32* %".16"
  %".18" = load i32, i32* %".16"
  %".19" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([7 x i8], [7 x i8]* @"\22 i:%d\5cn\22", i32 0, i32 0), i32 %".18")
  %".20" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([8 x i8], [8 x i8]* @"\22 &i:%d\5cn\22", i32 0, i32 0), i32* %".16")
  %".21" = load [100 x i8], [100 x i8]* %".2"
  %".22" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  %".23" = call i32 @"huiwen"(i8* %".22")
  %".24" = alloca i32
  store i32 %".23", i32* %".24"
  %".26" = load i32, i32* %".24"
  %".27" = icmp eq i32 %".26", 1
  br i1 %".27", label %"main.if", label %"main.else"
main.if:
  %".29" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([6 x i8], [6 x i8]* @"\22True\5cn\22", i32 0, i32 0))
  br label %"main.endif"
main.else:
  %".31" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([7 x i8], [7 x i8]* @"\22False\5cn\22", i32 0, i32 0))
  br label %"main.endif"
main.endif:
  %".33" = load i32, i32* %".24"
  ret i32 %".33"
}

@"\22%s\22" = global [3 x i8] c"%s\00"
@"\22 str:%s\5cn\22" = global [9 x i8] c" str:%s\0a\00"
@"\22 &str:%d\5cn\22" = global [10 x i8] c" &str:%d\0a\00"
@"\22 array:%s\5cn\22" = global [11 x i8] c" array:%s\0a\00"
@"\22 &array:%d\5cn\22" = global [12 x i8] c" &array:%d\0a\00"
@"\22 i:%d\5cn\22" = global [7 x i8] c" i:%d\0a\00"
@"\22 &i:%d\5cn\22" = global [8 x i8] c" &i:%d\0a\00"
@"\22True\5cn\22" = global [6 x i8] c"True\0a\00"
@"\22False\5cn\22" = global [7 x i8] c"False\0a\00"