import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final double fontSize;
  final FontWeight fontWeight;
  final TextInputAction inputAction;
  final TextInputType keyboardType;
  final Function(String value) onChanged;
  final void Function(String) onSubmitted;
  final double height;
  final bool obscure;

  CustomTextField(
      {this.icon,
      this.labelText,
      this.fontSize,
      this.fontWeight,
      this.onChanged,
      this.height = 54.0,
      this.onSubmitted,
      this.inputAction,
      this.keyboardType,
      this.obscure});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
          obscureText: obscure ?? false,
          keyboardType: keyboardType,
          onChanged: onChanged,
          textInputAction: inputAction,
          decoration: InputDecoration(
              icon: Icon(
                icon,
                size: 24,
                color: Color(0xFF4bc190),
              ),
              labelText: labelText)),
    );
  }
}
