; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

define i32 @"main"()
{
main:
  %".2" = alloca [10 x i32], i32 10
  %".3" = getelementptr [10 x i32], [10 x i32]* %".2", i32 0, i32 0
  store i32 5, i32* %".3"
  %".5" = getelementptr [10 x i32], [10 x i32]* %".2", i32 1, i32 1
  store i32 8, i32* %".5"
  %".7" = getelementptr [10 x i32], [10 x i32]* %".2", i32 2, i32 2
  store i32 4, i32* %".7"
  %".9" = getelementptr [10 x i32], [10 x i32]* %".2", i32 3, i32 3
  store i32 9, i32* %".9"
  %".11" = alloca i32
  store i32 4, i32* %".11"
  %".13" = alloca i32
  store i32 0, i32* %".13"
  br label %"main.while_cond"
main.while_cond:
  %".16" = load i32, i32* %".13"
  %".17" = load i32, i32* %".11"
  %".18" = sub i32 %".17", 1
  %".19" = icmp slt i32 %".16", %".18"
  br i1 %".19", label %"main.while_body", label %"main.while_end"
main.while_body:
  %".21" = load i32, i32* %".13"
  %".22" = add i32 %".21", 1
  %".23" = alloca i32
  store i32 %".22", i32* %".23"
  br label %"main.while_body.while_cond"
main.while_end:
  %".62" = getelementptr [10 x i32], [10 x i32]* %".2", i32 3, i32 3
  %".63" = load i32, i32* %".62"
  ret i32 %".63"
main.while_body.while_cond:
  %".26" = load i32, i32* %".23"
  %".27" = load i32, i32* %".11"
  %".28" = icmp slt i32 %".26", %".27"
  br i1 %".28", label %"main.while_body.while_body", label %"main.while_body.while_end"
main.while_body.while_body:
  %".30" = load i32, i32* %".13"
  %".31" = getelementptr [10 x i32], [10 x i32]* %".2", i32 %".30", i32 %".30"
  %".32" = load i32, i32* %".23"
  %".33" = getelementptr [10 x i32], [10 x i32]* %".2", i32 %".32", i32 %".32"
  %".34" = load i32, i32* %".31"
  %".35" = load i32, i32* %".33"
  %".36" = icmp sgt i32 %".34", %".35"
  br i1 %".36", label %"main.while_body.while_body.if", label %"main.while_body.while_body.endif"
main.while_body.while_end:
  %".58" = load i32, i32* %".13"
  %".59" = add i32 %".58", 1
  store i32 %".59", i32* %".13"
  br label %"main.while_cond"
main.while_body.while_body.if:
  %".38" = load i32, i32* %".13"
  %".39" = getelementptr [10 x i32], [10 x i32]* %".2", i32 %".38", i32 %".38"
  %".40" = load i32, i32* %".39"
  %".41" = alloca i32
  store i32 %".40", i32* %".41"
  %".43" = load i32, i32* %".13"
  %".44" = getelementptr [10 x i32], [10 x i32]* %".2", i32 %".43", i32 %".43"
  %".45" = load i32, i32* %".23"
  %".46" = getelementptr [10 x i32], [10 x i32]* %".2", i32 %".45", i32 %".45"
  %".47" = load i32, i32* %".46"
  store i32 %".47", i32* %".44"
  %".49" = load i32, i32* %".23"
  %".50" = getelementptr [10 x i32], [10 x i32]* %".2", i32 %".49", i32 %".49"
  %".51" = load i32, i32* %".41"
  store i32 %".51", i32* %".50"
  br label %"main.while_body.while_body.endif"
main.while_body.while_body.endif:
  %".54" = load i32, i32* %".23"
  %".55" = add i32 %".54", 1
  store i32 %".55", i32* %".23"
  br label %"main.while_body.while_cond"
}
