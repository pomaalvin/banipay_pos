

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RepositoryAuth{
  static Future<void> saveNotificationInfo(String idUser)async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    var phoneInformation="";
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      phoneInformation+="Android ${androidInfo.device??""} ${androidInfo.model??""}";
    }
    if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      phoneInformation+="IOS ${iosInfo.name??""} ${iosInfo.model??""}";
    }

    FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;


    print(await firebaseMessaging.getToken());

    var body = {
      "phoneInformation":phoneInformation,
      "token":await firebaseMessaging.getToken(),
      "userId":idUser
    };

    String url = 'https://v2.banipay.me/api/auth/api/notification/create';
    var responseB = await Dio().post(
        url,
        data: body,
        options: Options(responseType: ResponseType.json)
    );
  }
}