import 'dart:math';
import 'package:accessibility_provider/classes/audio_cue.dart';
import 'package:accessibility_provider/src/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

class Accessibility extends StatefulWidget {
  final Widget child;
  final String id;
  final double elevation;
  final double radius;
  final Color color;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  const Accessibility({
    required this.id,
    super.key,
    required this.child,
    this.onTap,
    this.color = Colors.transparent,
    this.onDoubleTap,
    this.elevation = 1,
    this.radius = 20,
  });

  @override
  State<Accessibility> createState() => _AccessibilityState();
}

class _AccessibilityState extends State<Accessibility> {
  final _audioPlayer = AudioPlayer();
  late AudioCue _audioCue;
  @override
  void initState() {
    super.initState();
    getAudioCue();
  }

  Future<void> getAudioCue() async {
    final firestore = Provider.of<AccessibilityProvider>(context).firestore;
    final audioRef = await firestore.collection('audio').doc(widget.id).get();
    setState(() {
      _audioCue = AudioCue.fromJson(audioRef.data() ?? {});
      if (Uri.tryParse(_audioCue.url) is Uri) {
        _audioPlayer.setAudioSource(
          AudioSource.uri(
            Uri.parse(_audioCue.url),
          ),
        );
      }
    });
  }

  Future<void> _handleTap(AccessibilityProvider provider) async {
    setState(() {
      provider.activeWidget = widget.id;
      if (widget.onTap != null) {
        widget.onTap!();
      }
    });
    if (_audioPlayer.playing) {
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.pause();
    }
    await _audioPlayer.play();
    await _audioPlayer.seek(Duration.zero);
  }

  Future<void> _handleDoubleTap(AccessibilityProvider provider) async {
    setState(() {
      provider.activeWidget = widget.id;
      if (widget.onDoubleTap != null) {
        widget.onDoubleTap!();
      }
      _audioPlayer.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color col = deepColors[random.nextInt(deepColors.length)];
    final provider = Provider.of<AccessibilityProvider>(context);
    return ValueListenableBuilder<String>(
      valueListenable: ValueNotifier<String>(provider.key),
      builder: (context, value, child) {
        if (value != widget.id && value.isNotEmpty) {
          _audioPlayer.seek(Duration.zero).then((value) => _audioPlayer.pause());
        }
        return GestureDetector(
          onTap: () async => await _handleTap(provider),
          onDoubleTap: () => _handleDoubleTap(provider),
          child: Card(
            color: provider.enabled && provider.key == widget.id ? col : Colors.blueGrey.shade100,
            elevation: widget.elevation,
            child: widget.child,
          ),
        );
      },
    );
  }
}

final random = Random();
List<Color> deepColors = [
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.blue,
];
