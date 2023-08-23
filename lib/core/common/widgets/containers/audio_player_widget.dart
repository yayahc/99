import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ninety/core/extensions/extension_on_string.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioPath;

  const AudioPlayerWidget({super.key, required this.audioPath});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  late bool isPlaying;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioStream = _audioPlayer.onPlayerStateChanged.asBroadcastStream();

    return StreamBuilder<PlayerState>(
      stream: audioStream,
      builder: (context, snapshot) {
        if (snapshot.data == PlayerState.playing) {
          return ElevatedButton(
              onPressed: () {
                _audioPlayer.pause();
              },
              child: "Pause".asWidget());
        }
        return ElevatedButton(
            onPressed: () {
              _audioPlayer.play(DeviceFileSource(widget.audioPath));
            },
            child: "Play".asWidget());
      },
    );
  }
}
