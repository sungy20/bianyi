; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

define i32 @"strlen"(i8* %".1")
{
strlen:
  %".3" = alloca i8*
  store i8* %".1", i8** %".3"
  %".5" = alloca i32
  store i32 0, i32* %".5"
  br label %"strlen.while_cond"
strlen.while_cond:
  %".8" = icmp ne i32 1, 0
  br i1 %".8", label %"strlen.while_body", label %"strlen.while_end"
strlen.while_body:
  %".10" = load i32, i32* %".5"
  %".11" = load i8*, i8** %".3"
  %".12" = getelementptr i8, i8* %".11", i32 %".10"
  %".13" = load i8, i8* %".12"
  %".14" = icmp eq i8 %".13", 0
  br i1 %".14", label %"strlen.while_body.if", label %"strlen.while_body.endif"
strlen.while_end:
  %".21" = load i32, i32* %".5"
  ret i32 %".21"
strlen.while_body.if:
  br label %"strlen.while_end"
strlen.while_body.endif:
  %".17" = load i32, i32* %".5"
  %".18" = add i32 %".17", 1
  store i32 %".18", i32* %".5"
  br label %"strlen.while_cond"
}

define i32 @"match"(i32* %".1", i32 %".2", i8* %".3", i8* %".4")
{
match:
  %".6" = alloca i32*
  store i32* %".1", i32** %".6"
  %".8" = alloca i32
  store i32 %".2", i32* %".8"
  %".10" = alloca i8*
  store i8* %".3", i8** %".10"
  %".12" = alloca i8*
  store i8* %".4", i8** %".12"
  %".14" = load i32, i32* %".8"
  %".15" = alloca i32
  store i32 %".14", i32* %".15"
  %".17" = alloca i32
  store i32 0, i32* %".17"
  %".19" = load i8*, i8** %".12"
  %".20" = call i32 @"strlen"(i8* %".19")
  %".21" = alloca i32
  store i32 %".20", i32* %".21"
  %".23" = load i8*, i8** %".10"
  %".24" = call i32 @"strlen"(i8* %".23")
  %".25" = alloca i32
  store i32 %".24", i32* %".25"
  br label %"match.while_cond"
match.while_cond:
  %".28" = load i32, i32* %".15"
  %".29" = load i32, i32* %".21"
  %".30" = icmp slt i32 %".28", %".29"
  %".31" = load i32, i32* %".17"
  %".32" = load i32, i32* %".25"
  %".33" = icmp slt i32 %".31", %".32"
  %".34" = and i1 %".30", %".33"
  br i1 %".34", label %"match.while_body", label %"match.while_end"
match.while_body:
  %".36" = load i32, i32* %".17"
  %".37" = icmp eq i32 %".36", -1
  %".38" = load i32, i32* %".15"
  %".39" = load i8*, i8** %".12"
  %".40" = getelementptr i8, i8* %".39", i32 %".38"
  %".41" = load i32, i32* %".17"
  %".42" = load i8*, i8** %".10"
  %".43" = getelementptr i8, i8* %".42", i32 %".41"
  %".44" = load i8, i8* %".40"
  %".45" = load i8, i8* %".43"
  %".46" = icmp eq i8 %".44", %".45"
  %".47" = or i1 %".37", %".46"
  br i1 %".47", label %"match.while_body.if", label %"match.while_body.else"
match.while_end:
  %".63" = load i32, i32* %".25"
  %".64" = load i32, i32* %".17"
  %".65" = icmp eq i32 %".63", %".64"
  br i1 %".65", label %"match.while_end.if", label %"match.while_end.endif"
match.while_body.if:
  %".49" = load i32, i32* %".15"
  %".50" = add i32 %".49", 1
  store i32 %".50", i32* %".15"
  %".52" = load i32, i32* %".17"
  %".53" = add i32 %".52", 1
  store i32 %".53", i32* %".17"
  br label %"match.while_body.endif"
match.while_body.else:
  %".56" = load i32, i32* %".17"
  %".57" = load i32*, i32** %".6"
  %".58" = getelementptr i32, i32* %".57", i32 %".56"
  %".59" = load i32, i32* %".58"
  store i32 %".59", i32* %".17"
  br label %"match.while_body.endif"
match.while_body.endif:
  br label %"match.while_cond"
match.while_end.if:
  %".67" = load i32, i32* %".25"
  %".68" = load i32, i32* %".15"
  %".69" = sub i32 %".68", %".67"
  ret i32 %".69"
match.while_end.endif:
  ret i32 -1
}

