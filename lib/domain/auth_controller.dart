import 'dart:developer';

import 'package:banipay_pos/domain/models/affiliate.dart';
import 'package:banipay_pos/domain/models/business.dart';
import 'package:banipay_pos/domain/repository_auth.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum AuthStatus{
  auth, noAuth, loading
}
class AuthController extends GetxController{

  Rx<List<Business>> businessList=Rx<List<Business>>([]);
  Rx<Affiliate?> affiliate=Rx<Affiliate?>(null);
  Rx<Business?> business=Rx<Business?>(null);
  String email="";

  String posId="";

  @override
  void onInit() {
    verifyAuth();
    super.onInit();
  }

  final String _loginUrl="https://v2.banipay.me/api/auth/api/authenticate";
  final String _businessUrl="https://v2.banipay.me/api/auth/api/business/user";
   var status = AuthStatus.noAuth.obs;

   verifyAuth()async{
     try{
       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
       posId="${androidInfo.device}_${androidInfo.id}";
       final prefs = await SharedPreferences.getInstance();
       //return prefs.remove('token');
       var token=prefs.getString('token');
       email=prefs.getString('email')??"";
       if(token==null){
         Get.offNamedUntil(RoutesKeys.loginLink, (route) => false);
         return;
       }
       var userId=prefs.getString('userId');
       var responseB = await Dio().get(
           "$_businessUrl/$userId",
           options: Options(responseType: ResponseType.json)
       );
       if(responseB.data.length>0){
         businessList.value=List.from(responseB.data.map((e)=>Business.fromJson(e)));
         var businessAux=prefs.getString('businessId');
         var affiliateId=prefs.getString('affiliateId');

         if(businessList.value.isNotEmpty){
           business.value=businessList.value.firstWhere((element) => element.id==businessAux,orElse: ()=>businessList.value.first);
           if(business.value!=null&&business.value!.affiliates.isNotEmpty){
             affiliate.value=business.value!.affiliates.firstWhere((element) => element.id==affiliateId,orElse: ()=>business.value!.affiliates.first);
           }
         }
         status.value=AuthStatus.auth;
         Get.offNamedUntil(RoutesKeys.calculatorLink, (route) => false);
       }
       else{
         status.value=AuthStatus.noAuth;
       }
     }
     on DioError catch (err){
       Get.showSnackbar(GetSnackBar(title: "Error",message: err.response?.data.toString(),isDismissible: true,duration: Duration(seconds: 3)));
       Get.offNamedUntil(RoutesKeys.loginLink, (route) => false);
     }
     catch(err){
       Get.showSnackbar(GetSnackBar(title: "Error",message: err.toString(),isDismissible: true,duration: Duration(seconds: 3)));
        Get.offNamedUntil(RoutesKeys.loginLink, (route) => false);
     }


   }

   logout({bool redirect=true})async{

     final prefs = await SharedPreferences.getInstance();
     await prefs.remove('token');
     await prefs.remove('userId');
     await prefs.remove('businessId');
     status.value=AuthStatus.noAuth;
     if(redirect){
       Get.offNamedUntil(RoutesKeys.loginLink, (route) => false);
     }
   }

   login(String email, String password)async{
       try{
         status.value=AuthStatus.loading;
         var response = await Dio().post(
             _loginUrl,
             data: {
               "email": email.trim(),
               "password": password.trim(),
               "rememberMe": true
             },
             options: Options(responseType: ResponseType.json)
         );
         print(response.data);
         await RepositoryAuth.saveNotificationInfo(response.data["user"]["id"]);
         if(response.data["id_token"]!=null){
           final prefs = await SharedPreferences.getInstance();
           await prefs.setString('token', response.data["id_token"]);
           await prefs.setString('email', email);
           email=email;
           await prefs.setString('userId', response.data["user"]["id"]);
           var userId=response.data["user"]["id"];
           var responseB = await Dio().get(
               "$_businessUrl/$userId",
               options: Options(responseType: ResponseType.json)
           );
           if(responseB.data.length>0){
             businessList.value=List.from(responseB.data.map((e)=>Business.fromJson(e)));
             if(businessList.value.isNotEmpty){

               if(businessList.value.first.affiliates.isNotEmpty){
                 affiliate.value=businessList.value.first.affiliates.first;
                 await prefs.setString('affiliateId', affiliate.value?.id??"");
               }
               business.value=businessList.value.first;
               await prefs.setString('businessId', business.value?.id??"");
             }
             status.value=AuthStatus.auth;
             Get.offNamedUntil(RoutesKeys.calculatorLink, (route) => false);
           }
           else{
             status.value=AuthStatus.noAuth;
           }
         }
         else{
           status.value=AuthStatus.noAuth;
         }
       }
       on DioError catch (err){
         if(err.response?.data["status"]==401){
           Get.showSnackbar(const GetSnackBar(title: "Error",message: "Correo o contraseña incorrectos",isDismissible: true,duration: Duration(seconds: 3)));
         }
         else{
           Get.showSnackbar(GetSnackBar(title: "Error",message: err.response?.data.toString(),isDismissible: true,duration: Duration(seconds: 3)));
         }
         log(err.response?.data.toString()??"");
         logout(redirect: false);
       }
       catch(err){
         log(err.toString());
         logout(redirect: false);
       }
   }

   changeBusiness(Business? newValue)async{
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString('businessId', newValue?.id??"");
     business.value=newValue;
     affiliate.value=null;
   }
  changeAffiliate(Affiliate? newValue)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('affiliateId', newValue?.id??"");
    affiliate.value=newValue;
  }



}