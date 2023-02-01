import 'package:flutter/material.dart';
import 'package:twitch_clone/app/data/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onTap;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onTap,
      controller: controller,
      decoration:  InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CustomColor.buttonColor,
              width: 2,
            ),
          ),
          enabledBorder:
           OutlineInputBorder(
            borderSide: BorderSide(
              color: CustomColor.secondaryBackgroundColor,
            ),
          )
          ),
    );
  }
}