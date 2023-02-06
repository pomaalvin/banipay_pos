import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
enum ItemNavActive{cal,lis,set}
class BpBottomNav extends StatelessWidget {
  final ItemNavActive itemNavActive;
  final bool lock;
  const BpBottomNav({Key? key,this.lock=false,required this.itemNavActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: _BpNavItem(
              icon: Icons.list_alt,
              active: itemNavActive==ItemNavActive.lis,
              onPressed: lock?(){}:(){
                Get.toNamed(RoutesKeys.listLink);
              },
            ),
          ),
          Expanded(
            child: _BpNavItem(
              icon: Icons.calculate,
              active: itemNavActive==ItemNavActive.cal,
              onPressed: lock?(){}:(){
                Get.toNamed(RoutesKeys.calculatorLink);
              },
            ),
          ),
          Expanded(
            child: _BpNavItem(
              icon: Icons.settings,
              active: itemNavActive==ItemNavActive.set,
              onPressed: lock?(){}:(){
                Get.offNamedUntil(RoutesKeys.configLink, (route) => false);
              },
            ),
          )
        ],
      ),
    );
  }
}
class _BpNavItem extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onPressed;
  const _BpNavItem({Key? key,required this.icon,required this.active,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Icon(
          icon,
          color: active?BpColors.secondary:BpColors.tertiary,
          size: 30,
        ),
      ),
    );
  }
}

