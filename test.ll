; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

%"Node" = type {i32, i32*}
declare i32 @"printf"(i8* %".1", ...) 

declare i32 @"scanf"(i8* %".1", ...) 

define i32 @"read_num"(%"Node"* %".1") 
{
read_num:
  %".3" = alloca %"Node"*
  store %"Node"* %".1", %"Node"** %".3"
  %".5" = load %"Node"*, %"Node"** %".3"
  %".6" = getelementptr %"Node", %"Node"* %".5", i32 1
  %".7" = bitcast %"Node"* %".6" to i32**
  %".8" = alloca i32*
  %".9" = load i32*, i32** %".7"
  store i32* %".9", i32** %".8"
  %".11" = load i32*, i32** %".8"
  %".12" = getelementptr i32, i32* %".11", i32 0
  %".13" = alloca i32
  %".14" = load i32, i32* %".12"
  store i32 %".14", i32* %".13"
  %".16" = load %"Node"*, %"Node"** %".3"
  %".17" = getelementptr %"Node", %"Node"* %".16", i32 0
  %".18" = bitcast %"Node"* %".17" to i32*
  %".19" = load i32, i32* %".13"
  store i32 %".19", i32* %".18"
  ret i32 1
}

define i32 @"main"() 
{
main:
  %".2" = alloca i32
  %".3" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([24 x i8], [24 x i8]* @"\22please key in a number\5cn\22", i32 0, i32 0))
  %".4" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%d\22", i32 0, i32 0), i32* %".2")
  %".5" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([43 x i8], [43 x i8]* @"\22address that this number is stored in: %d\5cn\22", i32 0, i32 0), i32* %".2")
  %".6" = alloca i32*
  store i32* %".2", i32** %".6"
  %".8" = load i32*, i32** %".6"
  %".9" = getelementptr i32, i32* %".8", i32 0
  %".10" = alloca i32
  %".11" = load i32, i32* %".9"
  store i32 %".11", i32* %".10"
  %".13" = load i32, i32* %".10"
  %".14" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([27 x i8], [27 x i8]* @"\22value in this address: %d\5cn\22", i32 0, i32 0), i32 %".13")
  %".15" = alloca i8, i32 8
  %".16" = bitcast i8* %".15" to %"Node"*
  %".17" = alloca %"Node"*
  store %"Node"* %".16", %"Node"** %".17"
  %".19" = load %"Node"*, %"Node"** %".17"
  %".20" = getelementptr %"Node", %"Node"* %".19", i32 1
  %".21" = bitcast %"Node"* %".20" to i32**
  %".22" = load i32*, i32** %".6"
  store i32* %".22", i32** %".21"
  %".24" = load %"Node"*, %"Node"** %".17"
  %".25" = call i32 @"read_num"(%"Node"* %".24")
  %".26" = load %"Node"*, %"Node"** %".17"
  %".27" = getelementptr %"Node", %"Node"* %".26", i32 0
  %".28" = bitcast %"Node"* %".27" to i32*
  %".29" = alloca i32
  %".30" = load i32, i32* %".28"
  store i32 %".30", i32* %".29"
  %".32" = load i32, i32* %".29"
  %".33" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([35 x i8], [35 x i8]* @"\22after it's stored in a struct: %d\5cn\22", i32 0, i32 0), i32 %".32")
  ret i32 0
}

@"\22please key in a number\5cn\22" = global [24 x i8] c"please key in a number\0a\00"
@"\22%d\22" = global [3 x i8] c"%d\00"
@"\22address that this number is stored in: %d\5cn\22" = global [43 x i8] c"address that this number is stored in: %d\0a\00"
@"\22value in this address: %d\5cn\22" = global [27 x i8] c"value in this address: %d\0a\00"
@"\22after it's stored in a struct: %d\5cn\22" = global [35 x i8] c"after it's stored in a struct: %d\0a\00"