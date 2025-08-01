// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
//
// class AudioPlayerHandler extends BaseAudioHandler {
//   final _player = AudioPlayer();
//
//   AudioPlayerHandler() {
//     _player.playbackEventStream.listen((event) {
//       playbackState.add(_transformEvent(event));
//     });
//   }
//
//   Future<void> playFromUrl(String url) async {
//     await _player.setUrl(url);
//     await _player.play();
//   }
//
//   PlaybackState _transformEvent(PlaybackEvent event) {
//     return PlaybackState(
//       controls: [
//         MediaControl.pause,
//         MediaControl.stop,
//       ],
//       playing: _player.playing,
//       processingState: AudioProcessingState.ready,
//       updatePosition: _player.position,
//     );
//   }
// }
