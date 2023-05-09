import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:wirdul_latif/utils/colors.dart';

class WirdIconButton extends StatefulWidget {
  final IconData icon;
  final Void Function()? onTap;
  const WirdIconButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  @override
  State<WirdIconButton> createState() => _WirdIconButtonState();
}

class _WirdIconButtonState extends State<WirdIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap,
      child: Icon(
        widget.icon,
        size: 50,
        color: WirdColors.seconderyColor,
      ),
    );
  }
}
