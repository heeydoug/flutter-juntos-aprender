import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: MyColors.roxo,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