define i32 @"get_next"(i32* %".1", i8* %".2")
{
get_next:
  %".4" = alloca i32*
  store i32* %".1", i32** %".4"
  %".6" = alloca i8*
  store i8* %".2", i8** %".6"
  %".8" = alloca i32
  store i32 -1, i32* %".8"
  %".10" = alloca i32
  store i32 0, i32* %".10"
  %".12" = load i32, i32* %".10"
  %".13" = load i32*, i32** %".4"
  %".14" = getelementptr i32, i32* %".13", i32 %".12"
  %".15" = load i32, i32* %".8"
  store i32 %".15", i32* %".14"
  %".17" = load i8*, i8** %".6"
  %".18" = call i32 @"strlen"(i8* %".17")
  %".19" = alloca i32
  store i32 %".18", i32* %".19"
  br label %"get_next.while_cond"
get_next.while_cond:
  %".22" = load i32, i32* %".10"
  %".23" = load i32, i32* %".19"
  %".24" = icmp slt i32 %".22", %".23"
  br i1 %".24", label %"get_next.while_body", label %"get_next.while_end"
get_next.while_body:
  %".26" = load i32, i32* %".8"
  %".27" = icmp eq i32 %".26", -1
  %".28" = load i32, i32* %".10"
  %".29" = load i8*, i8** %".6"
  %".30" = getelementptr i8, i8* %".29", i32 %".28"
  %".31" = load i32, i32* %".8"
  %".32" = load i8*, i8** %".6"
  %".33" = getelementptr i8, i8* %".32", i32 %".31"
  %".34" = load i8, i8* %".30"
  %".35" = load i8, i8* %".33"
  %".36" = icmp eq i8 %".34", %".35"
  %".37" = or i1 %".27", %".36"
  br i1 %".37", label %"get_next.while_body.if", label %"get_next.while_body.else"
get_next.while_end:
  ret i32 0
get_next.while_body.if:
  %".39" = load i32, i32* %".8"
  %".40" = add i32 %".39", 1
  store i32 %".40", i32* %".8"
  %".42" = load i32, i32* %".10"
  %".43" = add i32 %".42", 1
  store i32 %".43", i32* %".10"
  %".45" = load i32, i32* %".10"
  %".46" = load i32*, i32** %".4"
  %".47" = getelementptr i32, i32* %".46", i32 %".45"
  %".48" = load i32, i32* %".8"
  store i32 %".48", i32* %".47"
  br label %"get_next.while_body.endif"
get_next.while_body.else:
  %".51" = load i32, i32* %".8"
  %".52" = load i32*, i32** %".4"
  %".53" = getelementptr i32, i32* %".52", i32 %".51"
  %".54" = load i32, i32* %".53"
  store i32 %".54", i32* %".8"
  br label %"get_next.while_body.endif"
get_next.while_body.endif:
  br label %"get_next.while_cond"
}

define i32 @"print_next"(i32 %".1", i32* %".2")
{
print_next:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %".6" = alloca i32*
  store i32* %".2", i32** %".6"
  %".8" = alloca i32
  store i32 0, i32* %".8"
  br label %"print_next.while_cond"
print_next.while_cond:
  %".11" = load i32, i32* %".8"
  %".12" = load i32, i32* %".4"
  %".13" = icmp slt i32 %".11", %".12"
  br i1 %".13", label %"print_next.while_body", label %"print_next.while_end"
print_next.while_body:
  %".15" = load i32, i32* %".8"
  %".16" = load i32, i32* %".8"
  %".17" = load i32*, i32** %".6"
  %".18" = getelementptr i32, i32* %".17", i32 %".16"
  %".19" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([17 x i8], [17 x i8]* @"\22p_next[%d] = %d\5cn\22", i32 0, i32 0), i32 %".15", i32* %".18")
  %".20" = load i32, i32* %".8"
  %".21" = add i32 %".20", 1
  store i32 %".21", i32* %".8"
  br label %"print_next.while_cond"
print_next.while_end:
  ret i32 0
}

