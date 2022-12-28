; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...) 

declare i32 @"scanf"(i8* %".1", ...) 

define i32 @"EmptyStack"(i32* %".1") 
{
EmptyStack:
  %".3" = alloca i32*
  store i32* %".1", i32** %".3"
  %".5" = load i32*, i32** %".3"
  %".6" = getelementptr i32, i32* %".5", i32 0
  %".7" = load i32, i32* %".6"
  %".8" = icmp eq i32 %".7", 0
  br i1 %".8", label %"EmptyStack.if", label %"EmptyStack.endif"
EmptyStack.if:
  ret i32 1
EmptyStack.endif:
  ret i32 0
}

define i32 @"Push"(i32 %".1", i32* %".2", i32* %".3") 
{
Push:
  %".5" = alloca i32
  store i32 %".1", i32* %".5"
  %".7" = alloca i32*
  store i32* %".2", i32** %".7"
  %".9" = alloca i32*
  store i32* %".3", i32** %".9"
  %".11" = load i32*, i32** %".7"
  %".12" = getelementptr i32, i32* %".11", i32 0
  %".13" = alloca i32
  %".14" = load i32, i32* %".12"
  store i32 %".14", i32* %".13"
  %".16" = load i32, i32* %".13"
  %".17" = load i32*, i32** %".9"
  %".18" = getelementptr i32, i32* %".17", i32 %".16"
  %".19" = load i32, i32* %".5"
  store i32 %".19", i32* %".18"
  %".21" = load i32*, i32** %".7"
  %".22" = getelementptr i32, i32* %".21", i32 0
  %".23" = load i32*, i32** %".7"
  %".24" = getelementptr i32, i32* %".23", i32 0
  %".25" = load i32, i32* %".24"
  %".26" = add i32 %".25", 1
  store i32 %".26", i32* %".22"
  ret i32 1
}

define i32 @"GetTop"(i32* %".1", i32* %".2") 
{
GetTop:
  %".4" = alloca i32*
  store i32* %".1", i32** %".4"
  %".6" = alloca i32*
  store i32* %".2", i32** %".6"
  %".8" = load i32*, i32** %".4"
  %".9" = getelementptr i32, i32* %".8", i32 0
  %".10" = alloca i32
  %".11" = load i32, i32* %".9"
  store i32 %".11", i32* %".10"
  %".13" = load i32, i32* %".10"
  %".14" = sub i32 %".13", 1
  store i32 %".14", i32* %".10"
  %".16" = load i32, i32* %".10"
  %".17" = load i32*, i32** %".6"
  %".18" = getelementptr i32, i32* %".17", i32 %".16"
  %".19" = alloca i32
  %".20" = load i32, i32* %".18"
  store i32 %".20", i32* %".19"
  %".22" = load i32, i32* %".19"
  ret i32 %".22"
}

define i32 @"Priority"(i32 %".1") 
{
Priority:
  %".3" = alloca i32
  store i32 %".1", i32* %".3"
  %".5" = alloca i32
  store i32 0, i32* %".5"
  %".7" = load i32, i32* %".3"
  %".8" = icmp eq i32 %".7", 40
  br i1 %".8", label %"Priority.if", label %"Priority.endif"
Priority.if:
  store i32 3, i32* %".5"
  br label %"Priority.endif"
Priority.endif:
  %".12" = load i32, i32* %".3"
  %".13" = icmp eq i32 %".12", 42
  br i1 %".13", label %"Priority.endif.if", label %"Priority.endif.endif"
Priority.endif.if:
  store i32 2, i32* %".5"
  br label %"Priority.endif.endif"
Priority.endif.endif:
  %".17" = load i32, i32* %".3"
  %".18" = icmp eq i32 %".17", 47
  br i1 %".18", label %"Priority.endif.endif.if", label %"Priority.endif.endif.endif"
Priority.endif.endif.if:
  store i32 2, i32* %".5"
  br label %"Priority.endif.endif.endif"
Priority.endif.endif.endif:
  %".22" = load i32, i32* %".3"
  %".23" = icmp eq i32 %".22", 43
  br i1 %".23", label %"Priority.endif.endif.endif.if", label %"Priority.endif.endif.endif.endif"
Priority.endif.endif.endif.if:
  store i32 1, i32* %".5"
  br label %"Priority.endif.endif.endif.endif"
Priority.endif.endif.endif.endif:
  %".27" = load i32, i32* %".3"
  %".28" = icmp eq i32 %".27", 45
  br i1 %".28", label %"Priority.endif.endif.endif.endif.if", label %"Priority.endif.endif.endif.endif.endif"
Priority.endif.endif.endif.endif.if:
  store i32 1, i32* %".5"
  br label %"Priority.endif.endif.endif.endif.endif"
Priority.endif.endif.endif.endif.endif:
  %".32" = load i32, i32* %".5"
  ret i32 %".32"
}

