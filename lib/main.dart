import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:personPersona/Screen/appbar.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/bg3.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              const Center(child: CircularProgressIndicator()),

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
          ],
        ),
      ),
    );
  }
}
