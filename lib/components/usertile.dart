import 'package:flutter/material.dart';

class Usertile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const Usertile({
    super.key,
    required this.text,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.secondary)),
          borderRadius: BorderRadius.circular(10),
        ), 
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}