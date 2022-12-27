; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

%"Node" = type {i32, %"Node"*}
%"LinkStack" = type {%"Node"*, i32}
declare i32 @"printf"(i8* %".1", ...) 

define i32 @"EmptyStack"(%"LinkStack"* %".1") 
{
EmptyStack:
  %".3" = alloca %"LinkStack"*
  store %"LinkStack"* %".1", %"LinkStack"** %".3"
  %".5" = load %"LinkStack"*, %"LinkStack"** %".3"
  %".6" = getelementptr %"LinkStack", %"LinkStack"* %".5", i32 1
  %".7" = bitcast %"LinkStack"* %".6" to i32*
  %".8" = load i32, i32* %".7"
  %".9" = icmp eq i32 %".8", 0
  br i1 %".9", label %"EmptyStack.if", label %"EmptyStack.endif"
EmptyStack.if:
  ret i32 1
EmptyStack.endif:
  ret i32 0
}

define i32 @"Push"(i32 %".1", %"LinkStack"* %".2") 
{
Push:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %".6" = alloca %"LinkStack"*
  store %"LinkStack"* %".2", %"LinkStack"** %".6"
  %".8" = alloca i8, i32 8
  %".9" = bitcast i8* %".8" to %"Node"*
  %".10" = alloca %"Node"*
  store %"Node"* %".9", %"Node"** %".10"
  %".12" = load %"Node"*, %"Node"** %".10"
  %".13" = getelementptr %"Node", %"Node"* %".12", i32 0
  %".14" = bitcast %"Node"* %".13" to i32*
  %".15" = load i32, i32* %".4"
  store i32 %".15", i32* %".14"
  %".17" = load %"Node"*, %"Node"** %".10"
  %".18" = getelementptr %"Node", %"Node"* %".17", i32 1
  %".19" = bitcast %"Node"* %".18" to %"Node"**
  %".20" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".21" = getelementptr %"LinkStack", %"LinkStack"* %".20", i32 0
  %".22" = bitcast %"LinkStack"* %".21" to %"Node"**
  %".23" = load %"Node"*, %"Node"** %".22"
  store %"Node"* %".23", %"Node"** %".19"
  %".25" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".26" = getelementptr %"LinkStack", %"LinkStack"* %".25", i32 0
  %".27" = bitcast %"LinkStack"* %".26" to %"Node"**
  %".28" = load %"Node"*, %"Node"** %".10"
  store %"Node"* %".28", %"Node"** %".27"
  %".30" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".31" = getelementptr %"LinkStack", %"LinkStack"* %".30", i32 1
  %".32" = bitcast %"LinkStack"* %".31" to i32*
  %".33" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".34" = getelementptr %"LinkStack", %"LinkStack"* %".33", i32 1
  %".35" = bitcast %"LinkStack"* %".34" to i32*
  %".36" = load i32, i32* %".35"
  %".37" = add i32 %".36", 1
  store i32 %".37", i32* %".32"
  ret i32 1
}

