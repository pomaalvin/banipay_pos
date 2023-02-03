
import 'package:banipay_pos/ui/pages/calculator_page.dart';
import 'package:banipay_pos/ui/pages/config_page.dart';
import 'package:banipay_pos/ui/pages/general_loading.dart';
import 'package:banipay_pos/ui/pages/login_page.dart';
import 'package:banipay_pos/ui/pages/qr_page.dart';
import 'package:banipay_pos/ui/pages/qr_verify_page.dart';
import 'package:banipay_pos/ui/pages/soli_page.dart';
import 'package:banipay_pos/ui/pages/soli_verify_page.dart';
import 'package:banipay_pos/ui/pages/tigo_money_page.dart';
import 'package:banipay_pos/ui/pages/tigo_money_verify_page.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../pages/list_page.dart';

class Routes {

  static String getOnlyLink(String path){
    List<String> pathList=path.split("?");
    return pathList.first;
  }
  static List<GetPage> routes() {
    return [

      GetPage(
        name: RoutesKeys.splashLink,
        title: RoutesKeys.splash,
        page: () => const GeneralLoading(),
      ),
      GetPage(
          name: RoutesKeys.loginLink,
          title: RoutesKeys.login,
          page: ()=>LoginPage()
      ),
      GetPage(
          name: RoutesKeys.calculatorLink,
          title: RoutesKeys.calculator,
          page: ()=>CalculatorPage()
      ),
      GetPage(
          name: RoutesKeys.listLink,
          title: RoutesKeys.list,
          page: (){
            return ListPage();
          }
      ),
      GetPage(
          name: RoutesKeys.tigoLink,
          title: RoutesKeys.tigo,
          page: (){
            if(Get.arguments!=null){
              return TigoMoneyPage(amountNumber: Get.arguments["amount"],);
            }
            else{
              return const SizedBox.shrink();
            }
    }
      ),
      GetPage(
          name: RoutesKeys.tigoVerifyLink,
          title: RoutesKeys.tigoVerify,
          page: (){
            if(Get.arguments!=null){
              return TigoMoneyVerifyPage(phone: Get.arguments["phone"],);
            }
            else{
              return const SizedBox.shrink();
            }
          }
      ),
      GetPage(
          name: RoutesKeys.soliLink,
          title: RoutesKeys.soli,
          page: () {
            if(Get.arguments!=null){
              return SoliPage(amountNumber: Get.arguments["amount"],);
            }
            else{
              return const SizedBox.shrink();
            }
          }
      ),
      GetPage(
          name: RoutesKeys.soliVerifyLink,
          title: RoutesKeys.soliVerify,
          page: () {
            return SoliVerifyPage();
          }
      ),
      GetPage(
          name: RoutesKeys.configLink,
          title: RoutesKeys.config,
          page: () {
            return ConfigPage();
          }
      ),
      GetPage(
          name: RoutesKeys.qrVerifyLink,
          title: RoutesKeys.qrVerify,
          page: (){
              return QrVerifyPage();
          }
      ),
      GetPage(
          name: RoutesKeys.qrLink,
          title: RoutesKeys.qr,
          page: (){
            if(Get.arguments!=null){
              return QrPage(amountNumber: Get.arguments["amount"],);
            }
            else{
              return const SizedBox.shrink();
            }
          }
      )
    ];
  }
}
