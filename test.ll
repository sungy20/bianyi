; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

%"Node" = type {i32, i8*}
declare i32 @"printf"(i8* %".1", ...) 

declare i32 @"scanf"(i8* %".1", ...) 

define i32 @"read_num"(%"Node"* %".1") 
{
read_num:
  %".3" = alloca %"Node"*
  store %"Node"* %".1", %"Node"** %".3"
  %".5" = load %"Node"*, %"Node"** %".3"
  %".6" = getelementptr %"Node", %"Node"* %".5", i32 1
  %".7" = bitcast %"Node"* %".6" to i8**
  %".8" = alloca i8*
  %".9" = load i8*, i8** %".7"
  store i8* %".9", i8** %".8"
  %".11" = load i8*, i8** %".8"
  %".12" = getelementptr i8, i8* %".11", i32 0
  %".13" = alloca i32
  %".14" = load i8, i8* %".12"
  %".15" = zext i8 %".14" to i32
  store i32 %".15", i32* %".13"
  %".17" = load %"Node"*, %"Node"** %".3"
  %".18" = getelementptr %"Node", %"Node"* %".17", i32 0
  %".19" = bitcast %"Node"* %".18" to i32*
  %".20" = load i32, i32* %".13"
  store i32 %".20", i32* %".19"
  ret i32 1
}

define i32 @"main"() 
{
main:
  %".2" = alloca [5 x i8], i32 5
  %".3" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([28 x i8], [28 x i8]* @"\22please key in a character:\5cn\22", i32 0, i32 0))
  %".4" = call i32 (i8*, ...) @"scanf"(i8* getelementptr ([3 x i8], [3 x i8]* @"\22%s\22", i32 0, i32 0), [5 x i8]* %".2")
  %".5" = load [5 x i8], [5 x i8]* %".2"
  %".6" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([46 x i8], [46 x i8]* @"\22address that this character is stored in: %d\5cn\22", i32 0, i32 0), [5 x i8]* %".2")
  %".7" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([27 x i8], [27 x i8]* @"\22its reference address: %d\5cn\22", i32 0, i32 0), [5 x i8]* %".2")
  %".8" = alloca i8, i32 8
  %".9" = bitcast i8* %".8" to %"Node"*
  %".10" = alloca %"Node"*
  store %"Node"* %".9", %"Node"** %".10"
  %".12" = load %"Node"*, %"Node"** %".10"
  %".13" = getelementptr %"Node", %"Node"* %".12", i32 1
  %".14" = bitcast %"Node"* %".13" to i8**
  %".15" = getelementptr [5 x i8], [5 x i8]* %".2", i32 0, i32 0
  store i8* %".15", i8** %".14"
  %".17" = load %"Node"*, %"Node"** %".10"
  %".18" = call i32 @"read_num"(%"Node"* %".17")
  %".19" = load %"Node"*, %"Node"** %".10"
  %".20" = getelementptr %"Node", %"Node"* %".19", i32 0
  %".21" = bitcast %"Node"* %".20" to i32*
  %".22" = alloca i32
  %".23" = load i32, i32* %".21"
  store i32 %".23", i32* %".22"
  %".25" = load i32, i32* %".22"
  %".26" = call i32 (i8*, ...) @"printf"(i8* getelementptr ([79 x i8], [79 x i8]* @"\22after it's stored in a struct, we calculated the ASCII for this character: %d\5cn\22", i32 0, i32 0), i32 %".25")
  ret i32 0
}

@"\22please key in a character:\5cn\22" = global [28 x i8] c"please key in a character:\0a\00"
@"\22%s\22" = global [3 x i8] c"%s\00"
@"\22address that this character is stored in: %d\5cn\22" = global [46 x i8] c"address that this character is stored in: %d\0a\00"
@"\22its reference address: %d\5cn\22" = global [27 x i8] c"its reference address: %d\0a\00"
@"\22after it's stored in a struct, we calculated the ASCII for this character: %d\5cn\22" = global [79 x i8] c"after it's stored in a struct, we calculated the ASCII for this character: %d\0a\00"