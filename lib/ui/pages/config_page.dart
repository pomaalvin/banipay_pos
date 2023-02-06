import 'package:banipay_pos/domain/auth_controller.dart';
import 'package:banipay_pos/domain/models/affiliate.dart';
import 'package:banipay_pos/domain/models/business.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:banipay_pos/ui/widgets/atoms/bp_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/organism/bp_bottom_nav.dart';
import '../widgets/tokens/bp_colors.dart';

class ConfigPage extends StatelessWidget {
  final _auth=Get.find<AuthController>();
  ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          backgroundColor: BpColors.lightGrey,
          bottomNavigationBar: BpBottomNav(itemNavActive: ItemNavActive.set,lock: _auth.affiliate.value==null||_auth.business.value==null,),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: BpColors.primary,
                        child: FittedBox(
                          child: Icon(
                              Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ]
                  ),
                  const SizedBox(height: 10,),
                  SelectableText(
                      _auth.email,
                    style:
                    BpText.subtitle(color: BpColors.tertiary, text: _auth.email).style,
                  ),
                  const SizedBox(height: 30,),
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BpText.label(color: BpColors.tertiary, text: "Empresa", fontWeight: FontWeight.w600),
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
                            value: _auth.business.value,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: _auth.businessList.value.map((Business item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (var newValue){
                              _auth.changeBusiness(newValue);
                              }
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 10,),
                  Obx(() {
                      if(_auth.business.value==null){
                        return const SizedBox.shrink();
                      }
                      return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BpText.label(color: BpColors.tertiary, text: "Sucursal", fontWeight: FontWeight.w600),
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

                              value: _auth.affiliate.value,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: _auth.business.value!.affiliates.map((Affiliate item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item.name),
                                );
                              }).toList(),
                              onChanged: (var newValue) {
                                _auth.changeAffiliate(newValue);
                              }
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 15,),
                  BpText.label(color: BpColors.tertiary, text: "POS ID: ", fontWeight: FontWeight.w400),
                  BpText.body(color: BpColors.tertiary, text: _auth.posId, fontWeight: FontWeight.w600),
                  const SizedBox(height: 30,),

                  InkWell(
                    onTap: (){
                      _auth.logout();
                    },
                    child: BpText.body(color: BpColors.secondary, text: "CERRAR SESION", fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),

        );
      }
    );
  }
}
