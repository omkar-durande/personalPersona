import 'dart:ui';

import 'package:animationweb/Screen/appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Homepage();
}

class _Homepage extends State<Home> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  Offset _mousepointer = Offset.zero;
  bool _isHovered = true;
  bool _displayMedialPanel = false;
  bool onPresentScreen = true;

  void disableRightClick() {
    html.document.onContextMenu.listen((event) {
      event.preventDefault();
    });
  }

  @override
  void initState() {
    super.initState();
    disableRightClick();
    _controller = VideoPlayerController.asset('assets/video/bg3(2).mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
        _controller.setPlaybackSpeed(2.0);
        _controller.addListener(() {
          setState(() {
            if (_controller.value.position == _controller.value.duration) {
              _displayMedialPanel = true;
            }
          });
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //For the Position OF the Omkar Durande Name Length , Width
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

    double positionLeft = ((MediaQuery.of(context).size.width) / 10);
    double positionTop = ((MediaQuery.of(context).size.height) / 8);
    double panelWidth =
        MediaQuery.of(context).size.height -
        (2 * positionTop); // ((MediaQuery.of(context).size.height) / 3);

    double panelLength = MediaQuery.of(context).size.width - 2 * positionLeft;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MouseRegion(
        onHover: (PointerHoverEvent event) {
          setState(() {
            _mousepointer = event.position;
          });
        },
        child: Listener(
          onPointerDown: (event) {
            if (event.kind == PointerDeviceKind.mouse && event.buttons == kSecondaryMouseButton) {
              // Right-click detected, ignore
            }
          },
          child: Stack(
            children: [
              // Background Video
              if (_isVideoInitialized)
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              else
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: const Color.fromARGB(31, 33, 34, 15)),
                  ),
                ),
              Container(
                // color: Colors.black.withOpacity(0.4), // 0.5 = 50% darkness
              ),
              // Foreground content
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                   // Row(mainAxisAlignment: MainAxisAlignment.center, children: [CustomAppbar()]),

                    // Add more content here
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200), // increase this for more delay
                curve: Curves.easeOut,
                left: _mousepointer.dx - 10,
                top: _mousepointer.dy - 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Positioned(
                top: positionTop,
                left: positionLeft,
                child: Container(
                  height: panelWidth,
                  width: panelLength,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                  ),

                  child: (width > 800 && height > 600)
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20, width: panelLength * 0.4),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //SizedBox(height: 20),
                                    Container(
                                      width: panelLength - panelLength * 0.49,
                                      height: panelWidth - 2.5,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.transparent, width: 0.5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            LayoutBuilder(
                                              builder: (context, constraints) {
                                                double fontSize;
                                                if (MediaQuery.of(context).size.width > 1000) {
                                                  fontSize = 42; // Desktop
                                                } else if (MediaQuery.of(context).size.width >
                                                    600) {
                                                  fontSize = 28; // Tablet
                                                } else {
                                                  fontSize = 16; // Mobile
                                                }

                                                return Text(
                                                  'Omkar Durande',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: fontSize,
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily: 'Montserrat',
                                                    shadows: [
                                                      Shadow(
                                                        offset: Offset(2, 2),
                                                        blurRadius: 6,
                                                        color: Colors.black.withOpacity(0.7),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            LayoutBuilder(
                                              builder: (context, constraints) {
                                                double fontSize;
                                                if (MediaQuery.of(context).size.width > 1200) {
                                                  fontSize = 16; // Desktop
                                                } else if (MediaQuery.of(context).size.width >
                                                    600) {
                                                  fontSize = 12; // Table
                                                } else {
                                                  fontSize = 12; // Mobile
                                                }
                                                return Text(
                                                  'I am a passionate developer with a keen interest in exploring and mastering various technologies. I have experience in Flutter for building mobile applications, and I am currently expanding my knowledge in Artificial Intelligence and Machine Learning. Additionally, I have learned Django for web development, which enables me to create full-stack solutions. I am enthusiastic about combining these skills to build innovative and efficient applications.',
                                                  style: TextStyle(
                                                    color: Colors.white.withOpacity(0.8),
                                                    fontSize: fontSize,
                                                    letterSpacing: 2.0,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    //SizedBox(height: 20),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(
                          height: panelWidth, // keep your panel height limit
                          width: panelLength,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                          ),
                          clipBehavior: Clip.hardEdge, // ensures rounded edges still apply
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 220, width: 50),

                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    double fontSize;
                                    if (width > 1000) {
                                      fontSize = 42; // Desktop
                                    } else if (width > 600) {
                                      fontSize = 28; // Tablet
                                    } else {
                                      fontSize = 16; // Mobile
                                    }

                                    return Text(
                                      'Omkar Durande',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Montserrat',
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 6,
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    double fontSize;
                                    if (width > 1200) {
                                      fontSize = 16; // Desktop
                                    } else if (width > 600) {
                                      fontSize = 13; // Tablet
                                    } else {
                                      fontSize = 12; // Mobile
                                    }
                                    return Text(
                                      'I am a passionate developer with a keen interest in exploring and mastering various technologies. I have experience in Flutter for building mobile applications, and I am currently expanding my knowledge in Artificial Intelligence and Machine Learning. Additionally, I have learned Django for web development, which enables me to create full-stack solutions. I am enthusiastic about combining these skills to build innovative and efficient applications.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: fontSize,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w100,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                ),
                                const SizedBox(height: 40), // add some extra spacing at the end
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
