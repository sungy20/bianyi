; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

declare i32 @"scanf"(i8* %".1", ...)

define i32 @"main"()
{
main:
  %".2" = alloca i32
  %".3" = load i32, i32* %".2"
  %".4" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32* %".2")
  %".5" = load i32, i32* %".2"
  %".6" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d\5cn\22", i32 0, i32 0), i32 %".5")
  %".7" = alloca i32
  store i32 0, i32* %".7"
  %".9" = alloca [100 x i32], i32 100
  br label %"main.while_cond"
main.while_cond:
  %".11" = load i32, i32* %".7"
  %".12" = load i32, i32* %".2"
  %".13" = sub i32 %".12", 1
  %".14" = icmp slt i32 %".11", %".13"
  br i1 %".14", label %"main.while_body", label %"main.while_end"
main.while_body:
  %".16" = load i32, i32* %".7"
  %".17" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".16"
  %".18" = load i32, i32* %".7"
  %".19" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".18"
  %".20" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d,\22", i32 0, i32 0), i32* %".19")
  %".21" = load i32, i32* %".7"
  %".22" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".21"
  %".23" = load i32, i32* %".22"
  %".24" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d\5cn\22", i32 0, i32 0), i32 %".23")
  %".25" = load i32, i32* %".7"
  %".26" = add i32 %".25", 1
  store i32 %".26", i32* %".7"
  br label %"main.while_cond"
main.while_end:
  %".29" = load i32, i32* %".2"
  %".30" = sub i32 %".29", 1
  %".31" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".30"
  %".32" = load i32, i32* %".2"
  %".33" = sub i32 %".32", 1
  %".34" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".33"
  %".35" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32* %".34")
  store i32 0, i32* %".7"
  br label %"main.while_end.while_cond"
main.while_end.while_cond:
  %".38" = load i32, i32* %".7"
  %".39" = load i32, i32* %".2"
  %".40" = sub i32 %".39", 1
  %".41" = icmp slt i32 %".38", %".40"
  br i1 %".41", label %"main.while_end.while_body", label %"main.while_end.while_end"
main.while_end.while_body:
  %".43" = load i32, i32* %".7"
  %".44" = add i32 %".43", 1
  %".45" = alloca i32
  store i32 %".44", i32* %".45"
  br label %"main.while_end.while_body.while_cond"
main.while_end.while_end:
  store i32 0, i32* %".7"
  br label %"main.while_end.while_end.while_cond"
main.while_end.while_body.while_cond:
  %".48" = load i32, i32* %".45"
  %".49" = load i32, i32* %".2"
  %".50" = icmp slt i32 %".48", %".49"
  br i1 %".50", label %"main.while_end.while_body.while_body", label %"main.while_end.while_body.while_end"
main.while_end.while_body.while_body:
  %".52" = load i32, i32* %".7"
  %".53" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".52"
  %".54" = load i32, i32* %".45"
  %".55" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".54"
  %".56" = load i32, i32* %".53"
  %".57" = load i32, i32* %".55"
  %".58" = icmp sgt i32 %".56", %".57"
  br i1 %".58", label %"main.while_end.while_body.while_body.if", label %"main.while_end.while_body.while_body.endif"
main.while_end.while_body.while_end:
  %".80" = load i32, i32* %".7"
  %".81" = add i32 %".80", 1
  store i32 %".81", i32* %".7"
  br label %"main.while_end.while_cond"
main.while_end.while_body.while_body.if:
  %".60" = load i32, i32* %".7"
  %".61" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".60"
  %".62" = load i32, i32* %".61"
  %".63" = alloca i32
  store i32 %".62", i32* %".63"
  %".65" = load i32, i32* %".7"
  %".66" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".65"
  %".67" = load i32, i32* %".45"
  %".68" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".67"
  %".69" = load i32, i32* %".68"
  store i32 %".69", i32* %".66"
  %".71" = load i32, i32* %".45"
  %".72" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".71"
  %".73" = load i32, i32* %".63"
  store i32 %".73", i32* %".72"
  br label %"main.while_end.while_body.while_body.endif"
main.while_end.while_body.while_body.endif:
  %".76" = load i32, i32* %".45"
  %".77" = add i32 %".76", 1
  store i32 %".77", i32* %".45"
  br label %"main.while_end.while_body.while_cond"
main.while_end.while_end.while_cond:
  %".86" = load i32, i32* %".7"
  %".87" = load i32, i32* %".2"
  %".88" = sub i32 %".87", 1
  %".89" = icmp slt i32 %".86", %".88"
  br i1 %".89", label %"main.while_end.while_end.while_body", label %"main.while_end.while_end.while_end"
main.while_end.while_end.while_body:
  %".91" = load i32, i32* %".7"
  %".92" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".91"
  %".93" = load i32, i32* %".92"
  %".94" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([4 x i8], [4 x i8]* @"\22%d,\22", i32 0, i32 0), i32 %".93")
  %".95" = load i32, i32* %".7"
  %".96" = add i32 %".95", 1
  store i32 %".96", i32* %".7"
  br label %"main.while_end.while_end.while_cond"
main.while_end.while_end.while_end:
  %".99" = load i32, i32* %".2"
  %".100" = sub i32 %".99", 1
  %".101" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 %".100"
  %".102" = load i32, i32* %".101"
  %".103" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32 %".102")
  %".104" = getelementptr [100 x i32], [100 x i32]* %".9", i32 0, i32 3
  %".105" = load i32, i32* %".104"
  ret i32 %".105"
}

@"\22%d\22" = global [3 x i8] c"%d\00"
@"\22%d\5cn\22" = global [4 x i8] c"%d\0a\00"
@"\22%d,\22" = global [4 x i8] c"%d,\00"