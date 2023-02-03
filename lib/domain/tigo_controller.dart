import 'package:banipay_pos/domain/auth_controller.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
enum TigoStatus{
  loading,init
}
class TigoController extends GetxController{
  final _authController=Get.find<AuthController>();
  final String _tigoUrl="https://v2.banipay.me/api/pagos/payment/tigo/pay";
  final String _tigoVerifyUrl="https://v2.banipay.me/api/pagos/payment/tigo/status";

  var status = TigoStatus.init.obs;
  sendTigo({
    required String nombre,
    required String email,
    required String ci,
    required String telefono,
    required num amount
})async{
    status.value=TigoStatus.loading;
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
      print(_tigoUrl);
      var response = await Dio().post(
          _tigoUrl,
          data: {
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
            "affiliate": _authController.affiliate.value?.id,
            "business": _authController.business.value?.id,
            "commission": 0.0,
            "idPos": _authController.posId
          },
          options: Options(responseType: ResponseType.json)
      );
      print(response.data);
      transaction=response.data["orderNumber"].toString();
      paymentId=response.data["paymentId"].toString();
      status.value=TigoStatus.init;
      Get.toNamed(RoutesKeys.tigoVerifyLink,arguments: {"phone": telefono});
    }
    catch (error){
      print(error);
      status.value=TigoStatus.init;
    }
  }

  var paymentId="";
  var transaction="";

  validatePago()async{
    status.value=TigoStatus.loading;
    var response = await Dio().get(
        "$_tigoVerifyUrl/$paymentId/$transaction",
        options: Options(responseType: ResponseType.json)
    );
    print("$_tigoVerifyUrl/$paymentId/$transaction");
    print(response.data);
    status.value=TigoStatus.init;
    Get.offNamedUntil(RoutesKeys.calculatorLink, (route) => false);
    Get.showSnackbar(const GetSnackBar(title: "Éxito",message: "Transaccion confirmada",isDismissible: true,duration: Duration(seconds: 3)));
  }
}