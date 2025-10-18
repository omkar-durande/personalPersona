import 'package:animationweb/Screen/home.dart';
import 'package:animationweb/main.dart';
import 'package:animationweb/widget/loadingarc.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget {
  final Function(int)? onMenuSelect; // callback to parent
  const CustomAppbar({Key? key, this.onMenuSelect}) : super(key: key);

  @override
  AppBarState createState() => AppBarState();
}

class AppBarState extends State<CustomAppbar> {
  late double appbarwidth;

  @override
  Widget build(BuildContext context) {
    appbarwidth = MediaQuery.of(context).size.width * 0.9;

    return MouseRegion(
      onHover: (event) {},
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: appbarwidth > 400 ? 400 : appbarwidth,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF1C1C1C),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RotatingArcRing(),
                const Spacer(),

                // Home
                TextButton(
                  onPressed: () => widget.onMenuSelect?.call(0),
                  child: const Text(
                    "Home",
                    style: TextStyle(color: Color(0xFF94938D), fontSize: 12),
                  ),
                ),
                const Spacer(),

                // Projects
                TextButton(
                  onPressed: () => widget.onMenuSelect?.call(1),
                  child: const Text(
                    "Projects",
                    style: TextStyle(color: Color(0xFF94938D), fontSize: 12),
                  ),
                ),
                const Spacer(),


                // Contact
                TextButton(
                  onPressed: () => widget.onMenuSelect?.call(3),
                  child: const Text(
                    "Contact us",
                    style: TextStyle(color: Color(0xFF94938D), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