define i32 @"Pop"(i32* %".1", i32* %".2") 
{
Pop:
  %".4" = alloca i32*
  store i32* %".1", i32** %".4"
  %".6" = alloca i32*
  store i32* %".2", i32** %".6"
  %".8" = alloca i32
  %".9" = load i32*, i32** %".4"
  %".10" = getelementptr i32, i32* %".9", i32 0
  %".11" = load i32*, i32** %".4"
  %".12" = getelementptr i32, i32* %".11", i32 0
  %".13" = load i32, i32* %".12"
  %".14" = sub i32 %".13", 1
  store i32 %".14", i32* %".10"
  %".16" = load i32*, i32** %".4"
  %".17" = getelementptr i32, i32* %".16", i32 0
  %".18" = alloca i32
  %".19" = load i32, i32* %".17"
  store i32 %".19", i32* %".18"
  %".21" = load i32, i32* %".18"
  %".22" = load i32*, i32** %".6"
  %".23" = getelementptr i32, i32* %".22", i32 %".21"
  %".24" = load i32, i32* %".23"
  store i32 %".24", i32* %".8"
  %".26" = load i32, i32* %".8"
  ret i32 %".26"
}

define i32 @"cal"(i8* %".1") 
{
cal:
  %".3" = alloca i8*
  store i8* %".1", i8** %".3"
  %".5" = alloca [200 x i32], i32 200
  %".6" = alloca [100 x i32], i32 100
  %".7" = alloca [1 x i32], i32 1
  %".8" = alloca [1 x i32], i32 1
  %".9" = alloca i32
  store i32 0, i32* %".9"
  %".11" = alloca i32
  store i32 0, i32* %".11"
  %".13" = alloca i32
  %".14" = alloca i32
  %".15" = alloca i32
  store i32 0, i32* %".15"
  %".17" = load i32, i32* %".9"
  %".18" = load i8*, i8** %".3"
  %".19" = getelementptr i8, i8* %".18", i32 %".17"
  %".20" = alloca i32
  %".21" = load i8, i8* %".19"
  %".22" = zext i8 %".21" to i32
  store i32 %".22", i32* %".20"
  %".24" = alloca i32
  store i32 0, i32* %".24"
  %".26" = alloca i32
  store i32 0, i32* %".26"
  %".28" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  store i32 0, i32* %".28"
  %".30" = getelementptr [1 x i32], [1 x i32]* %".8", i32 0, i32 0
  store i32 0, i32* %".30"
  br label %"cal.while_cond"
cal.while_cond:
  %".33" = load i32, i32* %".9"
  %".34" = load i8*, i8** %".3"
  %".35" = getelementptr i8, i8* %".34", i32 %".33"
  %".36" = load i8, i8* %".35"
  %".37" = icmp ne i8 %".36", 0
  %".38" = load [1 x i32], [1 x i32]* %".8"
  %".39" = getelementptr [1 x i32], [1 x i32]* %".8", i32 0, i32 0
  %".40" = call i32 @"EmptyStack"(i32* %".39")
  %".41" = icmp ne i32 %".40", 1
  %".42" = or i1 %".37", %".41"
  br i1 %".42", label %"cal.while_body", label %"cal.while_end"
cal.while_body:
  %".44" = load i32, i32* %".9"
  %".45" = load i8*, i8** %".3"
  %".46" = getelementptr i8, i8* %".45", i32 %".44"
  %".47" = load i8, i8* %".46"
  %".48" = icmp sge i8 %".47", 48
  %".49" = load i32, i32* %".9"
  %".50" = load i8*, i8** %".3"
  %".51" = getelementptr i8, i8* %".50", i32 %".49"
  %".52" = load i8, i8* %".51"
  %".53" = icmp sle i8 %".52", 57
  %".54" = and i1 %".48", %".53"
  br i1 %".54", label %"cal.while_body.if", label %"cal.while_body.else"
cal.while_end:
  %".285" = load [1 x i32], [1 x i32]* %".7"
  %".286" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".287" = load [200 x i32], [200 x i32]* %".5"
  %".288" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".289" = call i32 @"Pop"(i32* %".286", i32* %".288")
  %".290" = alloca i32
  store i32 %".289", i32* %".290"
  %".292" = load i32, i32* %".290"
  ret i32 %".292"
cal.while_body.if:
  %".56" = load i32, i32* %".9"
  %".57" = load i8*, i8** %".3"
  %".58" = getelementptr i8, i8* %".57", i32 %".56"
  %".59" = load i32, i32* %".11"
  %".60" = mul i32 %".59", 10
  %".61" = load i8, i8* %".58"
  %".62" = zext i8 %".61" to i32
  %".63" = add i32 %".60", %".62"
  %".64" = zext i8 48 to i32
  %".65" = sub i32 %".63", %".64"
  store i32 %".65", i32* %".11"
  %".67" = load i32, i32* %".9"
  %".68" = add i32 %".67", 1
  store i32 %".68", i32* %".9"
  %".70" = load i32, i32* %".9"
  %".71" = load i8*, i8** %".3"
  %".72" = getelementptr i8, i8* %".71", i32 %".70"
  %".73" = load i8, i8* %".72"
  %".74" = icmp slt i8 %".73", 48
  %".75" = load i32, i32* %".9"
  %".76" = load i8*, i8** %".3"
  %".77" = getelementptr i8, i8* %".76", i32 %".75"
  %".78" = load i8, i8* %".77"
  %".79" = icmp sgt i8 %".78", 57
  %".80" = or i1 %".74", %".79"
  br i1 %".80", label %"cal.while_body.if.if", label %"cal.while_body.if.endif"
cal.while_body.else:
  store i32 0, i32* %".15"
  %".92" = load i32, i32* %".9"
  %".93" = load i8*, i8** %".3"
  %".94" = getelementptr i8, i8* %".93", i32 %".92"
  %".95" = load i8, i8* %".94"
  %".96" = zext i8 %".95" to i32
  store i32 %".96", i32* %".20"
  %".98" = load [1 x i32], [1 x i32]* %".8"
  %".99" = getelementptr [1 x i32], [1 x i32]* %".8", i32 0, i32 0
  %".100" = call i32 @"EmptyStack"(i32* %".99")
  %".101" = icmp ne i32 %".100", 1
  br i1 %".101", label %"cal.while_body.else.if", label %"cal.while_body.else.endif"
cal.while_body.endif:
  br label %"cal.while_cond"
cal.while_body.if.if:
  %".82" = load i32, i32* %".11"
  %".83" = load [1 x i32], [1 x i32]* %".7"
  %".84" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".85" = load [200 x i32], [200 x i32]* %".5"
  %".86" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".87" = call i32 @"Push"(i32 %".82", i32* %".84", i32* %".86")
  store i32 0, i32* %".11"
  br label %"cal.while_body.if.endif"
cal.while_body.if.endif:
  br label %"cal.while_body.endif"
cal.while_body.else.if:
  %".103" = load [1 x i32], [1 x i32]* %".8"
  %".104" = getelementptr [1 x i32], [1 x i32]* %".8", i32 0, i32 0
  %".105" = load [100 x i32], [100 x i32]* %".6"
  %".106" = getelementptr [100 x i32], [100 x i32]* %".6", i32 0, i32 0
  %".107" = call i32 @"GetTop"(i32* %".104", i32* %".106")
  store i32 %".107", i32* %".15"
  br label %"cal.while_body.else.endif"
cal.while_body.else.endif:
  %".110" = load [1 x i32], [1 x i32]* %".8"
  %".111" = getelementptr [1 x i32], [1 x i32]* %".8", i32 0, i32 0
  %".112" = call i32 @"EmptyStack"(i32* %".111")
  %".113" = icmp eq i32 %".112", 1
  %".114" = load i32, i32* %".15"
  %".115" = icmp eq i32 %".114", 40
  %".116" = load i32, i32* %".20"
  %".117" = icmp ne i32 %".116", 41
  %".118" = and i1 %".115", %".117"
  %".119" = or i1 %".113", %".118"
  %".120" = load i32, i32* %".20"
  %".121" = call i32 @"Priority"(i32 %".120")
  %".122" = load i32, i32* %".15"
  %".123" = call i32 @"Priority"(i32 %".122")
  %".124" = icmp sgt i32 %".121", %".123"
  %".125" = or i1 %".119", %".124"
  br i1 %".125", label %"cal.while_body.else.endif.if", label %"cal.while_body.else.endif.endif"
cal.while_body.else.endif.if:
  %".127" = load i32, i32* %".20"
  %".128" = load [1 x i32], [1 x i32]* %".8"
  %".129" = getelementptr [1 x i32], [1 x i32]* %".8", i32 0, i32 0
  %".130" = load [100 x i32], [100 x i32]* %".6"
  %".131" = getelementptr [100 x i32], [100 x i32]* %".6", i32 0, i32 0
  %".132" = call i32 @"Push"(i32 %".127", i32* %".129", i32* %".131")
  %".133" = load i32, i32* %".9"
  %".134" = add i32 %".133", 1
  store i32 %".134", i32* %".9"
  br label %"cal.while_cond"
cal.while_body.else.endif.endif:
  %".137" = load i32, i32* %".15"
  %".138" = icmp eq i32 %".137", 40
  %".139" = load i32, i32* %".20"
  %".140" = icmp eq i32 %".139", 41
  %".141" = and i1 %".138", %".140"
  br i1 %".141", label %"cal.while_body.else.endif.endif.if", label %"cal.while_body.else.endif.endif.endif"
cal.while_body.else.endif.endif.if:
  %".143" = load [1 x i32], [1 x i32]* %".8"
  %".144" = getelementptr [1 x i32], [1 x i32]* %".8", i32 0, i32 0
  %".145" = load [100 x i32], [100 x i32]* %".6"
  %".146" = getelementptr [100 x i32], [100 x i32]* %".6", i32 0, i32 0
  %".147" = call i32 @"Pop"(i32* %".144", i32* %".146")
  %".148" = load i32, i32* %".9"
  %".149" = add i32 %".148", 1
  store i32 %".149", i32* %".9"
  br label %"cal.while_cond"
cal.while_body.else.endif.endif.endif:
  %".152" = load i32, i32* %".20"
  %".153" = icmp eq i32 %".152", 41
  %".154" = load i32, i32* %".15"
  %".155" = icmp ne i32 %".154", 40
  %".156" = and i1 %".153", %".155"
  %".157" = load i32, i32* %".20"
  %".158" = icmp eq i32 %".157", 0
  %".159" = load [1 x i32], [1 x i32]* %".8"
  %".160" = getelementptr [1 x i32], [1 x i32]* %".8", i32 0, i32 0
  %".161" = call i32 @"EmptyStack"(i32* %".160")
  %".162" = icmp ne i32 %".161", 1
  %".163" = and i1 %".158", %".162"
  %".164" = or i1 %".156", %".163"
  %".165" = load i32, i32* %".20"
  %".166" = call i32 @"Priority"(i32 %".165")
  %".167" = load i32, i32* %".15"
  %".168" = call i32 @"Priority"(i32 %".167")
  %".169" = icmp sle i32 %".166", %".168"
  %".170" = or i1 %".164", %".169"
  br i1 %".170", label %"cal.while_body.else.endif.endif.endif.if", label %"cal.while_body.else.endif.endif.endif.endif"
cal.while_body.else.endif.endif.endif.if:
  %".172" = load [1 x i32], [1 x i32]* %".8"
  %".173" = getelementptr [1 x i32], [1 x i32]* %".8", i32 0, i32 0
  %".174" = load [100 x i32], [100 x i32]* %".6"
  %".175" = getelementptr [100 x i32], [100 x i32]* %".6", i32 0, i32 0
  %".176" = call i32 @"Pop"(i32* %".173", i32* %".175")
  store i32 %".176", i32* %".24"
  %".178" = load i32, i32* %".24"
  %".179" = icmp eq i32 %".178", 43
  br i1 %".179", label %"cal.while_body.else.endif.endif.endif.if.if", label %"cal.while_body.else.endif.endif.endif.if.endif"
cal.while_body.else.endif.endif.endif.endif:
  br label %"cal.while_body.endif"
cal.while_body.else.endif.endif.endif.if.if:
  %".181" = load [1 x i32], [1 x i32]* %".7"
  %".182" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".183" = load [200 x i32], [200 x i32]* %".5"
  %".184" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".185" = call i32 @"Pop"(i32* %".182", i32* %".184")
  store i32 %".185", i32* %".13"
  %".187" = load [1 x i32], [1 x i32]* %".7"
  %".188" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".189" = load [200 x i32], [200 x i32]* %".5"
  %".190" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".191" = call i32 @"Pop"(i32* %".188", i32* %".190")
  store i32 %".191", i32* %".14"
  %".193" = load i32, i32* %".13"
  %".194" = load i32, i32* %".14"
  %".195" = add i32 %".193", %".194"
  store i32 %".195", i32* %".26"
  %".197" = load i32, i32* %".26"
  %".198" = load [1 x i32], [1 x i32]* %".7"
  %".199" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".200" = load [200 x i32], [200 x i32]* %".5"
  %".201" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".202" = call i32 @"Push"(i32 %".197", i32* %".199", i32* %".201")
  br label %"cal.while_body.else.endif.endif.endif.if.endif"
cal.while_body.else.endif.endif.endif.if.endif:
  %".204" = load i32, i32* %".24"
  %".205" = icmp eq i32 %".204", 45
  br i1 %".205", label %"cal.while_body.else.endif.endif.endif.if.endif.if", label %"cal.while_body.else.endif.endif.endif.if.endif.endif"
cal.while_body.else.endif.endif.endif.if.endif.if:
  %".207" = load [1 x i32], [1 x i32]* %".7"
  %".208" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".209" = load [200 x i32], [200 x i32]* %".5"
  %".210" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".211" = call i32 @"Pop"(i32* %".208", i32* %".210")
  store i32 %".211", i32* %".13"
  %".213" = load [1 x i32], [1 x i32]* %".7"
  %".214" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".215" = load [200 x i32], [200 x i32]* %".5"
  %".216" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".217" = call i32 @"Pop"(i32* %".214", i32* %".216")
  store i32 %".217", i32* %".14"
  %".219" = load i32, i32* %".14"
  %".220" = load i32, i32* %".13"
  %".221" = sub i32 %".219", %".220"
  store i32 %".221", i32* %".26"
  %".223" = load i32, i32* %".26"
  %".224" = load [1 x i32], [1 x i32]* %".7"
  %".225" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".226" = load [200 x i32], [200 x i32]* %".5"
  %".227" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".228" = call i32 @"Push"(i32 %".223", i32* %".225", i32* %".227")
  br label %"cal.while_body.else.endif.endif.endif.if.endif.endif"
cal.while_body.else.endif.endif.endif.if.endif.endif:
  %".230" = load i32, i32* %".24"
  %".231" = icmp eq i32 %".230", 42
  br i1 %".231", label %"cal.while_body.else.endif...if", label %"cal.while_body.else.endif...endif"
cal.while_body.else.endif...if:
  %".233" = load [1 x i32], [1 x i32]* %".7"
  %".234" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".235" = load [200 x i32], [200 x i32]* %".5"
  %".236" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".237" = call i32 @"Pop"(i32* %".234", i32* %".236")
  store i32 %".237", i32* %".13"
  %".239" = load [1 x i32], [1 x i32]* %".7"
  %".240" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".241" = load [200 x i32], [200 x i32]* %".5"
  %".242" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".243" = call i32 @"Pop"(i32* %".240", i32* %".242")
  store i32 %".243", i32* %".14"
  %".245" = load i32, i32* %".13"
  %".246" = load i32, i32* %".14"
  %".247" = mul i32 %".245", %".246"
  store i32 %".247", i32* %".26"
  %".249" = load i32, i32* %".26"
  %".250" = load [1 x i32], [1 x i32]* %".7"
  %".251" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".252" = load [200 x i32], [200 x i32]* %".5"
  %".253" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".254" = call i32 @"Push"(i32 %".249", i32* %".251", i32* %".253")
  br label %"cal.while_body.else.endif...endif"
cal.while_body.else.endif...endif:
  %".256" = load i32, i32* %".24"
  %".257" = icmp eq i32 %".256", 47
  br i1 %".257", label %"cal.while_body.else.endif...endif.if", label %"cal.while_body.else.endif...endif.endif"
cal.while_body.else.endif...endif.if:
  %".259" = load [1 x i32], [1 x i32]* %".7"
  %".260" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".261" = load [200 x i32], [200 x i32]* %".5"
  %".262" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".263" = call i32 @"Pop"(i32* %".260", i32* %".262")
  store i32 %".263", i32* %".13"
  %".265" = load [1 x i32], [1 x i32]* %".7"
  %".266" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".267" = load [200 x i32], [200 x i32]* %".5"
  %".268" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".269" = call i32 @"Pop"(i32* %".266", i32* %".268")
  store i32 %".269", i32* %".14"
  %".271" = load i32, i32* %".14"
  %".272" = load i32, i32* %".13"
  %".273" = sdiv i32 %".271", %".272"
  store i32 %".273", i32* %".26"
  %".275" = load i32, i32* %".26"
  %".276" = load [1 x i32], [1 x i32]* %".7"
  %".277" = getelementptr [1 x i32], [1 x i32]* %".7", i32 0, i32 0
  %".278" = load [200 x i32], [200 x i32]* %".5"
  %".279" = getelementptr [200 x i32], [200 x i32]* %".5", i32 0, i32 0
  %".280" = call i32 @"Push"(i32 %".275", i32* %".277", i32* %".279")
  br label %"cal.while_body.else.endif...endif.endif"
cal.while_body.else.endif...endif.endif:
  br label %"cal.while_cond"
}

