import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatefulWidget {
  Contactus({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<Contactus> {
  late VideoPlayerController _videoController;

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video/bg3_2.mp4')
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.setVolume(0); // mute
        _videoController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'vanitadurande130@.gmail.com', // replace with your email
        queryParameters: {
          'subject': 'Contact Us Message from ${_nameCtrl.text}',
          'body':
              'Name: ${_nameCtrl.text}\nEmail: ${_emailCtrl.text}\n\nMessage:\n${_messageCtrl.text}',
        },
      );

      try {
        if (await canLaunchUrl(emailUri)) {
          await launchUrl(emailUri);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Could not open email app')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }

      _formKey.currentState?.reset();
      _nameCtrl.clear();
      _emailCtrl.clear();
      _messageCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background video
          Positioned.fill(
            child: _videoController.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  )
                : Container(color: Colors.black),
          ),
          // Overlay for readability
          Container(color: Colors.black.withOpacity(0.4)),
          // Form content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Card(
                    elevation: 6,
                    color: Colors.black.withOpacity(0.7),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'We would love to hear from you',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _nameCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Full name',
                                labelStyle: TextStyle(color: Colors.white70),
                                prefixIcon: Icon(Icons.person, color: Colors.white70),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white70),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (v) => _validateNotEmpty(v, 'Name'),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _emailCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white70),
                                prefixIcon: Icon(Icons.email, color: Colors.white70),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white70),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _messageCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Message',
                                labelStyle: TextStyle(color: Colors.white70),
                                alignLabelWithHint: true,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Icon(Icons.message, color: Colors.white70),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white70),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              maxLines: 6,
                              minLines: 4,
                              textInputAction: TextInputAction.newline,
                              validator: (v) => _validateNotEmpty(v, 'Message'),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _submit,
                                    icon: const Icon(Icons.send),
                                    label: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 14),
                                      child: Text('Send Message'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                _formKey.currentState?.reset();
                                _nameCtrl.clear();
                                _emailCtrl.clear();
                                _messageCtrl.clear();
                              },
                              child: const Text('Clear'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
