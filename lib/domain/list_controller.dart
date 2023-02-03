import 'package:banipay_pos/domain/auth_controller.dart';
import 'package:banipay_pos/domain/models/movement.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum ListStatus{init,loading,success}
class ListController extends GetxController{

  final searchInput=TextEditingController();
  final _authController=Get.find<AuthController>();
  final String _pagosUrl="https://v2.banipay.me/api/pagos/payment/idPos/payment";
  var listTransactions=Rx<List<Movement>>([]);
  var listTransactionsSearch=Rx<List<Movement>>([]);
  var listStatus=Rx<ListStatus>(ListStatus.init);

  var searchStatus= Rx<bool>(false);
  @override
  void onInit() {
    getList();
    super.onInit();
  }

  getList()async{
    try{

      listStatus.value=ListStatus.loading;
      print("$_pagosUrl/${_authController.posId}/${_authController.affiliate.value?.id}");
      var response = await Dio().get(
          "$_pagosUrl/${_authController.posId}/${_authController.affiliate.value?.id}",
          options: Options(responseType: ResponseType.json)
      );
      listTransactions.value=
          List.from(response.data.map((e)=>Movement.fromJson(e)));
      listTransactionsSearch.value=
          List.from(response.data.map((e)=>Movement.fromJson(e)));
      listStatus.value=ListStatus.success;
    }
    catch(error){
      listStatus.value=ListStatus.init;
    }
  }


  search({required String search})async{

    if(search.isEmpty){
      searchInput.text="";
      searchStatus.value=false;
      listTransactionsSearch.value=listTransactions.value;
      return;
    }
    searchStatus.value=true;

      listTransactionsSearch.value=List.from(listTransactions.value.where((element) {
        return element.paymentStatus.toLowerCase().startsWith(search.toLowerCase())
          || element.nameOrSocialReason.toLowerCase().startsWith(search.toLowerCase())
            || element.paymentMethod.toLowerCase().startsWith(search.toLowerCase())
            || element.paymentAmount.toString().toLowerCase().startsWith(search.toLowerCase());
      }));
  }
}