import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/utils.dart';

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
        width: 90,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected == true ? Colors.black87 : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child:  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(
              flex: 1,
              child: Icon(
                icon,
                color: isSelected == true ? Colors.white : Colors.black87,
                size: 17,
              ),
            ),
            // const SizedBox(height: 5),
            Text(
              capitalize(title),
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Colors.white : Colors.black87),
            )
          ]),
        ),
    );
  }
}
