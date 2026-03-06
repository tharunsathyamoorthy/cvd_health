import 'package:flutter/material.dart';
import 'esc_guidelines_screen.dart';
import 'websites_links_screen.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
        backgroundColor: const Color(0xFFB71C1C),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _tile(
            context,
            title: 'ESC clinical practice guidelines',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EscGuidelinesScreen()),
              );
            },
          ),
          _tile(
            context,
            title: 'Websites & useful links',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WebsitesLinksScreen()),
              );
            },
          ),
          _tile(
            context,
            title: 'Risk calculators',
            onTap: () {
              Navigator.pop(context); // already handled elsewhere
            },
          ),
        ],
      ),
    );
  }

  Widget _tile(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}
