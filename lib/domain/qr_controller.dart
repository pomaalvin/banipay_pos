import 'dart:async';
import 'dart:developer';

import 'package:banipay_pos/domain/auth_controller.dart';
import 'package:banipay_pos/domain/models/qr_response.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
enum QrStatus{
  loading,init,success,waiting
}
class QrController extends GetxController{
  final _authController=Get.find<AuthController>();
  final String _qrUrl="https://v2.banipay.me/api/pagos/qr-payment";

  Rx<QrResponse?> qrResponse=Rx<QrResponse?>(null);
  StreamSubscription? notification;

  @override
  void onInit() {
    print("hola");
    checkNotifications();
    super.onInit();
  }
  @override
  void dispose(){
    if(notification!=null){
      notification!.cancel();
    }
    super.dispose();

    
  }

  checkNotifications() {
    notification=FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(message.data.toString());
      log(message.data["idPos"]);
      if(message.data["idPos"]==_authController.posId){
        status.value=QrStatus.success;
      }
    },onError: (error){
      print(error);
    },onDone: (){
      print("done");
    },cancelOnError: false);
  }
  var status = QrStatus.init.obs;
  sendQr({
    required String nombre,
    required String email,
    required String ci,
    required String telefono,
    required num amount
})async{
    status.value=QrStatus.loading;
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
      print({
        "paymentId": 1259,
        "nit": "0",
        "firstname": nombre.isNotEmpty?nombre:"S/N",
        "lastname": "",
        "email": email.isNotEmpty?email:"default@gmail.com",
        "country": _authController.affiliate.value?.country,
        "city": _authController.affiliate.value?.city,
        "address": _authController.affiliate.value?.address,
        "administrativeArea": "L",
        "phoneNumber": telefono.isNotEmpty?telefono:"77712345",
        "postalCode": "0000",
        "currency": "BOB",
        "amount": amount,
        "description": "",
        "affiliate": _authController.affiliate.value?.id,
        "business": _authController.business.value?.id,
        "gloss": "Pago por QR",
        "singleUse": "true",
        "expiration": "1/00:00",
        "commission": 0.0,
        "idPos": ""
      });
      print({
        {
          "affiliate": _authController.affiliate.value?.id,
          "amount": amount,
          "business": _authController.business.value?.id,
          "code": _authController.posId,
          "currency": "BOB",
          "expiration": "2/00:00",
          "gloss": "POS-${_authController.posId}",
          "idCommercial": _authController.affiliate.value?.idCommercial,
          "paymentId": "v2-ff6a4c4f-e3ed-4a1f-9e4b-b1e63dadc734",
          "singleUse": "true",
          "type": "Banipay"
        }
      });
      var response = await Dio().post(
          _qrUrl,
          data: {
            "affiliate": _authController.affiliate.value?.id,
            "amount": amount,
            "business": _authController.business.value?.id,
            "code": _authController.posId,
            "currency": "BOB",
            "expiration": "1/00:00",
            "gloss": "POS-${_authController.posId}",
            "idCommercial": _authController.affiliate.value?.idCommercial,
            "paymentId": "v2-${const Uuid().v4()}",
            "singleUse": "true",
            "type": "Banipay"
          },
          options: Options(responseType: ResponseType.json)
      );
      print(response.data);
      qrResponse.value=QrResponse.fromJson(response.data);
      status.value=QrStatus.waiting;
      Get.toNamed(RoutesKeys.qrVerifyLink);
    }
    on DioError catch (error){
      log(error.toString());
      Get.showSnackbar(GetSnackBar(title: "Error",message: error.response?.data.toString(),isDismissible: true,duration: Duration(seconds: 3)));

    status.value=QrStatus.init;
    }
    catch(error){
      Get.showSnackbar(GetSnackBar(title: "Error",message: error.toString(),isDismissible: true,duration: Duration(seconds: 3)));
      print(error.toString());
      status.value=QrStatus.init;
    }
  }
}