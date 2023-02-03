import 'package:banipay_pos/domain/qr_controller.dart';
import 'package:banipay_pos/domain/tigo_controller.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_button.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_input.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrPage extends StatelessWidget {
  final num amountNumber;
  final TextEditingController email=TextEditingController();
  final TextEditingController amount=TextEditingController();
  final TextEditingController nombre=TextEditingController();
  final TextEditingController ci=TextEditingController();
  final TextEditingController telefono=TextEditingController();
  final GlobalKey<FormState> keyForm=GlobalKey<FormState>();
  final qr=Get.put<QrController>(QrController());
  QrPage({Key? key,required this.amountNumber}) : super(key: key);

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
        child: Form(
          key: keyForm,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                BpInput(
                  onChanged: (value){

                  },
                  label: "Monto*",
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "Ingrese el monto";
                    }
                    try{
                      if(num.parse(value)<=0){
                        return "Monto inválido";
                      }
                    }
                    catch(err){
                      return "Monto invalido";
                    }
                    return null;
                  },
                  hint: "",
                  inputType: InputType.number,
                  controller: amount..text=amountNumber.toString(),
                ),
                /*BpInput(
                  onChanged: (value){

                  },
                  label: "Nombre y Apellido",
                  validator: (value){
                    return null;
                  },
                  hint: "",
                  inputType: InputType.normal,
                  controller: nombre,
                ),
                const SizedBox(height: 10,),
                BpInput(
                  onChanged: (value){

                  },
                  validator: (value){
                    if(value!=null&&value.isNotEmpty&&!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)){
                      return "Ingrese un correo válido";
                    }
                    return null;
                  },
                  label: "Email",
                  hint: "",
                  inputType: InputType.email,
                  controller: email,
                ),
                const SizedBox(height: 10,),
                BpInput(
                  onChanged: (value){

                  },
                  label: "CI",
                  validator: (value){
                    return null;
                  },
                  hint: "",
                  inputType: InputType.normal,
                  controller: ci,
                ),
                const SizedBox(height: 10,),
                BpInput(
                  onChanged: (value){

                  },
                  label: "Telefono",
                  validator: (value){
                    return null;
                  },
                  hint: "",
                  inputMaxLength: 8,
                  inputType: InputType.number,
                  controller: telefono,
                ),*/
                const SizedBox(height: 20,),
                Obx(() {
                  return BpButton(
                      bpButtonType: BpButtonType.primary,
                      bgColor: const Color(0xff00377C),
                      loading: qr.status.value==QrStatus.loading,
                      bpButtonSize: BpButtonSize.big,
                      text: "Siguiente",
                      onPressed: (){
                        if(keyForm.currentState?.validate()??false){
                          qr.sendQr(
                              nombre: nombre.value.text,
                              email: email.value.text,
                              ci: ci.value.text,
                              telefono: telefono.value.text,
                              amount: num.parse(amount.value.text)
                          );
                        }
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
