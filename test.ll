; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

%"Node" = type {i32, %"Node"*}
%"LinkStack" = type {%"Node"*, i32}
declare i32 @"printf"(i8* %".1", ...)

declare i32 @"scanf"(i8* %".1", ...)

define i32 @"EmptyStack"(%"LinkStack"* %".1")
{
EmptyStack:
  %".3" = alloca %"LinkStack"*
  store %"LinkStack"* %".1", %"LinkStack"** %".3"
  %".5" = getelementptr %"LinkStack"*, %"LinkStack"** %".3", i32 1
  %".6" = bitcast %"LinkStack"** %".5" to i32*
  %".7" = load i32, i32* %".6"
  %".8" = icmp eq i32 %".7", 0
  br i1 %".8", label %"EmptyStack.if", label %"EmptyStack.endif"
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
  %".12" = getelementptr %"Node"*, %"Node"** %".10", i32 0
  %".13" = bitcast %"Node"** %".12" to i32*
  %".14" = load i32, i32* %".4"
  store i32 %".14", i32* %".13"
  %".16" = getelementptr %"Node"*, %"Node"** %".10", i32 1
  %".17" = getelementptr %"LinkStack"*, %"LinkStack"** %".6", i32 0
  %".18" = bitcast %"LinkStack"** %".17" to %"Node"**
  %".19" = load %"Node"*, %"Node"** %".18"
  store %"Node"* %".19", %"Node"** %".16"
  %".21" = getelementptr %"LinkStack"*, %"LinkStack"** %".6", i32 0
  %".22" = bitcast %"LinkStack"** %".21" to %"Node"**
  %".23" = load %"Node"*, %"Node"** %".10"
  store %"Node"* %".23", %"Node"** %".22"
  %".25" = getelementptr %"LinkStack"*, %"LinkStack"** %".6", i32 1
  %".26" = bitcast %"LinkStack"** %".25" to i32*
  %".27" = getelementptr %"LinkStack"*, %"LinkStack"** %".6", i32 1
  %".28" = bitcast %"LinkStack"** %".27" to i32*
  %".29" = load i32, i32* %".28"
  %".30" = add i32 %".29", 1
  store i32 %".30", i32* %".26"
  ret i32 1
}

