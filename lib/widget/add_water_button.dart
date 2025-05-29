import 'package:flutter/material.dart';

class addWaterbutton extends StatelessWidget {
  final int amount;
  IconData ? icon;
  final VoidCallback onClitck;
  Color ? color;
   addWaterbutton({
    super.key, required this.amount, required this.onClitck, this.icon,this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child:  Padding(
        padding: const EdgeInsets.all(20.0),
        child:  ElevatedButton.icon(
          onPressed: onClitck,
          label: Text(
            '+${amount} LTR',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          icon: Icon(icon ?? Icons.water_drop),
        ),
      ),  );
  }
}