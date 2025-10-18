import 'package:flutter/material.dart';
import "package:animationweb/Screen/appbar.dart";
import 'package:animationweb/Screen/home.dart';
import 'package:animationweb/Screen/projects.dart';

import 'package:animationweb/Screen/contactus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: WebsitePage());
  }
}

class WebsitePage extends StatefulWidget {
  const WebsitePage({super.key});

  @override
  State<WebsitePage> createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> {
  final PageController _pageController = PageController();

  void _scrollToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical, // scroll vertically like a website
            children: [Home(), ProjectsPage(), Contactus()],
          ),

          // Overlay appbar
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CustomAppbar(
                    onMenuSelect: _scrollToPage, // pass callback
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
