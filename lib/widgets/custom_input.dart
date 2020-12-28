import 'package:flutter/material.dart';

import '../constants.dart';

class CustomInput extends StatelessWidget {

  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPassword;
  CustomInput({this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isPassword});

  @override
  Widget build(BuildContext context) {

    bool _isPassword = isPassword ?? false;

    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(0,1)
          )
        ]
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          obscureText: _isPassword,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          focusNode: focusNode,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText ?? "Hint Text...",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0,)),
          style: Constants.drkBlue16,
          textInputAction: textInputAction,
        ),
      ),
    );
  }
}
