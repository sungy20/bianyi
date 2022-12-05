; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

declare i32 @"scanf"(i8* %".1", ...)

define i32 @"huiwen"(i8* %".1")
{
huiwen:
  %".3" = load i8, i8* %".1"
  %".4" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%s\5cn\22", i32 0, i32 0), i8 %".3")
  %".5" = alloca i32
  store i32 0, i32* %".5"
  %".7" = alloca i32
  store i32 0, i32* %".7"
  br label %"huiwen.while_cond"
huiwen.while_cond:
  %".10" = icmp ne i32 1, 0
  br i1 %".10", label %"huiwen.while_body", label %"huiwen.while_end"
huiwen.while_body:
  %".12" = load i32, i32* %".5"
  %".13" = getelementptr i8, i8* %".1", i32 %".12"
  %".14" = load i8, i8* %".13"
  %".15" = icmp eq i8 %".14", 0
  br i1 %".15", label %"huiwen.while_body.if", label %"huiwen.while_body.endif"
huiwen.while_end:
  %".22" = load i32, i32* %".5"
  %".23" = sdiv i32 %".22", 2
  %".24" = mul i32 %".23", 2
  %".25" = load i32, i32* %".5"
  %".26" = icmp eq i32 %".24", %".25"
  br i1 %".26", label %"huiwen.while_end.if", label %"huiwen.while_end.else"
huiwen.while_body.if:
  br label %"huiwen.while_end"
huiwen.while_body.endif:
  %".18" = load i32, i32* %".5"
  %".19" = add i32 %".18", 1
  store i32 %".19", i32* %".5"
  br label %"huiwen.while_cond"
huiwen.while_end.if:
  %".28" = alloca i32
  store i32 0, i32* %".28"
  br label %"huiwen.while_end.if.while_cond"
huiwen.while_end.else:
  %".59" = alloca i32
  store i32 0, i32* %".59"
  br label %"huiwen.while_end.else.while_cond"
huiwen.while_end.endif:
  %".91" = load i32, i32* %".7"
  ret i32 %".91"
huiwen.while_end.if.while_cond:
  %".31" = icmp ne i32 1, 0
  br i1 %".31", label %"huiwen.while_end.if.while_body", label %"huiwen.while_end.if.while_end"
huiwen.while_end.if.while_body:
  %".33" = load i32, i32* %".28"
  %".34" = getelementptr i8, i8* %".1", i32 %".33"
  %".35" = load i32, i32* %".5"
  %".36" = load i32, i32* %".28"
  %".37" = sub i32 %".35", %".36"
  %".38" = sub i32 %".37", 1
  %".39" = getelementptr i8, i8* %".1", i32 %".38"
  %".40" = load i8, i8* %".34"
  %".41" = load i8, i8* %".39"
  %".42" = icmp ne i8 %".40", %".41"
  br i1 %".42", label %"huiwen.while_end.if.while_body.if", label %"huiwen.while_end.if.while_body.endif"
huiwen.while_end.if.while_end:
  br label %"huiwen.while_end.endif"
huiwen.while_end.if.while_body.if:
  %".44" = load i32, i32* %".7"
  ret i32 %".44"
huiwen.while_end.if.while_body.endif:
  %".46" = load i32, i32* %".5"
  %".47" = sdiv i32 %".46", 2
  %".48" = load i32, i32* %".28"
  %".49" = icmp eq i32 %".48", %".47"
  br i1 %".49", label %"huiwen.while_end.if.while_body.endif.if", label %"huiwen.while_end.if.while_body.endif.endif"
huiwen.while_end.if.while_body.endif.if:
  store i32 1, i32* %".7"
  %".52" = load i32, i32* %".7"
  ret i32 %".52"
huiwen.while_end.if.while_body.endif.endif:
  %".54" = load i32, i32* %".28"
  %".55" = add i32 %".54", 1
  store i32 %".55", i32* %".28"
  br label %"huiwen.while_end.if.while_cond"
huiwen.while_end.else.while_cond:
  %".62" = icmp ne i32 1, 0
  br i1 %".62", label %"huiwen.while_end.else.while_body", label %"huiwen.while_end.else.while_end"
huiwen.while_end.else.while_body:
  %".64" = load i32, i32* %".59"
  %".65" = getelementptr i8, i8* %".1", i32 %".64"
  %".66" = load i32, i32* %".5"
  %".67" = load i32, i32* %".59"
  %".68" = sub i32 %".66", %".67"
  %".69" = sub i32 %".68", 1
  %".70" = getelementptr i8, i8* %".1", i32 %".69"
  %".71" = load i8, i8* %".65"
  %".72" = load i8, i8* %".70"
  %".73" = icmp ne i8 %".71", %".72"
  br i1 %".73", label %"huiwen.while_end.else.while_body.if", label %"huiwen.while_end.else.while_body.endif"
huiwen.while_end.else.while_end:
  br label %"huiwen.while_end.endif"
huiwen.while_end.else.while_body.if:
  %".75" = load i32, i32* %".7"
  ret i32 %".75"
huiwen.while_end.else.while_body.endif:
  %".77" = load i32, i32* %".5"
  %".78" = sdiv i32 %".77", 2
  %".79" = sub i32 %".78", 1
  %".80" = load i32, i32* %".59"
  %".81" = icmp eq i32 %".80", %".79"
  br i1 %".81", label %"huiwen.while_end.else.while_body.endif.if", label %"huiwen.while_end.else.while_body.endif.endif"
huiwen.while_end.else.while_body.endif.if:
  store i32 1, i32* %".7"
  %".84" = load i32, i32* %".7"
  ret i32 %".84"
huiwen.while_end.else.while_body.endif.endif:
  %".86" = load i32, i32* %".59"
  %".87" = add i32 %".86", 1
  store i32 %".87", i32* %".59"
  br label %"huiwen.while_end.else.while_cond"
}

@"\22%s\5cn\22" = global [4 x i8] c"%s\0a\00"
define i32 @"main"()
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%s\22", i32 0, i32 0), [100 x i8]* %".2")
  %".4" = load [100 x i8], [100 x i8]* %".2"
  %".5" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%s\5cn\22", i32 0, i32 0), [100 x i8]* %".2")
  %".6" = load [100 x i8], [100 x i8]* %".2"
  %".7" = alloca [100 x i8]
  store [100 x i8] %".6", [100 x i8]* %".7"
  %".9" = getelementptr [100 x i8], [100 x i8]* %".7", i32 0, i32 0
  %".10" = call i32 @"huiwen"(i8* %".9")
  %".11" = alloca i32
  store i32 %".10", i32* %".11"
  %".13" = load i32, i32* %".11"
  %".14" = icmp eq i32 %".13", 1
  br i1 %".14", label %"main.if", label %"main.else"
main.if:
  %".16" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([6 x i8], [6 x i8]* @"\22True\5cn\22", i32 0, i32 0))
  br label %"main.endif"
main.else:
  %".18" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([7 x i8], [7 x i8]* @"\22False\5cn\22", i32 0, i32 0))
  br label %"main.endif"
main.endif:
  %".20" = load i32, i32* %".11"
  ret i32 %".20"
}

@"\22%s\22" = global [3 x i8] c"%s\00"
@"\22True\5cn\22" = global [6 x i8] c"True\0a\00"
@"\22False\5cn\22" = global [7 x i8] c"False\0a\00"