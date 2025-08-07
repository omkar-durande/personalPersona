import 'package:flutter/material.dart';

class AppBarButtonAnim extends StatefulWidget {
  @override
  _AppBarButtonAnimState createState() {
    return _AppBarButtonAnimState();
  }
}

class _AppBarButtonAnimState extends State<AppBarButtonAnim> {
  bool _isHovered = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        MouseRegion(
          onEnter: (event) => setState(() {
            _isHovered = true;
          }),
          onExit: (event) => setState(() {
            _isHovered = false;
          }),
          child: GestureDetector(
            onTap: () {},
            child: AnimatedContainer(
              duration: Duration(seconds: 3),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      transform: Matrix4.translationValues(0, _isHovered ? 15 : 0, 0),
                      child: Text(
                        "Projects",
                        style: TextStyle(color: Color(0xFF94938D), fontSize: 12),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: _isHovered ? 0.0 : 1.0,
                    child: Text("Projects", style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
