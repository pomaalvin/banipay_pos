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
      listTransactions.value.sort((a, b) {
        return b.paymentDate.compareTo(a.paymentDate);
      },);
      listTransactionsSearch.value=
          List.from(response.data.map((e)=>Movement.fromJson(e)));
      listTransactionsSearch.value.sort((a, b) {
        return b.paymentDate.compareTo(a.paymentDate);
      },);
      listStatus.value=ListStatus.success;
    }
    on DioError catch (err){
      Get.showSnackbar(GetSnackBar(title: "Error",message: err.response?.data.toString(),isDismissible: true,duration: Duration(seconds: 3)));
      listStatus.value=ListStatus.init;
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
        return element.paymentStatus.toLowerCase().contains(search.toLowerCase())
          || element.nameOrSocialReason.toLowerCase().contains(search.toLowerCase())
            || element.paymentMethod.toLowerCase().contains(search.toLowerCase())
            || element.paymentAmount.toString().toLowerCase().contains(search.toLowerCase());
      }));
  }
}