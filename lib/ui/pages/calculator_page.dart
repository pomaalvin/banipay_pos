import 'package:banipay_pos/domain/calculator_controller.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:banipay_pos/ui/widgets/atoms/bp_text.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_button.dart';
import 'package:banipay_pos/ui/widgets/organism/bp_bottom_nav.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorPage extends StatelessWidget {
  final _calc=Get.put<CalculatorController>(CalculatorController());
  CalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BpColors.lightGrey,
      bottomNavigationBar: const BpBottomNav(itemNavActive: ItemNavActive.cal),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
                height: 100,
                width: 10000,
                child: Obx((){
                          return SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            reverse: true,
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              crossAxisAlignment: WrapCrossAlignment.center,

                              children: [
                                ..._calc.numList.value.asMap().entries.map((e){
                                  if(e.value is CalcOperator){
                                   return getStringOperator(e.value);
                                  }
                                  else{
                                    if(e.key==0&&e.value==0&&_calc.numList.value.length>2){
                                      return const SizedBox.shrink();
                                    }
                                    return BpText.title(
                                        color: BpColors.tertiary,
                                        text: "${e.value.toString()}${_calc.punto.value&&e.key==_calc.numList.value.length-1?".":""}",
                                        textAlign:  TextAlign.end
                                    );
                                  }
                                }).toList()
                              ],
                            )
                          );
                        })

            ),
            Expanded(
              child: Container(
                color: BpColors.lightGrey,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: ButtonCalc(
                                      text: "7",
                                      color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("7");
                                      },
                                    )
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "8",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("8");
                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "9",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("9");
                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "÷",color: BpColors.secondary,
                                      onPressed: (){
                                        _calc.addOperation(CalcOperator.div);
                                      },)
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: ButtonCalc(text: "4",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("4");

                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "5",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("5");

                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "6",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("6");

                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "-",color: BpColors.secondary,
                                      icon: Icons.close,
                                      onPressed: (){
                                        _calc.addOperation(CalcOperator.mul);
                                      },)
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: ButtonCalc(text: "1",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("1");

                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "2",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("2");

                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "3",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("3");

                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "-",color: BpColors.secondary,
                                      onPressed: (){
                                          _calc.addOperation(CalcOperator.res);
                                      },)
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex:2,
                                    child: ButtonCalc(text: "0",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.changeNumber("0");
                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: ".",color: BpColors.tertiary,
                                      onPressed: (){
                                        _calc.activePunto();
                                      },)
                                ),
                                Expanded(
                                    child: ButtonCalc(text: "+",color: BpColors.secondary,
                                      onPressed: (){
                                        _calc.addOperation(CalcOperator.sum);
                                      },)
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: ButtonCalc(
                                      text: "AC",
                                      color: BpColors.primary,
                                      onPressed: (){
                                        _calc.reset();
                                      },
                                    )
                                ),

                                Expanded(
                                    child: ButtonCalc(text: "<=",color: BpColors.tertiary,
                                      icon: Icons.backspace,
                                      onPressed: (){
                                        _calc.delete();
                                      },)
                                ),
                                Expanded(
                                    flex: 2,
                                    child: ButtonCalc(text: "=",color: BpColors.primary,
                                      onPressed: (){
                                        _calc.result();
                                      },)
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: BpButton(
                                      bpButtonType: BpButtonType.primary,
                                      bpButtonSize: BpButtonSize.medium,
                                      bgColor: const Color(0xff00377C),
                                      text: "Tigo",
                                      onPressed: (){
                                        if(_calc.numList.value.length==1&&_calc.numList.value[0]>0){
                                          Get.toNamed(RoutesKeys.tigoLink,arguments: {"amount":_calc.numList.value[0]} );
                                        }
                                        else{
                                          _calc.result();
                                          if(_calc.numList.value.length==1&&_calc.numList.value[0]>0){
                                            Get.toNamed(RoutesKeys.tigoLink,arguments: {"amount":_calc.numList.value[0]} );
                                          }
                                        }
                                      }
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: BpButton(
                                      bpButtonType: BpButtonType.primary,
                                      bpButtonSize: BpButtonSize.medium,
                                      bgColor: const Color(0xff0FA8D5),
                                      text: "Soli",
                                      onPressed: (){
                                        if(_calc.numList.value.length==1&&_calc.numList.value[0]>0){
                                          Get.toNamed(RoutesKeys.soliLink,arguments: {"amount":_calc.numList.value[0]} );
                                        }
                                        else{
                                          _calc.result();
                                          if(_calc.numList.value.length==1&&_calc.numList.value[0]>0){
                                            Get.toNamed(RoutesKeys.soliLink,arguments: {"amount":_calc.numList.value[0]} );
                                          }
                                        }
                                      }
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: BpButton(
                                      bpButtonType: BpButtonType.secondary,
                                      bpButtonSize: BpButtonSize.medium,
                                      text: "QR",
                                      onPressed: (){
                                        if(_calc.numList.value.length==1&&_calc.numList.value[0]>0){
                                          Get.toNamed(RoutesKeys.qrLink,arguments: {"amount":_calc.numList.value[0]} );
                                        }
                                        else{
                                          _calc.result();
                                          if(_calc.numList.value.length==1&&_calc.numList.value[0]>0){
                                            Get.toNamed(RoutesKeys.qrLink,arguments: {"amount":_calc.numList.value[0]} );
                                          }
                                        }
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget getStringOperator(CalcOperator calcOperator){
    switch (calcOperator){

      case CalcOperator.sum:
        return
          const Text("+",
              style: TextStyle(

                color: BpColors.tertiary,
                fontWeight: FontWeight.w400,
                fontSize: 30,
                height: 0.5,
              ),
              textAlign:  TextAlign.end
          );
      case CalcOperator.res:
        return
          const Text("-",
              style: TextStyle(

                  color: BpColors.tertiary,
                  fontWeight: FontWeight.w400,
                fontSize: 40,
                height: 0.5,
              ),
              textAlign:  TextAlign.end
          );
      case CalcOperator.div:
        return
          const Text("÷",
              style: TextStyle(

                color: BpColors.tertiary,
                fontWeight: FontWeight.w400,
                fontSize: 30,
                height: 0.5,
              ),
              textAlign:  TextAlign.end
          );
      case CalcOperator.mul:
        return const Icon(
          Icons.close,
          color: BpColors.tertiary,
          size: 20,
        );
    }
  }
}

class ButtonCalc extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;
  final VoidCallback onPressed;
  const ButtonCalc({Key? key,required this.text,this.icon,required this.color,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.white.withOpacity(0.5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        elevation: 0,
        child:
            icon!=null?
        Padding(
          padding: const EdgeInsets.all(8),
          child: FittedBox(
            child: Icon(
              icon,
              color: color,
            ),
          ),
        ):
        BpText.autoSize(
            maxLines: 1,
            fontWeight: FontWeight.w400,
            color: color,
            text: text,
            textAlign:  TextAlign.end
        ),
      ),
    );
  }
}

