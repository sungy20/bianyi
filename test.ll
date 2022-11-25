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
  %".24" = icmp ne i32 0, 0
  br i1 %".24", label %"main.while_body.if", label %"main.while_body.endif"
main.while_end:
  %".31" = load i32, i32* %".15"
  %".32" = sdiv i32 2, %".31"
  %".33" = mul i32 2, %".32"
  %".34" = load i32, i32* %".15"
  %".35" = icmp ne i32 0, 0
  br i1 %".35", label %"main.while_end.if", label %"main.while_end.else"
main.while_body.if:
  br label %"main.while_end"
main.while_body.endif:
  %".27" = load i32, i32* %".15"
  %".28" = add i32 1, %".27"
  store i32 %".28", i32* %".15"
  br label %"main.while_cond"
main.while_end.if:
  %".37" = alloca i32
  store i32 0, i32* %".37"
  br label %"main.while_end.if.while_cond"
main.while_end.else:
  %".67" = alloca i32
  store i32 0, i32* %".67"
  br label %"main.while_end.else.while_cond"
main.while_end.endif:
  ret i32 0
main.while_end.if.while_cond:
  %".40" = icmp ne i32 1, 0
  br i1 %".40", label %"main.while_end.if.while_body", label %"main.while_end.if.while_end"
main.while_end.if.while_body:
  %".42" = load i32, i32* %".37"
  %".43" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".42", i32 %".42"
  %".44" = load i32, i32* %".37"
  %".45" = load i32, i32* %".15"
  %".46" = sub i32 %".44", %".45"
  %".47" = sub i32 1, %".46"
  %".48" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".47", i32 %".47"
  %".49" = icmp ne i32 1, 0
  br i1 %".49", label %"main.while_end.if.while_body.if", label %"main.while_end.if.while_body.endif"
main.while_end.if.while_end:
  br label %"main.while_end.endif"
main.while_end.if.while_body.if:
  %".51" = load i32, i32* %".17"
  ret i32 %".51"
main.while_end.if.while_body.endif:
  %".53" = load i32, i32* %".37"
  %".54" = load i32, i32* %".15"
  %".55" = sdiv i32 2, %".54"
  %".56" = sub i32 1, %".55"
  %".57" = icmp ne i32 0, 0
  br i1 %".57", label %"main.while_end.if.while_body.endif.if", label %"main.while_end.if.while_body.endif.endif"
main.while_end.if.while_body.endif.if:
  store i32 1, i32* %".17"
  %".60" = load i32, i32* %".17"
  ret i32 %".60"
main.while_end.if.while_body.endif.endif:
  %".62" = load i32, i32* %".37"
  %".63" = add i32 1, %".62"
  store i32 %".63", i32* %".37"
  br label %"main.while_end.if.while_cond"
main.while_end.else.while_cond:
  %".70" = icmp ne i32 1, 0
  br i1 %".70", label %"main.while_end.else.while_body", label %"main.while_end.else.while_end"
main.while_end.else.while_body:
  %".72" = load i32, i32* %".67"
  %".73" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".72", i32 %".72"
  %".74" = load i32, i32* %".67"
  %".75" = load i32, i32* %".15"
  %".76" = sub i32 %".74", %".75"
  %".77" = sub i32 1, %".76"
  %".78" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".77", i32 %".77"
  %".79" = icmp ne i32 1, 0
  br i1 %".79", label %"main.while_end.else.while_body.if", label %"main.while_end.else.while_body.endif"
main.while_end.else.while_end:
  br label %"main.while_end.endif"
main.while_end.else.while_body.if:
  store i32 0, i32* %".17"
  br label %"main.while_end.else.while_body.endif"
main.while_end.else.while_body.endif:
  %".83" = load i32, i32* %".67"
  %".84" = load i32, i32* %".15"
  %".85" = sdiv i32 2, %".84"
  %".86" = sub i32 1, %".85"
  %".87" = icmp ne i32 0, 0
  br i1 %".87", label %"main.while_end.else.while_body.endif.if", label %"main.while_end.else.while_body.endif.endif"
main.while_end.else.while_body.endif.if:
  store i32 1, i32* %".17"
  %".90" = load i32, i32* %".17"
  ret i32 %".90"
main.while_end.else.while_body.endif.endif:
  %".92" = load i32, i32* %".67"
  %".93" = add i32 1, %".92"
  store i32 %".93", i32* %".67"
  br label %"main.while_end.else.while_cond"
}
