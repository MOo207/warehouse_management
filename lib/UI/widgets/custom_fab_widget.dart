import 'package:flutter/material.dart';

class CustomFABWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? label;
  final String? heroTag;
  final IconData? icon;
  final double? width;
  const CustomFABWidget(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.icon, 
      this.heroTag,
      this.width
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.45,
      child: FloatingActionButton.extended(
        heroTag: heroTag,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(label!),
            
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
