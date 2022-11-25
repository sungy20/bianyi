; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...) 

define i32 @"main"() 
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  store i8 49, i8* %".3"
  %".5" = getelementptr [100 x i8], [100 x i8]* %".2", i32 1, i32 1
  store i8 50, i8* %".5"
  %".7" = getelementptr [100 x i8], [100 x i8]* %".2", i32 2, i32 2
  store i8 51, i8* %".7"
  %".9" = getelementptr [100 x i8], [100 x i8]* %".2", i32 3, i32 3
  store i8 50, i8* %".9"
  %".11" = getelementptr [100 x i8], [100 x i8]* %".2", i32 4, i32 4
  store i8 49, i8* %".11"
  %".13" = getelementptr [100 x i8], [100 x i8]* %".2", i32 5, i32 5
  store i8 0, i8* %".13"
  %".15" = alloca i32
  store i32 0, i32* %".15"
  %".17" = alloca i32
  store i32 0, i32* %".17"
  br label %"main.while_cond"
main.while_cond:
  %".20" = icmp ne i32 1, 0
  br i1 %".20", label %"main.while_body", label %"main.while_end"
main.while_body:
  %".22" = load i32, i32* %".15"
  %".23" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".22", i32 %".22"
  %".24" = load i8, i8* %".23"
  %".25" = icmp eq i8 %".24", 0
  br i1 %".25", label %"main.while_body.if", label %"main.while_body.endif"
main.while_end:
  %".32" = load i32, i32* %".15"
  %".33" = sdiv i32 %".32", 2
  %".34" = mul i32 %".33", 2
  %".35" = load i32, i32* %".15"
  %".36" = icmp eq i32 %".34", %".35"
  br i1 %".36", label %"main.while_end.if", label %"main.while_end.else"
main.while_body.if:
  br label %"main.while_end"
main.while_body.endif:
  %".28" = load i32, i32* %".15"
  %".29" = add i32 %".28", 1
  store i32 %".29", i32* %".15"
  br label %"main.while_cond"
main.while_end.if:
  %".38" = alloca i32
  store i32 0, i32* %".38"
  br label %"main.while_end.if.while_cond"
main.while_end.else:
  %".69" = alloca i32
  store i32 0, i32* %".69"
  br label %"main.while_end.else.while_cond"
main.while_end.endif:
  %".101" = load i32, i32* %".17"
  ret i32 %".101"
main.while_end.if.while_cond:
  %".41" = icmp ne i32 1, 0
  br i1 %".41", label %"main.while_end.if.while_body", label %"main.while_end.if.while_end"
main.while_end.if.while_body:
  %".43" = load i32, i32* %".38"
  %".44" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".43", i32 %".43"
  %".45" = load i32, i32* %".38"
  %".46" = load i32, i32* %".15"
  %".47" = sub i32 %".46", %".45"
  %".48" = sub i32 %".47", 1
  %".49" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".48", i32 %".48"
  %".50" = load i8, i8* %".44"
  %".51" = load i8, i8* %".49"
  %".52" = icmp ne i8 %".50", %".51"
  br i1 %".52", label %"main.while_end.if.while_body.if", label %"main.while_end.if.while_body.endif"
main.while_end.if.while_end:
  br label %"main.while_end.endif"
main.while_end.if.while_body.if:
  %".54" = load i32, i32* %".17"
  ret i32 %".54"
main.while_end.if.while_body.endif:
  %".56" = load i32, i32* %".38"
  %".57" = load i32, i32* %".15"
  %".58" = sdiv i32 %".57", 2
  %".59" = icmp eq i32 %".56", %".58"
  br i1 %".59", label %"main.while_end.if.while_body.endif.if", label %"main.while_end.if.while_body.endif.endif"
main.while_end.if.while_body.endif.if:
  store i32 1, i32* %".17"
  %".62" = load i32, i32* %".17"
  ret i32 %".62"
main.while_end.if.while_body.endif.endif:
  %".64" = load i32, i32* %".38"
  %".65" = add i32 %".64", 1
  store i32 %".65", i32* %".38"
  br label %"main.while_end.if.while_cond"
main.while_end.else.while_cond:
  %".72" = icmp ne i32 1, 0
  br i1 %".72", label %"main.while_end.else.while_body", label %"main.while_end.else.while_end"
main.while_end.else.while_body:
  %".74" = load i32, i32* %".69"
  %".75" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".74", i32 %".74"
  %".76" = load i32, i32* %".69"
  %".77" = load i32, i32* %".15"
  %".78" = sub i32 %".77", %".76"
  %".79" = sub i32 %".78", 1
  %".80" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".79", i32 %".79"
  %".81" = load i8, i8* %".75"
  %".82" = load i8, i8* %".80"
  %".83" = icmp ne i8 %".81", %".82"
  br i1 %".83", label %"main.while_end.else.while_body.if", label %"main.while_end.else.while_body.endif"
main.while_end.else.while_end:
  br label %"main.while_end.endif"
main.while_end.else.while_body.if:
  store i32 0, i32* %".17"
  br label %"main.while_end.else.while_body.endif"
main.while_end.else.while_body.endif:
  %".87" = load i32, i32* %".69"
  %".88" = load i32, i32* %".15"
  %".89" = sdiv i32 %".88", 2
  %".90" = sub i32 %".89", 1
  %".91" = icmp eq i32 %".87", %".90"
  br i1 %".91", label %"main.while_end.else.while_body.endif.if", label %"main.while_end.else.while_body.endif.endif"
main.while_end.else.while_body.endif.if:
  store i32 1, i32* %".17"
  %".94" = load i32, i32* %".17"
  ret i32 %".94"
main.while_end.else.while_body.endif.endif:
  %".96" = load i32, i32* %".69"
  %".97" = add i32 %".96", 1
  store i32 %".97", i32* %".69"
  br label %"main.while_end.else.while_cond"
}