define i32 @"main"() 
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  store i8 49, i8* %".3"
  %".5" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 1
  store i8 53, i8* %".5"
  %".7" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 2
  store i8 47, i8* %".7"
  %".9" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 3
  store i8 51, i8* %".9"
  %".11" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 4
  store i8 43, i8* %".11"
  %".13" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 5
  store i8 50, i8* %".13"
  %".15" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 6
  store i8 42, i8* %".15"
  %".17" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 7
  store i8 40, i8* %".17"
  %".19" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 8
  store i8 52, i8* %".19"
  %".21" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 9
  store i8 45, i8* %".21"
  %".23" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 10
  store i8 50, i8* %".23"
  %".25" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 11
  store i8 41, i8* %".25"
  %".27" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 12
  store i8 0, i8* %".27"
  %".29" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([40 x i8], [40 x i8]* @"\22please key in string to be calculated:\5cn\22", i32 0, i32 0))
  %".30" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([51 x i8], [51 x i8]* @"\22(make sure it's valid and there's no space in it)\5cn\22", i32 0, i32 0))
  %".31" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%s\22", i32 0, i32 0), [100 x i8]* %".2")
  %".32" = load [100 x i8], [100 x i8]* %".2"
  %".33" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  %".34" = call i32 @"cal"(i8* %".33")
  %".35" = alloca i32
  store i32 %".34", i32* %".35"
  %".37" = load i32, i32* %".35"
  %".38" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([11 x i8], [11 x i8]* @"\22answer: %d\22", i32 0, i32 0), i32 %".37")
  %".39" = load i32, i32* %".35"
  ret i32 %".39"
}

@"\22please key in string to be calculated:\5cn\22" = global [40 x i8] c"please key in string to be calculated:\0a\00"
@"\22(make sure it's valid and there's no space in it)\5cn\22" = global [51 x i8] c"(make sure it's valid and there's no space in it)\0a\00"
@"\22%s\22" = global [3 x i8] c"%s\00"
@"\22answer: %d\22" = global [11 x i8] c"answer: %d\00"