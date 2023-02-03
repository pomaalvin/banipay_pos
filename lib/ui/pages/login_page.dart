import 'package:banipay_pos/domain/auth_controller.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_button.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_input.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final GlobalKey<FormState> keyForm=GlobalKey<FormState>();
  final auth=Get.find<AuthController>();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BpColors.lightGrey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: keyForm,
          child: Column(
            children: [
              const SizedBox(height: 100,),
              Image.asset(
                  "assets/banipay_logo.png",
                height: 70,
              ),
              const SizedBox(height: 50,),
              BpInput(
                onChanged: (value){

                },
                label: "Correo Electrónico",
                validator: (value){
                  if(value==null||value.isEmpty){
                    return "Ingrese el correo";
                  }
                  if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)){
                    return "Ingrese un correo válido";
                  }
                  return null;
                  },
                hint: "",
                inputType: InputType.email,
                controller: email,
              ),
              const SizedBox(height: 10,),
              BpInput(
                onChanged: (value){

                },
                validator: (value){
                  if(value==null||value.isEmpty){
                    return "Ingrese la contraseña";
                  }
                  return null;
                },
                label: "Contraseña",
                hint: "",
                inputType: InputType.password,
                controller: password,
              ),
              const SizedBox(height: 20,),
              Obx(() {
                return BpButton(
                    bpButtonType: BpButtonType.primary,
                    bpButtonSize: BpButtonSize.big,
                    loading: auth.status.value==AuthStatus.loading,
                    text: "Iniciar Sesion",
                    onPressed: (){
                      if(keyForm.currentState?.validate()??false){
                        auth.login(email.value.text, password.value.text);
                      }
                    }
                );
              },)
            ],
          ),
        ),
      )
    );
  }
}
