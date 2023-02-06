import 'dart:developer';

import 'package:banipay_pos/domain/auth_controller.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

enum SoliStatus{
  loading,init
}
class SoliController extends GetxController{
  final _authController=Get.find<AuthController>();
  final String _soliUrl="https://v2.banipay.me/api/pagos/payment/soli";
  final String _soliVerifyUrl="https://v2.banipay.me/api/pagos/payment/soli/confirm";

  Map<String,dynamic> soliSend={};


  Rx<String> ciExt=Rx<String>("LP");

  var status = SoliStatus.init.obs;
  sendSoli({
    required String nombre,
    required String email,
    required String ci,
    required String ciExt,
    required String telefono,
    required num amount
})async{
    status.value=SoliStatus.loading;
    /*print(
        {
          "paymentId": 0,
          "nit": "0",
          "firstname": nombre.isNotEmpty?nombre:"S/N",
          "lastname": "",
          "email": email.isNotEmpty?email:"default@gmail.com",
          "country": "BO",
          "city": "La Paz ",
          "address": "La Paz",
          "administrativeArea": "L",
          "phoneNumber": telefono,
          "postalCode": "0000",
          "currency": "BOB",
          "amount": amount,
          "description": "",
          "affiliate": _authController.affiliateId.value,
          "business": _authController.businessId.value,
          "commission": 0.0
        }
    );
    return;*/
    try{
      print(_soliUrl);
      ci=ci.toLowerCase();
      var ciCom = ci.replaceAll(RegExp(r'[^a-z]'),'');
      var ciNum = ci.replaceAll(RegExp(r'[^0-9]'),'');
      var response = await Dio().post(
          _soliUrl,
          data: {
            "currency": "BOB",
            "amount": amount,
            "gloss": "Pago Soli",
            "soliNumber": telefono,
            "business" : _authController.business.value?.id,
            "affiliate" : _authController.affiliate.value?.id,
            "ci": ciNum,
            "extension": ciExt,
            "complement": ciCom,
            "firstname": nombre,
            "lastname": "",
            "email": email.isNotEmpty?email:"example@gmail.com",
            "country": _authController.affiliate.value?.country,
            "city": _authController.affiliate.value?.city,
            "address": _authController.affiliate.value?.address,
            "idPos": _authController.posId
          },
          options: Options(responseType: ResponseType.json)
      );
      soliSend=response.data;
      status.value=SoliStatus.init;
      print(response.data);
      Get.toNamed(RoutesKeys.soliVerifyLink);
    }
    on DioError catch (err){
      Get.showSnackbar(GetSnackBar(title: "Error",message: err.response?.data.toString(),isDismissible: true,duration: Duration(seconds: 3)));
      status.value=SoliStatus.init;
    }
    catch (error){
      Get.showSnackbar(GetSnackBar(title: "Error",message: error.toString(),isDismissible: true,duration: Duration(seconds: 3)));

      status.value=SoliStatus.init;
    }
  }
  verifySoli({
    required String code
  })async{
    status.value=SoliStatus.loading;
    /*print(
        {
          "paymentId": 0,
          "nit": "0",
          "firstname": nombre.isNotEmpty?nombre:"S/N",
          "lastname": "",
          "email": email.isNotEmpty?email:"default@gmail.com",
          "country": "BO",
          "city": "La Paz ",
          "address": "La Paz",
          "administrativeArea": "L",
          "phoneNumber": telefono,
          "postalCode": "0000",
          "currency": "BOB",
          "amount": amount,
          "description": "",
          "affiliate": _authController.affiliateId.value,
          "business": _authController.businessId.value,
          "commission": 0.0
        }
    );
    return;*/
    try{
      soliSend.addAll({
        "otp": code,
        "administrativeArea": "L",
        "idPos": _authController.posId
      });
      print(_soliVerifyUrl);
      var response = await Dio().post(
          _soliVerifyUrl,
          data: soliSend,
          options: Options(responseType: ResponseType.json)
      );
      print(response);
      if(response.data["message"]=="COMPLETADO"){
        Get.offNamedUntil(RoutesKeys.calculatorLink, (route) => false);
        Get.showSnackbar(const GetSnackBar(title: "Éxito",message: "Se completó el pago",isDismissible: true,duration: Duration(seconds: 3),));
      }
      else{
        Get.showSnackbar(GetSnackBar(title: "Error",message: response.data["message"],isDismissible: true,duration: Duration(seconds: 3)));
      }
      status.value=SoliStatus.init;
    }
    on DioError catch (err){
      Get.showSnackbar(GetSnackBar(title: "Error",message: err.response?.data.toString(),isDismissible: true,duration: Duration(seconds: 3)));
      status.value=SoliStatus.init;
    }
    catch (error){
      Get.showSnackbar(GetSnackBar(title: "Error",message: error.toString(),isDismissible: true,duration: Duration(seconds: 3)));
      log(error.toString());
      status.value=SoliStatus.init;
    }
  }
}