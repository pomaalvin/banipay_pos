import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BpText{
  BpText._();

  static AutoSizeText autoSize({required Color color, required String text,required int maxLines,TextAlign? textAlign,required FontWeight fontWeight}){
    return AutoSizeText(
      text,
      style: TextStyle(
          fontSize: 100,
          color: color,
          fontWeight: fontWeight
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: 35,
      minFontSize: 1,
    );
  }
  static Text body({required Color color,required String text,int? maxLines,TextAlign? textAlign,required FontWeight fontWeight}){
    return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style:TextStyle(
          color: color,
          fontSize: 15.0,
          height: 1.5,
          leadingDistribution: TextLeadingDistribution.even,
          overflow: TextOverflow.ellipsis,
          fontWeight: fontWeight,
        )
    );
  }

  static Text title({required Color color,required String text,int? maxLines,TextAlign? textAlign}){
    return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style:TextStyle(
          color: color,
          fontSize: 30,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600,
        )
    );
  }
  static Text titleSmall({required Color color,required String text,int? maxLines,TextAlign? textAlign}){
    return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style:TextStyle(
          color: color,
          fontSize: 22,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600,
        )
    );
  }

  static Text subtitle({required Color color,required String text,int? maxLines,TextAlign? textAlign}){
    return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style:TextStyle(
          color: color,
          fontSize: 18,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600,
        )
    );
  }
  static Text label({required Color color,required String text,int? maxLines,TextAlign? textAlign,required FontWeight fontWeight}){
    return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style:TextStyle(
          color: color,
          fontSize: 13,
          height: 1.4,
          leadingDistribution: TextLeadingDistribution.even,
          overflow: TextOverflow.ellipsis,
          fontWeight: fontWeight,
        )
    );
  }

  static Text caption({required Color color,required String text,int? maxLines,TextAlign? textAlign,required FontWeight fontWeight}){
    return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style:TextStyle(
          color: color,
          fontSize: 11,
          overflow: TextOverflow.ellipsis,
          fontWeight: fontWeight,
        )
    );
  }
}