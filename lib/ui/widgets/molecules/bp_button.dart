import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';

enum BpButtonType {
  primary,
  secondary,
  tertiary,

}

enum BpButtonSize {
  big,
  medium,
  small,
}

class BpButton extends StatelessWidget {
  final BpButtonSize bpButtonSize;
  final BpButtonType bpButtonType;
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final IconData? icon;
  final int maxLines;
  final Color? bgColor;
  final bool dense;
  const BpButton(
      {Key? key,
      required this.bpButtonType,
      required this.bpButtonSize,
      required this.text,
        this.bgColor,
      this.maxLines=1,
      this.loading=false,
        this.dense=false,
        this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: dense?0:90,minHeight: _selectMinHeight(bpButtonSize)),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_selectRadius(bpButtonSize)),
          side: BorderSide(color: _selectColorBorder(bpButtonType), width: 2)
        ),
        color: bgColor ?? _selectColor(bpButtonType),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_selectRadius(bpButtonSize)),
          ),
          onTap: loading?(){}:(){
            FocusManager.instance.primaryFocus?.unfocus();
            onPressed();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: _selectPaddingX(bpButtonSize)),
            child:
            Stack(
              children: [
                AnimatedOpacity(
                  opacity: loading?0:1,
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(icon!=null)
                        Padding(
                          padding: EdgeInsets.only(right: text.isNotEmpty?5:0),
                          child: Icon(icon,
                              size: _selectFontSize(bpButtonSize),
                              color: _selectColorText(bpButtonType))),

                      if(text.isNotEmpty)
                      Flexible(
                        child: Text(
                          text,
                          maxLines: maxLines,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: _selectFontWeight(bpButtonSize),
                              fontSize: _selectFontSize(bpButtonSize),
                              height: 1,
                              leadingDistribution: TextLeadingDistribution.even,
                              color: _selectColorText(bpButtonType)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if(loading)
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: _selectLoadingSize(bpButtonSize),
                          width: _selectLoadingSize(bpButtonSize),
                          child: CircularProgressIndicator(
                            strokeWidth:2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                _selectColorText(bpButtonType)),
                          ),
                        ),
                      ],
                    ),
                  )

              ],
            ),
          ),
        ),
      ),
    );
  }


  double _selectIconSize(BpButtonSize bpButtonSize){
    switch(bpButtonSize){

      case BpButtonSize.big:
        return 18;
      case BpButtonSize.medium:
        return 16;
      case BpButtonSize.small:
        return 20;
    }

  }

  double _selectLoadingSize(BpButtonSize bpButtonSize){
    switch(bpButtonSize){

      case BpButtonSize.big:
        return 18;
      case BpButtonSize.medium:
        return 16;
      case BpButtonSize.small:
        return 12;
    }
  }

  Color _selectColorText(BpButtonType bpButtonType) {
    switch (bpButtonType) {
      case BpButtonType.primary:
        return Colors.white;
      case BpButtonType.secondary:
        return Colors.white;
      case BpButtonType.tertiary:
        return Colors.white;
    }
  }

  Color _selectColorBorder(BpButtonType bpButtonType) {
    switch (bpButtonType) {
      case BpButtonType.primary:
        return Colors.transparent;
      case BpButtonType.secondary:
        return Colors.transparent;
      case BpButtonType.tertiary:
        return Colors.transparent;
    }
  }

  Color _selectColor(BpButtonType bpButtonType) {
    switch (bpButtonType) {
      case BpButtonType.primary:
        return BpColors.primary;
      case BpButtonType.secondary:
        return BpColors.secondary;
      case BpButtonType.tertiary:
        return BpColors.tertiary;
      default:
        return Colors.transparent;
    }
  }

  double _selectPaddingX(BpButtonSize bpButtonSize) {
    switch (bpButtonSize) {
      case BpButtonSize.big:
        return 24;
      case BpButtonSize.medium:
        return 16;
      case BpButtonSize.small:
        return 12;
    }
  }

  double _selectMinHeight(BpButtonSize bpButtonSize){

    switch (bpButtonSize) {
      case BpButtonSize.big:
        return 50;
      case BpButtonSize.medium:
        return 40;
      case BpButtonSize.small:
        return 30;
    }
  }

  double _selectRadius(BpButtonSize bpButtonSize) {
    switch (bpButtonSize) {
      case BpButtonSize.big:
        return 8;
      case BpButtonSize.medium:
        return 8;
      case BpButtonSize.small:
        return 16;
    }
  }

  double _selectFontSize(BpButtonSize bpButtonSize) {
    switch (bpButtonSize) {
      case BpButtonSize.big:
        return 20;
      case BpButtonSize.medium:
        return 14;
      case BpButtonSize.small:
        return 14;
    }
  }

  FontWeight _selectFontWeight(BpButtonSize bpButtonSize) {
    switch (bpButtonSize) {
      case BpButtonSize.big:
        return FontWeight.bold;
      case BpButtonSize.medium:
        return FontWeight.w600;
      case BpButtonSize.small:
        return FontWeight.w600;
    }
  }
}
