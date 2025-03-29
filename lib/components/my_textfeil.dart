import 'package:flutter/material.dart';

class Mytextfeild extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const Mytextfeild(
    {
      super.key,
      required this.hint, 
      required this.isPassword,
      required this.controller,
      this.focusNode,
      }
    );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20,vertical:10),
      child:TextField(
        obscureText: isPassword,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor:Theme.of(context).colorScheme.tertiary,
          filled: true
        ),
      )
    );
  }
}