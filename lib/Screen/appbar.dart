import 'package:personPersona/Screen/home.dart';
import 'package:personPersona/widget/loadingarc.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({Key? key}) : super(key: key);
  @override
  AppBarState createState() {
    return AppBarState();
  }
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
            color: Color(0xFF1C1C1C),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RotatingArcRing(),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                        print("omkar");
                      });
                    },
                    child: Text("Home", style: TextStyle(color: Color(0xFF94938D), fontSize: 12)),
                  ),
                  Spacer(),

                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Projects",
                      style: TextStyle(color: Color(0xFF94938D), fontSize: 12),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "About us",
                      style: TextStyle(color: Color(0xFF94938D), fontSize: 12),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Contact us",
                      style: TextStyle(color: Color(0xFF94938D), fontSize: 12),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>((
                        Set<MaterialState> states,
                      ) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromARGB(
                            255,
                            13,
                            12,
                            12,
                          ).withOpacity(0.3); // When pressed
                        }
                        return null; // Default behavior
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
