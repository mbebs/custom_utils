import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomChips extends StatefulWidget {
  final List<String> chipNames;
  final bool selectable;
  final bool? scrollable;
  final Color? unselectedTextColor, selectedChipColor, unselectedChipColor;
  final ValueChanged<List<String>>? onDeleted;
  final ValueChanged<int>? onSelected;
  final Widget? deleteIcon;
  final double? fontSize;

  @override
  _CustomChipsState createState() => _CustomChipsState();

  CustomChips(
      {required this.chipNames,
      required this.selectable,
      this.unselectedTextColor,
      this.selectedChipColor,
      this.unselectedChipColor,
      this.onSelected,
      this.fontSize,
      this.onDeleted,
      this.scrollable,
      this.deleteIcon});
}

class _CustomChipsState extends State<CustomChips> {
  String _isSelected = "";
  late TextStyle labelStyle;

  @override
  void initState() {
    labelStyle = TextStyle(color: widget.unselectedTextColor ?? Colors.black, fontSize: widget.fontSize);
    super.initState();
  }

  _buildChoiceList() {
    List<Widget> choices = List.empty(growable: true);
    widget.chipNames.forEach((item) {
      choices.add(Container(
        child: RawChip(
          label: Text(item),
          labelStyle: labelStyle,
          deleteIcon: widget.deleteIcon,
          checkmarkColor: Colors.white,
          onDeleted: widget.onDeleted != null
              ? () {
                  setState(
                    () {
                      int deleteIndex = widget.chipNames.indexOf(item);
                      widget.chipNames.removeAt(deleteIndex);
                      widget.onDeleted!(widget.chipNames);
                    },
                  );
                }
              : null,
          selectedColor: widget.selectedChipColor ?? Colors.pinkAccent,
          backgroundColor: widget.unselectedChipColor ?? Colors.grey[300],
          selected: widget.selectable ? _isSelected == item : false,
          onSelected: (selected) {
            if (widget.selectable) {
              setState(() {
                _isSelected = item;
                if (widget.onSelected != null) {
                  widget.onSelected!(widget.chipNames.indexOf(item));
                }
              });
            }
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> choices = _buildChoiceList();
    return (widget.scrollable != null && widget.scrollable == true)
        ? Container(
            height: 7.h,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return choices[index];
                },
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 3.5.sp,
                  );
                },
                itemCount: choices.length),
          )
        : Wrap(
            spacing: 3.5.sp,
            runSpacing: 2.5.sp,
            children: choices,
          );
  }
}
