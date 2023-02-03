import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';

class GeneralLoading extends StatelessWidget {
  const GeneralLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: BpColors.tertiary,
      body: Center(
        child: CircularProgressIndicator(
          color: BpColors.secondary,
        ),
      ),
    );
  }
}
