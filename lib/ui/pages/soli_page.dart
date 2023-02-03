import 'package:banipay_pos/domain/soli_controller.dart';
import 'package:banipay_pos/ui/widgets/atoms/bp_text.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_button.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_input.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoliPage extends StatelessWidget {
  final num amountNumber;
  final TextEditingController email=TextEditingController();
  final TextEditingController amount=TextEditingController();
  final TextEditingController nombre=TextEditingController();
  final TextEditingController ci=TextEditingController();
  final TextEditingController telefono=TextEditingController();
  final GlobalKey<FormState> keyForm=GlobalKey<FormState>();
  final soli=Get.put<SoliController>(SoliController());
  SoliPage({Key? key,required this.amountNumber}) : super(key: key);

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
                /*const SizedBox(height: 10,),
                BpInput(
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
                ),*/
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Expanded(
                     child:  BpInput(
                       onChanged: (value){

                       },
                       label: "CI*",
                       validator: (value){
                         if(value==null||value.isEmpty){
                           return "Ingrese el CI";
                         }
                         return null;
                       },
                       hint: "",
                       inputType: InputType.normal,
                       controller: ci,
                     ),
                   ),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: 100,
                      child: Obx(() {
                          return Column(
                            children: [
                              BpText.label(color: BpColors.tertiary, text: "Ext", fontWeight: FontWeight.w600),
                              const SizedBox(height: 4,),
                              Container(
                                height: 43,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                                ),

                                child: DropdownButton(
                                  dropdownColor: Colors.white,
                                  isDense: true,
                                  alignment: Alignment.center,
                                  underline:  const SizedBox.shrink(),
                                  isExpanded: true,

                                  // Down Arrow Icon
                                  value: soli.ciExt.value,
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: ["LP","CB","SC","CH","OR","PT","TJ","BE","PD"].map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    soli.ciExt.value=newValue??"LP";
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                BpInput(
                  onChanged: (value){

                  },
                  label: "Telefono*",
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "Ingrese un telefono";
                    }
                    return null;
                  },
                  hint: "",
                  inputMaxLength: 8,
                  inputType: InputType.number,
                  controller: telefono,
                ),
                const SizedBox(height: 20,),
                Obx(() {
                  return BpButton(
                      bpButtonType: BpButtonType.primary,
                      bgColor: const Color(0xff00377C),
                      loading: soli.status.value==SoliStatus.loading,
                      bpButtonSize: BpButtonSize.big,
                      text: "Siguiente",
                      onPressed: (){
                        if(keyForm.currentState?.validate()??false){
                          soli.sendSoli(
                              nombre: nombre.value.text,
                              email: email.value.text,
                              ci: ci.value.text,
                              telefono: telefono.value.text,
                              amount: num.parse(amount.value.text),
                              ciExt: soli.ciExt.value
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
