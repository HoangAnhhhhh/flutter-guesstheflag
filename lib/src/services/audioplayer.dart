import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayer/audioplayer.dart';

class AudioService {
  AudioPlayer audioPlayer;
  AudioService() {
    audioPlayer = AudioPlayer();
  }
  Future<ByteData> loadAsset(String path) async {
    return await rootBundle.load('assets/musics/$path.mp3');
  }

  void play(String path) async {
    final file = new File('${(await getTemporaryDirectory()).path}/$path.mp3');
    await file.writeAsBytes((await loadAsset(path)).buffer.asUint8List());
    audioPlayer.play(file.path, isLocal: true);
  }

  void playForever(String path) async {
    final file = new File('${(await getTemporaryDirectory()).path}/$path.mp3');
    await file.writeAsBytes((await loadAsset(path)).buffer.asUint8List());
    audioPlayer.play(file.path, isLocal: true);
  }

  void stop() {
    audioPlayer.stop();
  }
}
