import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animationweb/Screen/appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: VideoBackgroundPage(), debugShowCheckedModeBanner: false);
  }
}

class VideoBackgroundPage extends StatefulWidget {
  const VideoBackgroundPage({super.key});

  @override
  _VideoBackgroundPageState createState() => _VideoBackgroundPageState();
}

class _VideoBackgroundPageState extends State<VideoBackgroundPage> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  Offset _mousepointer = Offset.zero;
  bool _isHovered = true;
  bool _displayMedialPanel = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/bg3(2).mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _controller.setLooping(false);
        _controller.setVolume(0);
        _controller.play();
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

    double panelLength =
        MediaQuery.of(context).size.width - ((MediaQuery.of(context).size.width) / 3) * 2;
    double panelWidth =
        MediaQuery.of(context).size.height - ((MediaQuery.of(context).size.height) / 3) * 2;
    double positionLeft = ((MediaQuery.of(context).size.width) / 3);
    double positionTop = ((MediaQuery.of(context).size.height - panelWidth) / 3);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MouseRegion(
        onHover: (PointerHoverEvent event) {
          setState(() {
            _mousepointer = event.position;
          });
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

            // Foreground content
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [CustomAppbar()]),

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
            if (_displayMedialPanel)
              Positioned(
                top: positionTop,
                left: positionLeft,
                child: Container(
                  height: panelWidth,
                  width: panelLength,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Omkar Durande',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: panelLength / 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: panelWidth / 30),
                      Text(
                        'Flutter Developer | UI/UX Enthusiast',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: panelLength / 25,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
