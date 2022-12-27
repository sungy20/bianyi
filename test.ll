; ModuleID = "C2LLVM"
target triple = "unknown-unknown-unknown"
target datalayout = ""

%"Node" = type {i32, %"Node"*}
%"LinkStack" = type {%"Node"*, i32}
declare i32 @"printf"(i8* %".1", ...) 

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

define i32 @"main"() 
{
main:
  %".2" = alloca i8, i32 8
  %".3" = bitcast i8* %".2" to %"LinkStack"*
  %".4" = alloca %"LinkStack"*
  store %"LinkStack"* %".3", %"LinkStack"** %".4"
  %".6" = load %"LinkStack"*, %"LinkStack"** %".4"
  %".7" = call i32 @"Push"(i32 1213, %"LinkStack"* %".6")
  %".8" = load %"LinkStack"*, %"LinkStack"** %".4"
  %".9" = call i32 @"Push"(i32 1213, %"LinkStack"* %".8")
  ret i32 -1
}
