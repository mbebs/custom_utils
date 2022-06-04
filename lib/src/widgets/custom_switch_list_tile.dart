import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatefulWidget {
  final Widget? title, subtitle, leading;
  final bool value;
  final ValueChanged<bool> onChanged;
  final double? sizeScale;
  final Color? activeColor;

  @override
  _CustomSwitchListTileState createState() => _CustomSwitchListTileState();

  CustomSwitchListTile({this.title, this.subtitle, this.leading, required this.value, required this.onChanged, this.sizeScale, this.activeColor});
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      subtitle: widget.subtitle,
      leading: widget.leading,
      trailing: Transform.scale(
        scale: widget.sizeScale ?? 1,
        child: Switch.adaptive(
          value: widget.value,
          activeColor: widget.activeColor,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