define i32 @"GetTop"(%"LinkStack"* %".1") 
{
GetTop:
  %".3" = alloca %"LinkStack"*
  store %"LinkStack"* %".1", %"LinkStack"** %".3"
  %".5" = load %"LinkStack"*, %"LinkStack"** %".3"
  %".6" = getelementptr %"LinkStack", %"LinkStack"* %".5", i32 0
  %".7" = bitcast %"LinkStack"* %".6" to %"Node"**
  %".8" = alloca %"Node"*
  %".9" = load %"Node"*, %"Node"** %".7"
  store %"Node"* %".9", %"Node"** %".8"
  %".11" = load %"Node"*, %"Node"** %".8"
  %".12" = getelementptr %"Node", %"Node"* %".11", i32 0
  %".13" = bitcast %"Node"* %".12" to i32*
  %".14" = load i32, i32* %".13"
  ret i32 %".14"
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

define i32 @"Pop"(%"LinkStack"* %".1") 
{
Pop:
  %".3" = alloca %"LinkStack"*
  store %"LinkStack"* %".1", %"LinkStack"** %".3"
  %".5" = alloca i32
  %".6" = load %"LinkStack"*, %"LinkStack"** %".3"
  %".7" = getelementptr %"LinkStack", %"LinkStack"* %".6", i32 0
  %".8" = bitcast %"LinkStack"* %".7" to %"Node"**
  %".9" = alloca %"Node"*
  %".10" = load %"Node"*, %"Node"** %".8"
  store %"Node"* %".10", %"Node"** %".9"
  %".12" = load %"Node"*, %"Node"** %".9"
  %".13" = getelementptr %"Node", %"Node"* %".12", i32 0
  %".14" = bitcast %"Node"* %".13" to i32*
  %".15" = load i32, i32* %".14"
  store i32 %".15", i32* %".5"
  %".17" = load %"LinkStack"*, %"LinkStack"** %".3"
  %".18" = getelementptr %"LinkStack", %"LinkStack"* %".17", i32 0
  %".19" = bitcast %"LinkStack"* %".18" to %"Node"**
  %".20" = load %"Node"*, %"Node"** %".9"
  %".21" = getelementptr %"Node", %"Node"* %".20", i32 1
  %".22" = bitcast %"Node"* %".21" to %"Node"**
  %".23" = load %"Node"*, %"Node"** %".22"
  store %"Node"* %".23", %"Node"** %".19"
  %".25" = load %"LinkStack"*, %"LinkStack"** %".3"
  %".26" = getelementptr %"LinkStack", %"LinkStack"* %".25", i32 1
  %".27" = bitcast %"LinkStack"* %".26" to i32*
  %".28" = load %"LinkStack"*, %"LinkStack"** %".3"
  %".29" = getelementptr %"LinkStack", %"LinkStack"* %".28", i32 1
  %".30" = bitcast %"LinkStack"* %".29" to i32*
  %".31" = load i32, i32* %".30"
  %".32" = sub i32 %".31", 1
  store i32 %".32", i32* %".27"
  %".34" = load i32, i32* %".5"
  ret i32 %".34"
}

define i32 @"cal"(i8* %".1") 
{
cal:
  %".3" = alloca i8*
  store i8* %".1", i8** %".3"
  %".5" = alloca %"LinkStack"*
  %".6" = alloca %"LinkStack"*
  %".7" = alloca i32
  store i32 0, i32* %".7"
  %".9" = alloca i32
  store i32 0, i32* %".9"
  %".11" = alloca i32
  %".12" = alloca i32
  %".13" = alloca i32
  store i32 0, i32* %".13"
  %".15" = load i32, i32* %".7"
  %".16" = load i8*, i8** %".3"
  %".17" = getelementptr i8, i8* %".16", i32 %".15"
  %".18" = alloca i32
  %".19" = load i8, i8* %".17"
  %".20" = zext i8 %".19" to i32
  store i32 %".20", i32* %".18"
  %".22" = alloca i32
  store i32 0, i32* %".22"
  %".24" = alloca i8, i32 8
  %".25" = bitcast i8* %".24" to %"LinkStack"*
  store %"LinkStack"* %".25", %"LinkStack"** %".5"
  %".27" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".28" = getelementptr %"LinkStack", %"LinkStack"* %".27", i32 1
  %".29" = bitcast %"LinkStack"* %".28" to i32*
  store i32 0, i32* %".29"
  %".31" = alloca i8, i32 8
  %".32" = bitcast i8* %".31" to %"LinkStack"*
  store %"LinkStack"* %".32", %"LinkStack"** %".6"
  %".34" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".35" = getelementptr %"LinkStack", %"LinkStack"* %".34", i32 1
  %".36" = bitcast %"LinkStack"* %".35" to i32*
  store i32 0, i32* %".36"
  br label %"cal.while_cond"
cal.while_cond:
  %".39" = load i32, i32* %".7"
  %".40" = load i8*, i8** %".3"
  %".41" = getelementptr i8, i8* %".40", i32 %".39"
  %".42" = load i8, i8* %".41"
  %".43" = icmp ne i8 %".42", 0
  %".44" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".45" = call i32 @"EmptyStack"(%"LinkStack"* %".44")
  %".46" = icmp ne i32 %".45", 1
  %".47" = or i1 %".43", %".46"
  br i1 %".47", label %"cal.while_body", label %"cal.while_end"
cal.while_body:
  %".49" = load i32, i32* %".7"
  %".50" = load i8*, i8** %".3"
  %".51" = getelementptr i8, i8* %".50", i32 %".49"
  %".52" = load i8, i8* %".51"
  %".53" = icmp sge i8 %".52", 48
  %".54" = load i32, i32* %".7"
  %".55" = load i8*, i8** %".3"
  %".56" = getelementptr i8, i8* %".55", i32 %".54"
  %".57" = load i8, i8* %".56"
  %".58" = icmp sle i8 %".57", 57
  %".59" = and i1 %".53", %".58"
  br i1 %".59", label %"cal.while_body.if", label %"cal.while_body.else"
cal.while_end:
  %".228" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".229" = call i32 @"Pop"(%"LinkStack"* %".228")
  ret i32 %".229"
cal.while_body.if:
  %".61" = load i32, i32* %".7"
  %".62" = load i8*, i8** %".3"
  %".63" = getelementptr i8, i8* %".62", i32 %".61"
  %".64" = load i32, i32* %".9"
  %".65" = mul i32 %".64", 10
  %".66" = load i8, i8* %".63"
  %".67" = zext i8 %".66" to i32
  %".68" = add i32 %".65", %".67"
  %".69" = zext i8 48 to i32
  %".70" = sub i32 %".68", %".69"
  store i32 %".70", i32* %".9"
  %".72" = load i32, i32* %".7"
  %".73" = add i32 %".72", 1
  store i32 %".73", i32* %".7"
  %".75" = load i32, i32* %".7"
  %".76" = load i8*, i8** %".3"
  %".77" = getelementptr i8, i8* %".76", i32 %".75"
  %".78" = load i8, i8* %".77"
  %".79" = icmp slt i8 %".78", 48
  %".80" = load i32, i32* %".7"
  %".81" = load i8*, i8** %".3"
  %".82" = getelementptr i8, i8* %".81", i32 %".80"
  %".83" = load i8, i8* %".82"
  %".84" = icmp sgt i8 %".83", 57
  %".85" = or i1 %".79", %".84"
  br i1 %".85", label %"cal.while_body.if.if", label %"cal.while_body.if.endif"
cal.while_body.else:
  store i32 0, i32* %".13"
  %".94" = load i32, i32* %".7"
  %".95" = load i8*, i8** %".3"
  %".96" = getelementptr i8, i8* %".95", i32 %".94"
  %".97" = load i8, i8* %".96"
  %".98" = zext i8 %".97" to i32
  store i32 %".98", i32* %".18"
  %".100" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".101" = call i32 @"EmptyStack"(%"LinkStack"* %".100")
  %".102" = icmp ne i32 %".101", 1
  br i1 %".102", label %"cal.while_body.else.if", label %"cal.while_body.else.endif"
cal.while_body.endif:
  br label %"cal.while_cond"
cal.while_body.if.if:
  %".87" = load i32, i32* %".9"
  %".88" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".89" = call i32 @"Push"(i32 %".87", %"LinkStack"* %".88")
  store i32 0, i32* %".9"
  br label %"cal.while_body.if.endif"
cal.while_body.if.endif:
  br label %"cal.while_body.endif"
cal.while_body.else.if:
  %".104" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".105" = call i32 @"GetTop"(%"LinkStack"* %".104")
  store i32 %".105", i32* %".13"
  br label %"cal.while_body.else.endif"
cal.while_body.else.endif:
  %".108" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".109" = call i32 @"EmptyStack"(%"LinkStack"* %".108")
  %".110" = icmp eq i32 %".109", 1
  %".111" = load i32, i32* %".13"
  %".112" = icmp eq i32 %".111", 40
  %".113" = load i32, i32* %".18"
  %".114" = icmp ne i32 %".113", 41
  %".115" = and i1 %".112", %".114"
  %".116" = or i1 %".110", %".115"
  %".117" = load i32, i32* %".18"
  %".118" = call i32 @"Priority"(i32 %".117")
  %".119" = load i32, i32* %".13"
  %".120" = call i32 @"Priority"(i32 %".119")
  %".121" = icmp sgt i32 %".118", %".120"
  %".122" = or i1 %".116", %".121"
  br i1 %".122", label %"cal.while_body.else.endif.if", label %"cal.while_body.else.endif.endif"
cal.while_body.else.endif.if:
  %".124" = load i32, i32* %".18"
  %".125" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".126" = call i32 @"Push"(i32 %".124", %"LinkStack"* %".125")
  %".127" = load i32, i32* %".7"
  %".128" = add i32 %".127", 1
  store i32 %".128", i32* %".7"
  br label %"cal.while_cond"
cal.while_body.else.endif.endif:
  %".131" = load i32, i32* %".13"
  %".132" = icmp eq i32 %".131", 40
  %".133" = load i32, i32* %".18"
  %".134" = icmp eq i32 %".133", 41
  %".135" = and i1 %".132", %".134"
  br i1 %".135", label %"cal.while_body.else.endif.endif.if", label %"cal.while_body.else.endif.endif.endif"
cal.while_body.else.endif.endif.if:
  %".137" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".138" = call i32 @"Pop"(%"LinkStack"* %".137")
  %".139" = load i32, i32* %".7"
  %".140" = add i32 %".139", 1
  store i32 %".140", i32* %".7"
  br label %"cal.while_cond"
cal.while_body.else.endif.endif.endif:
  %".143" = load i32, i32* %".18"
  %".144" = icmp eq i32 %".143", 41
  %".145" = load i32, i32* %".13"
  %".146" = icmp ne i32 %".145", 40
  %".147" = and i1 %".144", %".146"
  %".148" = load i32, i32* %".18"
  %".149" = icmp eq i32 %".148", 0
  %".150" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".151" = call i32 @"EmptyStack"(%"LinkStack"* %".150")
  %".152" = icmp ne i32 %".151", 1
  %".153" = and i1 %".149", %".152"
  %".154" = or i1 %".147", %".153"
  %".155" = load i32, i32* %".18"
  %".156" = call i32 @"Priority"(i32 %".155")
  %".157" = load i32, i32* %".13"
  %".158" = call i32 @"Priority"(i32 %".157")
  %".159" = icmp sle i32 %".156", %".158"
  %".160" = or i1 %".154", %".159"
  br i1 %".160", label %"cal.while_body.else.endif.endif.endif.if", label %"cal.while_body.else.endif.endif.endif.endif"
cal.while_body.else.endif.endif.endif.if:
  %".162" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".163" = call i32 @"Pop"(%"LinkStack"* %".162")
  store i32 %".163", i32* %".22"
  %".165" = load i32, i32* %".22"
  %".166" = icmp eq i32 %".165", 43
  br i1 %".166", label %"cal.while_body.else.endif.endif.endif.if.if", label %"cal.while_body.else.endif.endif.endif.if.endif"
cal.while_body.else.endif.endif.endif.endif:
  br label %"cal.while_body.endif"
cal.while_body.else.endif.endif.endif.if.if:
  %".168" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".169" = call i32 @"Pop"(%"LinkStack"* %".168")
  store i32 %".169", i32* %".11"
  %".171" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".172" = call i32 @"Pop"(%"LinkStack"* %".171")
  store i32 %".172", i32* %".12"
  %".174" = load i32, i32* %".11"
  %".175" = load i32, i32* %".12"
  %".176" = add i32 %".174", %".175"
  %".177" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".178" = call i32 @"Push"(i32 %".176", %"LinkStack"* %".177")
  br label %"cal.while_body.else.endif.endif.endif.if.endif"
cal.while_body.else.endif.endif.endif.if.endif:
  %".180" = load i32, i32* %".22"
  %".181" = icmp eq i32 %".180", 45
  br i1 %".181", label %"cal.while_body.else.endif.endif.endif.if.endif.if", label %"cal.while_body.else.endif.endif.endif.if.endif.endif"
cal.while_body.else.endif.endif.endif.if.endif.if:
  %".183" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".184" = call i32 @"Pop"(%"LinkStack"* %".183")
  store i32 %".184", i32* %".11"
  %".186" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".187" = call i32 @"Pop"(%"LinkStack"* %".186")
  %".188" = load i32, i32* %".11"
  %".189" = sub i32 %".187", %".188"
  store i32 %".189", i32* %".12"
  %".191" = load i32, i32* %".12"
  %".192" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".193" = call i32 @"Push"(i32 %".191", %"LinkStack"* %".192")
  br label %"cal.while_body.else.endif.endif.endif.if.endif.endif"
cal.while_body.else.endif.endif.endif.if.endif.endif:
  %".195" = load i32, i32* %".22"
  %".196" = icmp eq i32 %".195", 42
  br i1 %".196", label %"cal.while_body.else.endif...if", label %"cal.while_body.else.endif...endif"
cal.while_body.else.endif...if:
  %".198" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".199" = call i32 @"Pop"(%"LinkStack"* %".198")
  store i32 %".199", i32* %".11"
  %".201" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".202" = call i32 @"Pop"(%"LinkStack"* %".201")
  store i32 %".202", i32* %".12"
  %".204" = load i32, i32* %".11"
  %".205" = load i32, i32* %".12"
  %".206" = mul i32 %".204", %".205"
  %".207" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".208" = call i32 @"Push"(i32 %".206", %"LinkStack"* %".207")
  br label %"cal.while_body.else.endif...endif"
cal.while_body.else.endif...endif:
  %".210" = load i32, i32* %".22"
  %".211" = icmp eq i32 %".210", 47
  br i1 %".211", label %"cal.while_body.else.endif...endif.if", label %"cal.while_body.else.endif...endif.endif"
cal.while_body.else.endif...endif.if:
  %".213" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".214" = call i32 @"Pop"(%"LinkStack"* %".213")
  store i32 %".214", i32* %".11"
  %".216" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".217" = call i32 @"Pop"(%"LinkStack"* %".216")
  %".218" = load i32, i32* %".11"
  %".219" = sdiv i32 %".217", %".218"
  store i32 %".219", i32* %".12"
  %".221" = load i32, i32* %".12"
  %".222" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".223" = call i32 @"Push"(i32 %".221", %"LinkStack"* %".222")
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
  %".5" = getelementptr [100 x i8], [100 x i8]* %".2", i32 1, i32 1
  store i8 53, i8* %".5"
  %".7" = getelementptr [100 x i8], [100 x i8]* %".2", i32 2, i32 2
  store i8 47, i8* %".7"
  %".9" = getelementptr [100 x i8], [100 x i8]* %".2", i32 3, i32 3
  store i8 51, i8* %".9"
  %".11" = getelementptr [100 x i8], [100 x i8]* %".2", i32 4, i32 4
  store i8 43, i8* %".11"
  %".13" = getelementptr [100 x i8], [100 x i8]* %".2", i32 5, i32 5
  store i8 50, i8* %".13"
  %".15" = getelementptr [100 x i8], [100 x i8]* %".2", i32 6, i32 6
  store i8 42, i8* %".15"
  %".17" = getelementptr [100 x i8], [100 x i8]* %".2", i32 7, i32 7
  store i8 40, i8* %".17"
  %".19" = getelementptr [100 x i8], [100 x i8]* %".2", i32 8, i32 8
  store i8 52, i8* %".19"
  %".21" = getelementptr [100 x i8], [100 x i8]* %".2", i32 9, i32 9
  store i8 45, i8* %".21"
  %".23" = getelementptr [100 x i8], [100 x i8]* %".2", i32 10, i32 10
  store i8 50, i8* %".23"
  %".25" = getelementptr [100 x i8], [100 x i8]* %".2", i32 11, i32 11
  store i8 41, i8* %".25"
  %".27" = getelementptr [100 x i8], [100 x i8]* %".2", i32 12, i32 12
  store i8 0, i8* %".27"
  %".29" = load [100 x i8], [100 x i8]* %".2"
  %".30" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  %".31" = call i32 @"cal"(i8* %".30")
  %".32" = alloca i32
  store i32 %".31", i32* %".32"
  %".34" = load i32, i32* %".32"
  ret i32 %".34"
}
