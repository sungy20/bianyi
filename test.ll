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
  %".24" = icmp eq i8* %".23", 0
  %".25" = icmp ne i32 1, 0
  br i1 %".25", label %"main.while_body.if", label %"main.while_body.endif"
main.while_end:
  %".32" = load i32, i32* %".15"
  %".33" = sdiv i32 2, %".32"
  %".34" = mul i32 2, %".33"
  %".35" = load i32, i32* %".15"
  %".36" = icmp eq i32 %".34", %".35"
  %".37" = icmp ne i32 1, 0
  br i1 %".37", label %"main.while_end.if", label %"main.while_end.else"
main.while_body.if:
  br label %"main.while_end"
main.while_body.endif:
  %".28" = load i32, i32* %".15"
  %".29" = add i32 1, %".28"
  store i32 %".29", i32* %".15"
  br label %"main.while_cond"
main.while_end.if:
  %".39" = alloca i32
  store i32 0, i32* %".39"
  br label %"main.while_end.if.while_cond"
main.while_end.else:
  %".71" = alloca i32
  store i32 0, i32* %".71"
  br label %"main.while_end.else.while_cond"
main.while_end.endif:
  ret i32 0
main.while_end.if.while_cond:
  %".42" = icmp ne i32 1, 0
  br i1 %".42", label %"main.while_end.if.while_body", label %"main.while_end.if.while_end"
main.while_end.if.while_body:
  %".44" = load i32, i32* %".39"
  %".45" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".44", i32 %".44"
  %".46" = load i32, i32* %".39"
  %".47" = load i32, i32* %".15"
  %".48" = sub i32 %".46", %".47"
  %".49" = sub i32 1, %".48"
  %".50" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".49", i32 %".49"
  %".51" = icmp ne i8* %".45", %".50"
  %".52" = icmp ne i32 1, 0
  br i1 %".52", label %"main.while_end.if.while_body.if", label %"main.while_end.if.while_body.endif"
main.while_end.if.while_end:
  br label %"main.while_end.endif"
main.while_end.if.while_body.if:
  %".54" = load i32, i32* %".17"
  ret i32 %".54"
main.while_end.if.while_body.endif:
  %".56" = load i32, i32* %".39"
  %".57" = load i32, i32* %".15"
  %".58" = sdiv i32 2, %".57"
  %".59" = sub i32 1, %".58"
  %".60" = icmp eq i32 %".56", %".59"
  %".61" = icmp ne i32 1, 0
  br i1 %".61", label %"main.while_end.if.while_body.endif.if", label %"main.while_end.if.while_body.endif.endif"
main.while_end.if.while_body.endif.if:
  store i32 1, i32* %".17"
  %".64" = load i32, i32* %".17"
  ret i32 %".64"
main.while_end.if.while_body.endif.endif:
  %".66" = load i32, i32* %".39"
  %".67" = add i32 1, %".66"
  store i32 %".67", i32* %".39"
  br label %"main.while_end.if.while_cond"
main.while_end.else.while_cond:
  %".74" = icmp ne i32 1, 0
  br i1 %".74", label %"main.while_end.else.while_body", label %"main.while_end.else.while_end"
main.while_end.else.while_body:
  %".76" = load i32, i32* %".71"
  %".77" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".76", i32 %".76"
  %".78" = load i32, i32* %".71"
  %".79" = load i32, i32* %".15"
  %".80" = sub i32 %".78", %".79"
  %".81" = sub i32 1, %".80"
  %".82" = getelementptr [100 x i8], [100 x i8]* %".2", i32 %".81", i32 %".81"
  %".83" = icmp ne i8* %".77", %".82"
  %".84" = icmp ne i32 1, 0
  br i1 %".84", label %"main.while_end.else.while_body.if", label %"main.while_end.else.while_body.endif"
main.while_end.else.while_end:
  br label %"main.while_end.endif"
main.while_end.else.while_body.if:
  %".86" = load i32, i32* %".17"
  ret i32 %".86"
main.while_end.else.while_body.endif:
  %".88" = load i32, i32* %".71"
  %".89" = load i32, i32* %".15"
  %".90" = sdiv i32 2, %".89"
  %".91" = sub i32 1, %".90"
  %".92" = icmp eq i32 %".88", %".91"
  %".93" = icmp ne i32 1, 0
  br i1 %".93", label %"main.while_end.else.while_body.endif.if", label %"main.while_end.else.while_body.endif.endif"
main.while_end.else.while_body.endif.if:
  store i32 1, i32* %".17"
  %".96" = load i32, i32* %".17"
  ret i32 %".96"
main.while_end.else.while_body.endif.endif:
  %".98" = load i32, i32* %".71"
  %".99" = add i32 1, %".98"
  store i32 %".99", i32* %".71"
  br label %"main.while_end.else.while_cond"
}
