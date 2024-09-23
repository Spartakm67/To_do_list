import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function() onMenuPressed;

  const CustomAppBar({
    required this.title,
    required this.onMenuPressed,
    super.key,
});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.cyan[100],
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onMenuPressed,
          icon: const Icon(Icons.menu_outlined),
        ),
      ],
    );
  }















}