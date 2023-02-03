
import 'package:get/get.dart';
enum CalcOperator{
  sum,res,div,mul
}
class CalculatorController extends GetxController{
 Rx<CalcOperator?> operation=Rx<CalcOperator?>(null);

 Rx<List<dynamic>> numList=Rx<List<dynamic>>([0]);
 Rx<List<num>> resultList=Rx<List<num>>([]);

 Rx<bool> punto=Rx<bool>(false);

  result(){
    for(var i=0;i<numList.value.length;i++){
      final val=numList.value[i];
      if( val==CalcOperator.mul){
        numList.value[i+1]=numList.value[i-1]*numList.value[i+1];
        numList.value.removeAt(i);
        numList.value.removeAt(i-1);
        i--;
      }
    }
    for(var i=0;i<numList.value.length;i++){
      final val=numList.value[i];
      if(val is CalcOperator){
        if( val==CalcOperator.sum){
          numList.value[i+1]=numList.value[i-1]+numList.value[i+1];
        }
        if( val==CalcOperator.res){
          numList.value[i+1]=numList.value[i-1]-numList.value[i+1];
        }
        if( val==CalcOperator.div){
          if(numList.value[i-1]%numList.value[i+1]==0){
            numList.value[i+1]=(numList.value[i-1]/numList.value[i+1]).toInt();
          }
          else{
            numList.value[i+1]=numList.value[i-1]/numList.value[i+1];
          }

        }
        numList.value.removeAt(i);
        numList.value.removeAt(i-1);
        i--;
      }
    }
    numList.refresh();
  }
  delete(){
    if(numList.value.last is num){
      var text=numList.value.last.toString();
      text=text.substring(0,text.length-1);
      if(text.isEmpty){
        if(numList.value.length>2){
          numList.value.removeLast();
          numList.value.removeLast();
        }
        else{
          numList.value.last=0;
        }
        numList.refresh();
        return;
      }
      if(text[text.length-1]=="."){
        text=text.substring(0,text.length-1);
      }
      if(text=="-"){
        numList.value.last=0;
        numList.refresh();
        return;
      }
      var textDouble=convertNum(text);
      if(textDouble!=null){
        numList.value.last=textDouble;
        numList.refresh();
      }
    }
    else{
      numList.value.removeLast();
      numList.refresh();
    }
  }
  changeNumber(String number){
    if(numList.value.last is CalcOperator){
      var text=number;
      if(punto.value){
        punto.value=false;
      }
      var textDouble=convertNum(text);
      if(textDouble!=null){
        numList.value.add(textDouble);
        numList.refresh();
      }
    }
    else if(numList.value.last is num){
      var text=numList.value.last.toString();
      if(punto.value){
        text+=".";
        punto.value=false;
      }
      text+=number;
      var textDouble=convertNum(text);
      if(textDouble!=null){
        numList.value.last=textDouble;
        numList.refresh();
      }
    }
  }

  reset(){
    numList.value=[0];
  }


  num? convertNum(String text){
    try{
      return num.parse(text);
    }
    catch(error){
      return null;
    }
  }

  activePunto(){
    punto.value=true;
  }


  addOperation(CalcOperator operator){
    if(numList.value.last is num && numList.value.last!=0){
      numList.value.add(operator);
      numList.refresh();
    }
    else if(numList.value.last==0&&numList.value.length==1&&operator==CalcOperator.res){
      numList.value.add(operator);
      numList.refresh();
    }

  }




}