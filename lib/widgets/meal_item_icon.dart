import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealItemIncon extends StatelessWidget{
  MealItemIncon({
    super.key,
  required  this.icon,
   required this.label,
});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        icon,
        size: 17,
        color: Colors.white,
      ),
      const SizedBox(width: 6),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ]);
  }
}