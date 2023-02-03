import 'package:banipay_pos/domain/tigo_controller.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_button.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_input.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TigoMoneyVerifyPage extends StatelessWidget {
  final String phone;
  final tigo=Get.find<TigoController>();
  TigoMoneyVerifyPage({Key? key,required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BpColors.lightGrey,
      appBar: AppBar(
        centerTitle: true,

        title:
        Image.asset(
          "assets/tigo_logo.png",
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
                  readOnly: true,
                  label: "Telefono",
                  validator: (value){
                    return null;
                  },
                  hint: "",
                  inputType: InputType.number,
                  controller: TextEditingController()..text=phone,
                ),
                const SizedBox(height: 20,),
                Obx(() {
                  return BpButton(
                      bpButtonType: BpButtonType.primary,
                      loading: tigo.status.value==TigoStatus.loading,
                      bpButtonSize: BpButtonSize.big,
                      text: "Terminar Pago",
                      onPressed: (){
                        tigo.validatePago();
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
