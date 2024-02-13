import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';

import 'audio_player_qoran_state.dart';
// Cubit
class AudioPlayerQoranCubit extends Cubit<AudioPlayerQoranState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  AudioPlayerQoranCubit() : super(AudioPlayerQoranInitial());

  void playPause(String audioUrl) {
    emit(AudioPlayerQoranLoading());
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(audioUrl));
    }
    _isPlaying = !_isPlaying;
    emit(AudioPlayerQoranLoaded(_isPlaying));
  }
}