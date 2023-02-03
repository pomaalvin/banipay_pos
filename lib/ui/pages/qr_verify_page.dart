import 'dart:convert';

import 'package:banipay_pos/domain/qr_controller.dart';
import 'package:banipay_pos/domain/tigo_controller.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:banipay_pos/ui/widgets/atoms/bp_text.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_button.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_input.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrVerifyPage extends StatelessWidget {
  final qr=Get.find<QrController>();
  QrVerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BpColors.lightGrey,
      appBar: AppBar(
        centerTitle: true,

        title:
        Image.asset(
          "assets/qr_logo.png",
          height: 50,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.memory(
                      base64Decode(qr.qrResponse.value?.image??""),
                      width: 250,
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                BpText.body(color: BpColors.tertiary, text: "Referencia: ${qr.qrResponse.value?.code}",fontWeight: FontWeight.w600),
                BpText.body(color: BpColors.tertiary, text: "${qr.qrResponse.value?.currency} ${qr.qrResponse.value?.amount}",fontWeight: FontWeight.w600),
                const SizedBox(height: 20,),

                Obx(() {
                  return BpText.subtitle(color: qr.status.value==QrStatus.waiting?BpColors.tertiary:BpColors.secondary, text: qr.status.value==QrStatus.waiting?"PROCESANDO...":"PROCESADO",textAlign: TextAlign.center);
                },),
                const SizedBox(height: 20,),
                BpButton(
                      bpButtonType: BpButtonType.primary,
                      bpButtonSize: BpButtonSize.big,
                      text: "Terminar Pago",
                      onPressed: (){
                        Get.offNamedUntil(RoutesKeys.calculatorLink, (route) => false);
                      }
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
