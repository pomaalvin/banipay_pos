import 'package:banipay_pos/ui/widgets/atoms/bp_text.dart';
import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum InputType {
  password,
  normal,
  number,
  email,
}



class BpInput extends StatefulWidget {
  final String hint;
  final String? label;
  final String? Function(String?) validator;
  final int? inputMaxLength;
  final bool readOnly;
  final InputType inputType;
  final String? error;
  final List<String>? autoFillHints;
  final TextCapitalization? textCapitalization;
  final int minLines;
  final IconData? suffix;
  final Function(String?) onChanged;
  final Function(String?)? onSubmit;
  final TextEditingController controller;

  const BpInput({
    Key? key,
    required this.onChanged,
    required this.validator,
    this.textCapitalization,
    this.label,
    this.onSubmit,
    required this.hint,
    this.inputMaxLength,
    this.suffix,
    this.readOnly=false,
    required this.inputType,
    this.error,
    this.autoFillHints,
    required this.controller,
    this.minLines=1
  }) :super(key: key);

  @override
  State<BpInput> createState() => _BpInputState();
}

class _BpInputState extends State<BpInput> {
  late bool _showText;
  GlobalKey inputKey = GlobalKey();
  FocusNode focusNode= FocusNode();
  final TextEditingController _controller=TextEditingController();
  @override
  void initState() {
    super.initState();
    _showText = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.label != null)
          BpText.label(
              text: widget.label ?? "",
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),
        if(widget.label != null)
          const SizedBox(height: 4,),
        TextFormField(
          controller: widget.controller,
          key: inputKey,
          onChanged: widget.onChanged,
          style: BpText
              .body(color: BpColors.tertiary, fontWeight: FontWeight.w500, text: '')
              .style,
          strutStyle: StrutStyle.fromTextStyle(BpText
              .body(color: BpColors.tertiary, fontWeight: FontWeight.w500, text: '')
              .style ?? const TextStyle()),
          autofillHints: widget.autoFillHints,
          textCapitalization: widget.textCapitalization ??
              TextCapitalization.none,
          onFieldSubmitted: widget.onSubmit,
          keyboardType: _selectInputTextType(widget.inputType),
          inputFormatters: _selectInputFormatter(widget.inputType),
          obscureText: widget.inputType == InputType.password && _showText
              ? true
              : false,
          cursorColor: BpColors.primary,
          maxLines: 1,
          maxLength: widget.inputMaxLength,
          readOnly: widget.readOnly,
          validator: widget.validator,
          focusNode: focusNode,

          decoration: InputDecoration(

              contentPadding: const EdgeInsets.all(10),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none
              ),
              isCollapsed: true,
              filled: true,
              hintText: widget.hint,
              suffixIcon:
              widget.inputType==InputType.password?
              GestureDetector(
                onTap: (){
                  setState(() {
                    _showText=!_showText;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(_showText?Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: BpColors.primary),
                ),
              ):
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(widget.suffix,color: BpColors.secondary,size: 30,),
              ),
              suffixIconConstraints: const BoxConstraints(minHeight: 0,minWidth: 0),
              hintStyle: BpText
                  .body(color: BpColors.tertiary.withOpacity(0.3),
                  text: '',
                  fontWeight: FontWeight.w500)
                  .style,
              fillColor: Colors.white,

              enabledBorder: null,
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: BpColors.primary,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
              errorMaxLines: 1,

              errorStyle: BpText.caption(color: Colors.red, text: "", fontWeight: FontWeight.w400).style,
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
              disabledBorder: null
          ),
        ),
      ],
    );
  }

  _selectInputFormatter(InputType inputType) {
    switch (inputType) {
      case InputType.number:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow((RegExp("[.,0-9]"))),
        ];
      default:
        return null;
    }
  }




  _selectInputTextType(InputType inputType) {
    switch (inputType) {
      case InputType.number:
        return TextInputType.number;
      case InputType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }
}


