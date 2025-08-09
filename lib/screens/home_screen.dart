import 'dart:io';
import 'package:flutter/material.dart';
import 'editor_screen.dart';

class DiaryEntry {
  final String id;
  final String text;
  final File? imageFile;
  final DateTime createdAt;

  DiaryEntry({
    required this.id,
    required this.text,
    required this.imageFile,
    required this.createdAt,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DiaryEntry> _entries = [];

  Future<void> _openEditor() async {
    final result = await Navigator.of(context).pushNamed(EditorScreen.route);
    if (result is Map<String, dynamic>) {
      setState(() {
        _entries.insert(
          0,
          DiaryEntry(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: result['text'] as String,
            imageFile: result['image'] as File?,
            createdAt: DateTime.now(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('okimochi')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openEditor,
        icon: const Icon(Icons.edit),
        label: const Text('書く'),
      ),
      body: _entries.isEmpty
          ? const _EmptyState()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: _entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final e = _entries[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (e.imageFile != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(e.imageFile!, fit: BoxFit.cover),
                          ),
                          const SizedBox(height: 12),
                        ],
                        Text(
                          e.text,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _fmt(e.createdAt),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _fmt(DateTime dt) {
    final mm = dt.month.toString().padLeft(2, '0');
    final dd = dt.day.toString().padLeft(2, '0');
    return '${dt.year}/$mm/$dd  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome, size: 64),
            const SizedBox(height: 12),
            Text(
              '最初の日記を書いてみよう',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              '写真も1枚添付できます',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
