import 'package:flutter/material.dart';

class BuildCircularNavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  const BuildCircularNavItem({
    super.key, 
    required this.icon, 
    required this.index, 
    required this.currentIndex,
    });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;
    return AnimatedContainer(
    duration: Duration(milliseconds: 250),
    padding: EdgeInsets.only(
      left: isSelected ? 10 : 0,
      right: isSelected ? 10 : 0,
    ),
    // decoration: BoxDecoration(
    //   color: isSelected ? Colors.black12 : Colors.transparent,
    //   shape: BoxShape.circle,
    // ),
    child: Icon(icon, size: isSelected ? 35 : 30),
  );
}

}

