import 'package:banipay_pos/domain/list_controller.dart';
import 'package:banipay_pos/ui/widgets/atoms/bp_text.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_button.dart';
import 'package:banipay_pos/ui/widgets/molecules/bp_input.dart';
import 'package:banipay_pos/ui/widgets/organism/bp_bottom_nav.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPage extends StatelessWidget {


  final listController=Get.put<ListController>(ListController());
  ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BpColors.lightGrey,
        bottomNavigationBar: const BpBottomNav(itemNavActive: ItemNavActive.lis),
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: BpInput(
                      onChanged: (value){
                        listController.search(search: value??"");
                      },
                      validator: (value){
                        return null;
                      },
                      hint: "Buscar transaccion",
                      inputType: InputType.normal,
                      controller: listController.searchInput
                  ),
                ),
                Obx(
                  () {
                    if(listController.searchStatus.value)
                      {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: BpButton(
                              dense: true,
                              bpButtonType: BpButtonType.primary,
                              bpButtonSize: BpButtonSize.medium,
                              text: "",
                              icon: Icons.close,
                              onPressed: (){
                                listController.search(search: "");
                              }
                          ),
                        );
                      }
                    else{
                      return const SizedBox.shrink();
                    }
                  },
                )
              ],
            )
          ),
          Divider(color: BpColors.tertiary.withOpacity(0.1),),

          Obx(
            () {
              return Expanded(
                child:
                listController.listStatus.value==ListStatus.success?
                Obx(
                  () {
                    return RefreshIndicator(
                      onRefresh: ()async{
                        await Future.delayed(const Duration(seconds: 1));
                        listController.getList();
                      },
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(color: BpColors.tertiary.withOpacity(0.1),);
                        },
                        itemCount: listController.listTransactionsSearch.value.length,
                        itemBuilder: (context,index){
                          return ListTile(
                            title: BpText.subtitle(color: BpColors.primary, text: listController.listTransactionsSearch.value[index].nameOrSocialReason),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BpText.body(color: BpColors.tertiary.withOpacity(0.5), text: listController.listTransactionsSearch.value[index].paymentMethod,fontWeight: FontWeight.w600),
                                BpText.body(color: BpColors.tertiary, text: listController.listTransactionsSearch.value[index].paymentDate.toStringTime(),fontWeight: FontWeight.w500),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BpText.body(color: BpColors.tertiary, text: listController.listTransactionsSearch.value[index].paymentAmount.toStringAsFixed(2),fontWeight: FontWeight.w600),
                                BpText.label(color: BpColors.tertiary.withOpacity(0.8), text: listController.listTransactionsSearch.value[index].paymentStatus,fontWeight: FontWeight.w600),
                              ],
                            )
                          );
                        },
                      ),
                    );
                  }
                ):const Center(
                  child: CircularProgressIndicator(
                    color: BpColors.primary,
                  )
              ),
              );
            }
          )

        ],
      )
      )
    );
  }

}

extension TimeExtension on DateTime{
  String toStringTime() {
    return "${day.toString().padLeft(2,"0")}-${month.toString().padLeft(2,"0")}-$year ${hour.toString().padLeft(2,"0")}:${minute.toString().padLeft(2,"0")}";
  }
}