define i32 @"GetTop"(%"LinkStack"* %".1")
{
GetTop:
  %".3" = alloca %"LinkStack"*
  store %"LinkStack"* %".1", %"LinkStack"** %".3"
  %".5" = getelementptr %"LinkStack"*, %"LinkStack"** %".3", i32 0
  %".6" = bitcast %"LinkStack"** %".5" to %"Node"**
  %".7" = alloca %"Node"*
  %".8" = load %"Node"*, %"Node"** %".6"
  store %"Node"* %".8", %"Node"** %".7"
  %".10" = getelementptr %"Node"*, %"Node"** %".7", i32 0
  %".11" = bitcast %"Node"** %".10" to i32*
  %".12" = load i32, i32* %".11"
  ret i32 %".12"
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
  %".6" = getelementptr %"LinkStack"*, %"LinkStack"** %".3", i32 0
  %".7" = bitcast %"LinkStack"** %".6" to %"Node"**
  %".8" = alloca %"Node"*
  %".9" = load %"Node"*, %"Node"** %".7"
  store %"Node"* %".9", %"Node"** %".8"
  %".11" = getelementptr %"Node"*, %"Node"** %".8", i32 0
  %".12" = bitcast %"Node"** %".11" to i32*
  %".13" = load i32, i32* %".12"
  store i32 %".13", i32* %".5"
  %".15" = getelementptr %"LinkStack"*, %"LinkStack"** %".3", i32 0
  %".16" = bitcast %"LinkStack"** %".15" to %"Node"**
  %".17" = getelementptr %"Node"*, %"Node"** %".8", i32 1
  %".18" = load %"Node"*, %"Node"** %".17"
  store %"Node"* %".18", %"Node"** %".16"
  %".20" = getelementptr %"LinkStack"*, %"LinkStack"** %".3", i32 1
  %".21" = bitcast %"LinkStack"** %".20" to i32*
  %".22" = getelementptr %"LinkStack"*, %"LinkStack"** %".3", i32 1
  %".23" = bitcast %"LinkStack"** %".22" to i32*
  %".24" = load i32, i32* %".23"
  %".25" = sub i32 %".24", 1
  store i32 %".25", i32* %".21"
  %".27" = load i32, i32* %".5"
  ret i32 %".27"
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
  %".13" = alloca i8, i32 8
  %".14" = bitcast i8* %".13" to %"LinkStack"*
  store %"LinkStack"* %".14", %"LinkStack"** %".5"
  %".16" = getelementptr %"LinkStack"*, %"LinkStack"** %".5", i32 1
  %".17" = bitcast %"LinkStack"** %".16" to i32*
  store i32 0, i32* %".17"
  %".19" = alloca i8, i32 8
  %".20" = bitcast i8* %".19" to %"LinkStack"*
  store %"LinkStack"* %".20", %"LinkStack"** %".6"
  %".22" = getelementptr %"LinkStack"*, %"LinkStack"** %".6", i32 1
  %".23" = bitcast %"LinkStack"** %".22" to i32*
  store i32 0, i32* %".23"
  br label %"cal.while_cond"
cal.while_cond:
  %".26" = load i32, i32* %".7"
  %".27" = load i8*, i8** %".3"
  %".28" = getelementptr i8, i8* %".27", i32 %".26"
  %".29" = load i8, i8* %".28"
  %".30" = icmp ne i8 %".29", 0
  %".31" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".32" = call i32 @"EmptyStack"(%"LinkStack"* %".31")
  %".33" = icmp ne i32 %".32", 1
  br i1 %".30", label %"cal.while_cond.if", label %"cal.while_cond.else"
cal.while_body:
  %".38" = load i32, i32* %".7"
  %".39" = load i8*, i8** %".3"
  %".40" = getelementptr i8, i8* %".39", i32 %".38"
  %".41" = load i8, i8* %".40"
  %".42" = icmp sge i8 %".41", 48
  %".43" = load i32, i32* %".7"
  %".44" = load i8*, i8** %".3"
  %".45" = getelementptr i8, i8* %".44", i32 %".43"
  %".46" = load i8, i8* %".45"
  %".47" = icmp sle i8 %".46", 57
  br i1 %".42", label %"cal.while_body.if", label %"cal.while_body.else"
cal.while_end:
  %".235" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".236" = call i32 @"Pop"(%"LinkStack"* %".235")
  ret i32 %".236"
cal.while_cond.if:
  br label %"cal.while_cond.endif"
cal.while_cond.else:
  br label %"cal.while_cond.endif"
cal.while_cond.endif:
  br i1 %".33", label %"cal.while_body", label %"cal.while_end"
cal.while_body.if:
  br label %"cal.while_body.endif"
cal.while_body.else:
  br label %"cal.while_body.endif"
cal.while_body.endif:
  br i1 0, label %"cal.while_body.endif.if", label %"cal.while_body.endif.else"
cal.while_body.endif.if:
  %".52" = load i32, i32* %".7"
  %".53" = load i8*, i8** %".3"
  %".54" = getelementptr i8, i8* %".53", i32 %".52"
  %".55" = load i32, i32* %".9"
  %".56" = mul i32 %".55", 10
  %".57" = load i8, i8* %".54"
  %".58" = zext i8 %".57" to i32
  %".59" = add i32 %".56", %".58"
  %".60" = zext i8 48 to i32
  %".61" = sub i32 %".59", %".60"
  store i32 %".61", i32* %".9"
  %".63" = load i32, i32* %".7"
  %".64" = add i32 %".63", 1
  store i32 %".64", i32* %".7"
  %".66" = load i32, i32* %".7"
  %".67" = load i8*, i8** %".3"
  %".68" = getelementptr i8, i8* %".67", i32 %".66"
  %".69" = load i8, i8* %".68"
  %".70" = icmp slt i8 %".69", 48
  %".71" = load i32, i32* %".7"
  %".72" = load i8*, i8** %".3"
  %".73" = getelementptr i8, i8* %".72", i32 %".71"
  %".74" = load i8, i8* %".73"
  %".75" = icmp sgt i8 %".74", 57
  br i1 %".70", label %"cal.while_body.endif.if.if", label %"cal.while_body.endif.if.else"
cal.while_body.endif.else:
  %".86" = alloca i32
  store i32 0, i32* %".86"
  %".88" = load i32, i32* %".7"
  %".89" = load i8*, i8** %".3"
  %".90" = getelementptr i8, i8* %".89", i32 %".88"
  %".91" = alloca i32
  %".92" = load i8, i8* %".90"
  %".93" = zext i8 %".92" to i32
  store i32 %".93", i32* %".91"
  %".95" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".96" = call i32 @"EmptyStack"(%"LinkStack"* %".95")
  %".97" = icmp ne i32 %".96", 1
  br i1 %".97", label %"cal.while_body.endif.else.if", label %"cal.while_body.endif.else.endif"
cal.while_body.endif.endif:
  br label %"cal.while_cond"
cal.while_body.endif.if.if:
  br label %"cal.while_body.endif.if.endif"
cal.while_body.endif.if.else:
  br label %"cal.while_body.endif.if.endif"
cal.while_body.endif.if.endif:
  br i1 %".75", label %"cal.while_body.endif.if.endif.if", label %"cal.while_body.endif.if.endif.endif"
cal.while_body.endif.if.endif.if:
  %".80" = load i32, i32* %".9"
  %".81" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".82" = call i32 @"Push"(i32 %".80", %"LinkStack"* %".81")
  store i32 0, i32* %".9"
  br label %"cal.while_body.endif.if.endif.endif"
cal.while_body.endif.if.endif.endif:
  br label %"cal.while_body.endif.endif"
cal.while_body.endif.else.if:
  %".99" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".100" = call i32 @"GetTop"(%"LinkStack"* %".99")
  store i32 %".100", i32* %".86"
  br label %"cal.while_body.endif.else.endif"
cal.while_body.endif.else.endif:
  %".103" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".104" = call i32 @"EmptyStack"(%"LinkStack"* %".103")
  %".105" = icmp eq i32 %".104", 1
  %".106" = load i32, i32* %".86"
  %".107" = icmp eq i32 %".106", 40
  br i1 %".105", label %"cal.while_body.endif.else.endif.if", label %"cal.while_body.endif.else.endif.else"
cal.while_body.endif.else.endif.if:
  br label %"cal.while_body.endif.else.endif.endif"
cal.while_body.endif.else.endif.else:
  br label %"cal.while_body.endif.else.endif.endif"
cal.while_body.endif.else.endif.endif:
  %".111" = load i32, i32* %".91"
  %".112" = icmp ne i32 %".111", 41
  br i1 %".107", label %"cal.while_body.endif.else.endif.endif.if", label %"cal.while_body.endif.else.endif.endif.else"
cal.while_body.endif.else.endif.endif.if:
  br label %"cal.while_body.endif.else.endif.endif.endif"
cal.while_body.endif.else.endif.endif.else:
  br label %"cal.while_body.endif.else.endif.endif.endif"
cal.while_body.endif.else.endif.endif.endif:
  %".116" = load i32, i32* %".91"
  %".117" = call i32 @"Priority"(i32 %".116")
  %".118" = load i32, i32* %".86"
  %".119" = call i32 @"Priority"(i32 %".118")
  %".120" = icmp sgt i32 %".117", %".119"
  br i1 0, label %"cal.while_body.endif.else.endif.endif.endif.if", label %"cal.while_body.endif.else.endif.endif.endif.else"
cal.while_body.endif.else.endif.endif.endif.if:
  br label %"cal.while_body.endif.else.endif.endif.endif.endif"
cal.while_body.endif.else.endif.endif.endif.else:
  br label %"cal.while_body.endif.else.endif.endif.endif.endif"
cal.while_body.endif.else.endif.endif.endif.endif:
  br i1 %".120", label %"cal.while_body.endif.else.endif.endif.endif.endif.if", label %"cal.while_body.endif.else.endif.endif.endif.endif.endif"
cal.while_body.endif.else.endif.endif.endif.endif.if:
  %".125" = load i32, i32* %".91"
  %".126" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".127" = call i32 @"Push"(i32 %".125", %"LinkStack"* %".126")
  %".128" = load i32, i32* %".7"
  %".129" = add i32 %".128", 1
  store i32 %".129", i32* %".7"
  br label %"cal.while_cond"
cal.while_body.endif.else.endif.endif.endif.endif.endif:
  %".132" = load i32, i32* %".86"
  %".133" = icmp eq i32 %".132", 40
  %".134" = load i32, i32* %".91"
  %".135" = icmp eq i32 %".134", 41
  br i1 %".133", label %"cal.while_body.endif.else...if", label %"cal.while_body.endif.else...else"
cal.while_body.endif.else...if:
  br label %"cal.while_body.endif.else...endif"
cal.while_body.endif.else...else:
  br label %"cal.while_body.endif.else...endif"
cal.while_body.endif.else...endif:
  br i1 0, label %"cal.while_body.endif.else...endif.if", label %"cal.while_body.endif.else...endif.endif"
cal.while_body.endif.else...endif.if:
  %".140" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".141" = call i32 @"Pop"(%"LinkStack"* %".140")
  %".142" = load i32, i32* %".7"
  %".143" = add i32 %".142", 1
  store i32 %".143", i32* %".7"
  br label %"cal.while_cond"
cal.while_body.endif.else...endif.endif:
  %".146" = load i32, i32* %".7"
  %".147" = load i8*, i8** %".3"
  %".148" = getelementptr i8, i8* %".147", i32 %".146"
  %".149" = load i8, i8* %".148"
  %".150" = icmp eq i8 %".149", 41
  %".151" = load i32, i32* %".86"
  %".152" = icmp ne i32 %".151", 40
  br i1 %".150", label %"cal.while_body.endif.else...endif.endif.if", label %"cal.while_body.endif.else...endif.endif.else"
cal.while_body.endif.else...endif.endif.if:
  br label %"cal.while_body.endif.else...endif.endif.endif"
cal.while_body.endif.else...endif.endif.else:
  br label %"cal.while_body.endif.else...endif.endif.endif"
cal.while_body.endif.else...endif.endif.endif:
  %".156" = load i32, i32* %".91"
  %".157" = icmp eq i32 %".156", 0
  %".158" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".159" = call i32 @"EmptyStack"(%"LinkStack"* %".158")
  %".160" = icmp ne i32 %".159", 1
  br i1 %".157", label %"cal.while_body.endif.else...endif.endif.endif.if", label %"cal.while_body.endif.else...endif.endif.endif.else"
cal.while_body.endif.else...endif.endif.endif.if:
  br label %"cal.while_body.endif.else...endif.endif.endif.endif"
cal.while_body.endif.else...endif.endif.endif.else:
  br label %"cal.while_body.endif.else...endif.endif.endif.endif"
cal.while_body.endif.else...endif.endif.endif.endif:
  br i1 0, label %"cal.while_body.endif.else...if.1", label %"cal.while_body.endif.else...else.1"
cal.while_body.endif.else...if.1:
  br label %"cal.while_body.endif.else...endif.1"
cal.while_body.endif.else...else.1:
  br label %"cal.while_body.endif.else...endif.1"
cal.while_body.endif.else...endif.1:
  %".167" = load i32, i32* %".91"
  %".168" = call i32 @"Priority"(i32 %".167")
  %".169" = load i32, i32* %".86"
  %".170" = call i32 @"Priority"(i32 %".169")
  %".171" = icmp sle i32 %".168", %".170"
  br i1 0, label %"cal.while_body.endif.else...endif.1.if", label %"cal.while_body.endif.else...endif.1.else"
cal.while_body.endif.else...endif.1.if:
  br label %"cal.while_body.endif.else...endif.1.endif"
cal.while_body.endif.else...endif.1.else:
  br label %"cal.while_body.endif.else...endif.1.endif"
cal.while_body.endif.else...endif.1.endif:
  br i1 %".171", label %"cal.while_body.endif.else...endif.1.endif.if", label %"cal.while_body.endif.else...endif.1.endif.endif"
cal.while_body.endif.else...endif.1.endif.if:
  %".176" = load %"LinkStack"*, %"LinkStack"** %".6"
  %".177" = call i32 @"Pop"(%"LinkStack"* %".176")
  %".178" = alloca i32
  store i32 %".177", i32* %".178"
  %".180" = load i32, i32* %".178"
  %".181" = icmp eq i32 %".180", 43
  br i1 %".181", label %"cal.while_body.endif.else...endif.1.endif.if.if", label %"cal.while_body.endif.else...endif.1.endif.if.endif"
cal.while_body.endif.else...endif.1.endif.endif:
  br label %"cal.while_body.endif.endif"
cal.while_body.endif.else...endif.1.endif.if.if:
  %".183" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".184" = call i32 @"Pop"(%"LinkStack"* %".183")
  %".185" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".186" = call i32 @"Pop"(%"LinkStack"* %".185")
  %".187" = add i32 %".186", %".184"
  %".188" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".189" = call i32 @"Push"(i32 %".187", %"LinkStack"* %".188")
  br label %"cal.while_body.endif.else...endif.1.endif.if.endif"
cal.while_body.endif.else...endif.1.endif.if.endif:
  %".191" = load i32, i32* %".178"
  %".192" = icmp eq i32 %".191", 45
  br i1 %".192", label %"cal.while_body.endif.else...endif.1.endif.if.endif.if", label %"cal.while_body.endif.else...endif.1.endif.if.endif.endif"
cal.while_body.endif.else...endif.1.endif.if.endif.if:
  %".194" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".195" = call i32 @"Pop"(%"LinkStack"* %".194")
  store i32 %".195", i32* %".11"
  %".197" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".198" = call i32 @"Pop"(%"LinkStack"* %".197")
  %".199" = load i32, i32* %".11"
  %".200" = sub i32 %".198", %".199"
  store i32 %".200", i32* %".12"
  %".202" = load i32, i32* %".12"
  %".203" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".204" = call i32 @"Push"(i32 %".202", %"LinkStack"* %".203")
  br label %"cal.while_body.endif.else...endif.1.endif.if.endif.endif"
cal.while_body.endif.else...endif.1.endif.if.endif.endif:
  %".206" = load i32, i32* %".178"
  %".207" = icmp eq i32 %".206", 42
  br i1 %".207", label %"cal.while_body.endif.else...if.2", label %"cal.while_body.endif.else...endif.2"
cal.while_body.endif.else...if.2:
  %".209" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".210" = call i32 @"Pop"(%"LinkStack"* %".209")
  %".211" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".212" = call i32 @"Pop"(%"LinkStack"* %".211")
  %".213" = mul i32 %".212", %".210"
  %".214" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".215" = call i32 @"Push"(i32 %".213", %"LinkStack"* %".214")
  br label %"cal.while_body.endif.else...endif.2"
cal.while_body.endif.else...endif.2:
  %".217" = load i32, i32* %".178"
  %".218" = icmp eq i32 %".217", 47
  br i1 %".218", label %"cal.while_body.endif.else...endif.2.if", label %"cal.while_body.endif.else...endif.2.endif"
cal.while_body.endif.else...endif.2.if:
  %".220" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".221" = call i32 @"Pop"(%"LinkStack"* %".220")
  store i32 %".221", i32* %".11"
  %".223" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".224" = call i32 @"Pop"(%"LinkStack"* %".223")
  %".225" = load i32, i32* %".11"
  %".226" = sdiv i32 %".224", %".225"
  store i32 %".226", i32* %".12"
  %".228" = load i32, i32* %".12"
  %".229" = load %"LinkStack"*, %"LinkStack"** %".5"
  %".230" = call i32 @"Push"(i32 %".228", %"LinkStack"* %".229")
  br label %"cal.while_body.endif.else...endif.2.endif"
cal.while_body.endif.else...endif.2.endif:
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
