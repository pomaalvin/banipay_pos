import 'dart:convert';
import 'dart:ui';
import 'package:banipay_pos/domain/qr_controller.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:banipay_pos/ui/widgets/atoms/bp_text.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_button.dart';
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
        child: Stack(
          children: [
            Positioned.fill(
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
                            text: "Cancelar",
                            onPressed: (){
                              Get.offNamedUntil(RoutesKeys.calculatorLink, (route) => false);
                            }
                        )
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () {
                if(qr.status.value==QrStatus.success) {
                  return Positioned.fill(
                    child: BackdropFilter(
                      filter:  ImageFilter.blur(
                          sigmaX: 2,
                          sigmaY: 2
                      ),
                      child: Container(
                          color: Colors.white.withOpacity(0.2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 30,right: 30,top: 30),
                                        child: Material(
                                          elevation: 5,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 40,left: 20,right: 20,bottom: 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                BpText.titleSmall(color: BpColors.tertiary, text: "Éxito"),
                                                const SizedBox(height: 10,),
                                                BpText.body(color: BpColors.tertiary,textAlign: TextAlign.center,maxLines: 4, text: "El pago que se realizó ha sido procesado correctamente.", fontWeight: FontWeight.w400),
                                                const SizedBox(height: 10,),
                                                BpButton(
                                                    bpButtonType: BpButtonType.primary,
                                                    bpButtonSize: BpButtonSize.medium,
                                                    bgColor: Color(0xff0ba31f),
                                                    text: "Aceptar",
                                                    onPressed: (){
                                                      Get.offNamedUntil(RoutesKeys.calculatorLink, (route) => false);
                                                    }
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                  const Positioned(
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Color(0xff0ba31f),
                                        child: FittedBox(child: Icon(Icons.done,color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    ),
                  );
                }
                else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
