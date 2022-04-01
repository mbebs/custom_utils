import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../helpers/constants.dart';

class CustomInputField extends StatefulWidget {
  final String? hint;
  final String? label;
  final bool isPasswordField;
  final Function(String? value)? onChange;
  final TextInputType keyboardType;
  void Function(String)? onFieldSubmitted;
  Widget? prefix;
  int? limit;
  TextEditingController? controller;
  VoidCallback? onTap;
  bool? readOnly;
  Color? fillColor;
  int? maxLines;
  int? minLines;
  String? text;
  Color? counterColor;
  bool? showCounter;
  bool? showBorder;
  bool? isDense;
  EdgeInsetsGeometry? margin;
  String? Function(String?)? validator;
  Future<String?> Function(String?)? asyncValidator;
  Widget? suffix;

  CustomInputField(
      {this.hint,
      required this.isPasswordField,
      this.onChange,
      required this.keyboardType,
      this.prefix,
      this.limit,
      this.controller,
      this.onTap,
      this.readOnly,
      this.fillColor,
      this.maxLines,
      this.text,
      this.showCounter,
      this.counterColor,
      this.showBorder,
      this.minLines,
      this.margin,
      this.suffix,
      this.validator,
      this.isDense,
      this.onFieldSubmitted,
      this.asyncValidator,
      this.label});

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _isHidden;

  @override
  void initState() {
    _isHidden = widget.isPasswordField;
    errorMessage = null;

    super.initState();
  }

  Timer? _debounce;
  var isValidating = false;
  var isValid = false;
  var isDirty = false;
  var isWaiting = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {


    if (widget.controller != null && widget.text != null) {
      widget.controller!.text = widget.text!;
    }

    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLength: widget.limit,
        onChanged: widget.asyncValidator != null
            ? (text) async {
                isDirty = true;
                if (text.isEmpty) {
                  setState(() {
                    isValid = false;
                    print('is empty');
                  });
                  cancelTimer();
                  return;
                }
                isWaiting = true;
                cancelTimer();
                _debounce = Timer(Duration(seconds: 0), () async {
                  setState(() {});
                  isValidating = true;
                  errorMessage = await widget.asyncValidator!(text);
                  isWaiting = false;
                  isValidating = false;
                  isValid = errorMessage == null;
                  print(isValid);
                });
              }
            : widget.onChange,
        obscureText: _isHidden,
        onTap: widget.onTap,
        validator: widget.validator ??
            (widget.asyncValidator != null
                ? (value) {
                    return errorMessage ?? null;
                  }
                : null),
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines,
        readOnly: widget.readOnly ?? false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        initialValue: widget.controller == null ? widget.text : null,
        onFieldSubmitted: widget.onFieldSubmitted,
        enabled: widget.keyboardType != TextInputType.none,
        autovalidateMode: widget.asyncValidator != null
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
        buildCounter: (_,
            {required currentLength, maxLength, required isFocused}) {
          return Visibility(
            visible: widget.showCounter ?? false,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  currentLength.toString() +
                      "/" +
                      maxLength.toString(),
                  style: TextStyle(color: widget.counterColor),
                ),
              ),
            ),
          );
        },
        decoration: InputDecoration(
            prefixIcon: widget.prefix,
            hintText: widget.hint,
            labelText: widget.label,
            isDense: widget.isDense,
            fillColor: widget.fillColor ?? /*Color(0xFFECECEC)*/
                Colors.white,
            filled: true,
            suffixIconConstraints: BoxConstraints(minWidth: 50.sp),
            suffixIcon: widget.suffix ??
                (widget.isPasswordField
                    ? IconButton(
                        onPressed: () {
                          if (widget.isPasswordField) {
                            setState(() {
                              _isHidden = !_isHidden;
                            });
                          }
                        },
                        icon: Visibility(
                          visible: widget.isPasswordField,
                          child: Icon(
                            widget.isPasswordField
                                ? (_isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off)
                                : null,
                          ),
                        ),
                      )
                    : (widget.asyncValidator != null
                        ? _getSuffixIcon()
                        : null)),
            hintStyle: TextStyle(color: hintColor),
            contentPadding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: (widget.maxLines != null) ? 15 : 5,
                bottom: (widget.maxLines != null) ? 15 : 5),
            border: (widget.showBorder != null &&
                    widget.showBorder == false)
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(width: 1, color: hintColor),
                  ),
            enabledBorder: (widget.showBorder != null &&
                    widget.showBorder == false)
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(width: 1, color: hintColor))
            // filled: true,
            // fillColor: Color(0xF0BBBBBB),
            ),
      ),
    );
  }

  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
  }

  Widget _getSuffixIcon() {
    if (isValidating) {
      return Transform.scale(
          scale: 0.7, child: CupertinoActivityIndicator());
    } else {
      if (!isValid && isDirty) {
        return Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        );
      } else if (isValid) {
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        return Container(height: 1, width: 1,);
      }
    }
  }
}
