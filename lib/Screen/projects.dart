import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart'; // 🎥 import video package

class Project {
  final String title;
  final String description;
  final String url;
  final List<String> tags;
  final IconData icon;

  Project({
    required this.title,
    required this.description,
    // required this.url,
    this.tags = const [],
    this.icon = Icons.folder,
  });
}

final List<Project> sampleProjects = [
  Project(
    title: 'Portfolio Website',
    description:
        'A responsive portfolio website built with Flutter Web. Showcases projects, blog posts and contact form.',
    // url: 'https://example.com/portfolio',
    tags: ['Flutter', 'Web', 'Responsive'],
    icon: Icons.web,
  ),
  Project(
    title: 'Task Manager',
    description: 'Simple task manager app with local persistence and drag & drop reordering.',
    // url: 'https://example.com/task-manager',
    tags: ['Flutter', 'Mobile', 'SQLite'],
    icon: Icons.check_circle_outline,
  ),
  Project(
    title: 'Weather App',
    description: 'Clean weather UI using a free weather API with caching and animations.',
    // url: 'https://example.com/weather-app',
    tags: ['API', 'Animations', 'Caching'],
    icon: Icons.wb_sunny,
  ),
  Project(
    title: 'Chat UI',
    description: 'Real-time styled chat interface prototype with message bubbles and avatars.',

    tags: ['UI', 'Realtime', 'Firebase'],
    icon: Icons.chat_bubble_outline,
  ),
];

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/video/bg3(2).mp4') // 🎬 your video
          ..setLooping(true)
          ..setVolume(0)
          ..initialize().then((_) {
            _controller.play();
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showProjectDetails(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(project.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(project.description),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.tags
                    .map((t) => Chip(label: Text(t), visualDensity: VisualDensity.compact))
                    .toList(),
              ),
              const SizedBox(height: 12),
              SelectableText(project.url),
            ],
          ),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     Clipboard.setData(ClipboardData(text: project.url));
            //     Navigator.of(context).pop();
            //     ScaffoldMessenger.of(
            //       context,
            //     ).showSnackBar(const SnackBar(content: Text('Project URL copied to clipboard')));
            //   },
            //   child: const Text('Copy URL'),
            //),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
          ],
        );
      },
    );
  }

  int _calculateCrossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🎥 Video Background
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),

          // 🖤 Dark Overlay for readability
          Container(color: Colors.black.withOpacity(0.55)),

          // 🧱 Page Content
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 12, right: 12, bottom: 12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: sampleProjects.length,
                  itemBuilder: (context, index) {
                    final project = sampleProjects[index];
                    return Card(
                      color: Colors.black.withOpacity(0.4),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _showProjectDetails(context, project),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black.withOpacity(0.1),
                                    radius: 22,
                                    child: Icon(project.icon, color: Colors.white, size: 20),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      project.title,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Text(
                                  project.description,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: project.tags
                                    .map(
                                      (t) => Chip(
                                        label: Text(t),
                                        labelStyle: const TextStyle(color: Colors.white),
                                        backgroundColor: Colors.black.withOpacity(0.5),
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 6),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => _showProjectDetails(context, project),
                                  child: const Text('Details'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