@"\22p_next[%d] = %d\5cn\22" = global [17 x i8] c"p_next[%d] = %d\0a\00"
define i32 @"main"()
{
main:
  %".2" = alloca [100 x i8], i32 100
  %".3" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 0
  store i8 97, i8* %".3"
  %".5" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 1
  store i8 98, i8* %".5"
  %".7" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 2
  store i8 97, i8* %".7"
  %".9" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 3
  store i8 98, i8* %".9"
  %".11" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 4
  store i8 99, i8* %".11"
  %".13" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 5
  store i8 97, i8* %".13"
  %".15" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 6
  store i8 98, i8* %".15"
  %".17" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 7
  store i8 99, i8* %".17"
  %".19" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 8
  store i8 97, i8* %".19"
  %".21" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 9
  store i8 99, i8* %".21"
  %".23" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 10
  store i8 98, i8* %".23"
  %".25" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 11
  store i8 97, i8* %".25"
  %".27" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 12
  store i8 98, i8* %".27"
  %".29" = getelementptr [100 x i8], [100 x i8]* %".2", i32 0, i32 13
  store i8 0, i8* %".29"
  %".31" = alloca [100 x i8], i32 100
  %".32" = getelementptr [100 x i8], [100 x i8]* %".31", i32 0, i32 0
  store i8 97, i8* %".32"
  %".34" = getelementptr [100 x i8], [100 x i8]* %".31", i32 0, i32 1
  store i8 98, i8* %".34"
  %".36" = getelementptr [100 x i8], [100 x i8]* %".31", i32 0, i32 2
  store i8 99, i8* %".36"
  %".38" = getelementptr [100 x i8], [100 x i8]* %".31", i32 0, i32 3
  store i8 97, i8* %".38"
  %".40" = getelementptr [100 x i8], [100 x i8]* %".31", i32 0, i32 4
  store i8 99, i8* %".40"
  %".42" = getelementptr [100 x i8], [100 x i8]* %".31", i32 0, i32 5
  store i8 0, i8* %".42"
  %".44" = alloca i32
  store i32 0, i32* %".44"
  %".46" = alloca i32
  store i32 0, i32* %".46"
  %".48" = alloca [32 x i32], i32 32
  %".49" = zext i8 0 to i32
  %".50" = getelementptr [32 x i32], [32 x i32]* %".48", i32 0, i32 0
  store i32 %".49", i32* %".50"
  %".52" = zext i8 0 to i32
  %".53" = getelementptr [32 x i32], [32 x i32]* %".48", i32 0, i32 1
  store i32 %".52", i32* %".53"
  %".55" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([12 x i8], [12 x i8]* @"\22\5cnKMP test:\5cn\22", i32 0, i32 0))
  %".56" = load [32 x i32], [32 x i32]* %".48"
  %".57" = load [100 x i8], [100 x i8]* %".31"
  %".58" = alloca [32 x i32]
  store [32 x i32] %".56", [32 x i32]* %".58"
  %".60" = getelementptr [32 x i32], [32 x i32]* %".58", i32 0, i32 0
  %".61" = alloca [100 x i8]
  store [100 x i8] %".57", [100 x i8]* %".61"
  %".63" = getelementptr [100 x i8], [100 x i8]* %".61", i32 0, i32 0
  %".64" = call i32 @"get_next"(i32* %".60", i8* %".63")
  %".65" = load [100 x i8], [100 x i8]* %".31"
  %".66" = alloca [100 x i8]
  store [100 x i8] %".65", [100 x i8]* %".66"
  %".68" = getelementptr [100 x i8], [100 x i8]* %".66", i32 0, i32 0
  %".69" = call i32 @"strlen"(i8* %".68")
  %".70" = alloca i32
  store i32 %".69", i32* %".70"
  %".72" = load i32, i32* %".70"
  %".73" = load [32 x i32], [32 x i32]* %".48"
  %".74" = alloca [32 x i32]
  store [32 x i32] %".73", [32 x i32]* %".74"
  %".76" = getelementptr [32 x i32], [32 x i32]* %".74", i32 0, i32 0
  %".77" = call i32 @"print_next"(i32 %".72", i32* %".76")
  %".78" = load [32 x i32], [32 x i32]* %".48"
  %".79" = load i32, i32* %".44"
  %".80" = load [100 x i8], [100 x i8]* %".31"
  %".81" = load [100 x i8], [100 x i8]* %".2"
  %".82" = alloca [32 x i32]
  store [32 x i32] %".78", [32 x i32]* %".82"
  %".84" = getelementptr [32 x i32], [32 x i32]* %".82", i32 0, i32 0
  %".85" = alloca [100 x i8]
  store [100 x i8] %".80", [100 x i8]* %".85"
  %".87" = getelementptr [100 x i8], [100 x i8]* %".85", i32 0, i32 0
  %".88" = alloca [100 x i8]
  store [100 x i8] %".81", [100 x i8]* %".88"
  %".90" = getelementptr [100 x i8], [100 x i8]* %".88", i32 0, i32 0
  %".91" = call i32 @"match"(i32* %".84", i32 %".79", i8* %".87", i8* %".90")
  store i32 %".91", i32* %".46"
  %".93" = load i32, i32* %".46"
  %".94" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([12 x i8], [12 x i8]* @"\22index = %d\5cn\22", i32 0, i32 0), i32 %".93")
  ret i32 0
}

@"\22\5cnKMP test:\5cn\22" = global [12 x i8] c"\0aKMP test:\0a\00"
@"\22index = %d\5cn\22" = global [12 x i8] c"index = %d\0a\00"