; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

declare i32 @"printf"(i8* %".1", ...)

define i32 @"main"()
{
main:
  %".2" = alloca i32
  store i32 1, i32* %".2"
  %".4" = alloca [333 x i8], i32 333
  %".5" = getelementptr [333 x i8], [333 x i8]* %".4", i32 0, i32 0
  store i8 49, i8* %".5"
  %".7" = getelementptr [333 x i8], [333 x i8]* %".4", i32 1, i32 1
  store i8 50, i8* %".7"
  %".9" = getelementptr [333 x i8], [333 x i8]* %".4", i32 2, i32 2
  store i8 51, i8* %".9"
  %".11" = getelementptr [333 x i8], [333 x i8]* %".4", i32 3, i32 3
  store i8 52, i8* %".11"
  %".13" = getelementptr [333 x i8], [333 x i8]* %".4", i32 4, i32 4
  store i8 0, i8* %".13"
  %".15" = icmp ne i32 1, 0
  br i1 %".15", label %"main.if", label %"main.endif"
main.if:
  %".17" = icmp ne i32 1, 0
  br i1 %".17", label %"main.if.if", label %"main.if.endif"
main.endif:
  %".29" = getelementptr [333 x i8], [333 x i8]* %".4", i32 0, i32 0
  %".30" = load i8, i8* %".29"
  %".31" = zext i8 %".30" to i32
  store i32 %".31", i32* %".2"
  %".33" = load i32, i32* %".2"
  ret i32 %".33"
main.if.if:
  %".19" = getelementptr [333 x i8], [333 x i8]* %".4", i32 2, i32 2
  %".20" = load i8, i8* %".19"
  %".21" = zext i8 %".20" to i32
  store i32 %".21", i32* %".2"
  br label %"main.if.endif"
main.if.endif:
  %".24" = getelementptr [333 x i8], [333 x i8]* %".4", i32 3, i32 3
  %".25" = load i8, i8* %".24"
  %".26" = zext i8 %".25" to i32
  store i32 %".26", i32* %".2"
  br label %"main.endif"
}
