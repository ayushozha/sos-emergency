import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:sos_emergency/genui/emergency_conversation.dart';

/// A runnable screen that drives the genui emergency surface against the Python
/// backend.
///
/// The persistent **safety rail** at the top is app chrome — it never depends
/// on the model, so 911 / share / voice are always reachable. Below it, the
/// model-composed [Surface]s render. Type a situation to compose one.
///
/// Backend base URL comes from `--dart-define=BACKEND_BASE=...`
/// (defaults to `http://localhost:8000`).
class EmergencyGenUiScreen extends StatefulWidget {
  const EmergencyGenUiScreen({super.key});

  static const String _backendBase = String.fromEnvironment(
    'BACKEND_BASE',
    defaultValue: 'http://localhost:8000',
  );

  @override
  State<EmergencyGenUiScreen> createState() => _EmergencyGenUiScreenState();
}

class _EmergencyGenUiScreenState extends State<EmergencyGenUiScreen> {
  late final EmergencySession _session;
  final _input = TextEditingController();
  final _surfaceIds = <String>[];
  String? _error;

  @override
  void initState() {
    super.initState();
    _session = buildEmergencySession(
      backendBase: Uri.parse(EmergencyGenUiScreen._backendBase),
    );
    _session.conversation.events.listen((event) {
      if (!mounted) return;
      setState(() {
        switch (event) {
          case ConversationSurfaceAdded(:final surfaceId):
            if (!_surfaceIds.contains(surfaceId)) _surfaceIds.add(surfaceId);
          case ConversationSurfaceRemoved(:final surfaceId):
            _surfaceIds.remove(surfaceId);
          case ConversationError(:final error):
            _error = '$error';
          case _:
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    _session.dispose();
    _input.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    _input.clear();
    setState(() => _error = null);
    await _session.conversation.sendRequest(ChatMessage.user(text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _SafetyRail(),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Expanded(
              child: _surfaceIds.isEmpty
                  ? const Center(
                      child: Text('Describe the emergency to compose it.'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _surfaceIds.length,
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Surface(
                          surfaceContext: _session.controller.contextFor(
                            _surfaceIds[i],
                          ),
                        ),
                      ),
                    ),
            ),
            _Composer(controller: _input, onSend: _send),
          ],
        ),
      ),
    );
  }
}

/// Always-on safety controls — app chrome, never model-driven.
class _SafetyRail extends StatelessWidget {
  const _SafetyRail();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.errorContainer,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _RailButton(icon: Icons.call, label: 'Call 911'),
            SizedBox(width: 12),
            _RailButton(icon: Icons.location_on, label: 'Share location'),
            SizedBox(width: 12),
            _RailButton(icon: Icons.mic, label: 'Voice'),
          ],
        ),
      ),
    );
  }
}

class _RailButton extends StatelessWidget {
  const _RailButton({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton.tonalIcon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.controller, required this.onSend});
  final TextEditingController controller;
  final Future<void> Function() onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSend(),
              decoration: const InputDecoration(
                hintText: "What's happening?",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(onPressed: onSend, icon: const Icon(Icons.send)),
        ],
      ),
    );
  }
}
