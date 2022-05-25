
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../helpers/constants.dart';
import '../helpers/styles.dart';
class CustomButton extends StatefulWidget {
  Color? color;
  String text;
  double? width;
  double? height;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  VoidCallback onPressed;
  VoidCallback? onLongPressed;
  TextStyle? textStyle;
  TextAlign? textAlign;
  OutlinedBorder? shape;

  CustomButton(
      {this.color,
        required this.text,
        required this.onPressed,
        this.width,
        this.margin,
        this.height,
        this.textStyle,
        this.shape,
        this.padding,
        this.textAlign, this.onLongPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: widget.margin ??
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        height: widget.height,
        width: widget.width,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          onLongPress: widget.onLongPressed,
          style: ElevatedButton.styleFrom(
              padding: widget.padding,
              primary: widget.color ?? buttonColor,
              shape: widget.shape ??
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
          child: Text(
            widget.text,
            textAlign: widget.textAlign ?? TextAlign.center,
            style: widget.textStyle ??
                normal_h3Style.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}