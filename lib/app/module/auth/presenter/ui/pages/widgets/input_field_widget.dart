import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconButton? iconButton;

  const InputFieldWidget(
      {super.key,
      required this.controller,
      required this.label,
      this.prefixIcon,
      this.iconButton,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            prefixIconColor: const Color.fromARGB(255, 2, 39, 250),
            suffixIcon: iconButton,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text('Your $label'),
          ),
        ),
      ],
    );
  }
}
