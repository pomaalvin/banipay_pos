import 'package:banipay_pos/domain/soli_controller.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_button.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_input.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoliVerifyPage extends StatelessWidget {
  final TextEditingController code=TextEditingController();
  final soli=Get.find<SoliController>();
  SoliVerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BpColors.lightGrey,
      appBar: AppBar(
        centerTitle: true,

        title:
        Image.asset(
          "assets/soli_logo.jpeg",
          height: 50,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                BpInput(
                  onChanged: (value){

                  },
                  label: "Codigo",
                  validator: (value){
                    if(value==null||value.length<4){
                      return "Código no válido";
                    }
                    return null;
                  },
                  hint: "XXXX",
                  inputType: InputType.number,
                  controller: code,
                ),
                const SizedBox(height: 20,),
                Obx(() {
                  return BpButton(
                      bpButtonType: BpButtonType.primary,
                      bpButtonSize: BpButtonSize.big,
                      loading: soli.status.value==SoliStatus.loading,
                      text: "Verificar",
                      onPressed: (){
                        soli.verifySoli(code: code.value.text);
                      }
                  );
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
