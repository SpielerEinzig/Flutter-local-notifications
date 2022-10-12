import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;
  const CustomButton({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.red[900],
          ),
          const SizedBox(width: 30),
          Text(
            text,
            style: TextStyle(
              color: Colors.red[900],
            ),
          ),
        ],
      ),
    );
  }
}
