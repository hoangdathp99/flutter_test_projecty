import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final Function()? onTap;

  const BottomNavItem(
      {required this.title,
      required this.icon,
      this.isSelected = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(3),
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected == true ? Colors.black87 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Icon(icon,
              color: isSelected == true ? Colors.white : Colors.black87,
              size: 17),
          const SizedBox(height: 5),
          isSelected
              ? Text(
                  title,
                  style: TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87),
                )
              : Container(),
        ]),
      ),
    );
  }
}
