import 'package:bloc/bloc.dart';
import 'package:audioplayers/audioplayers.dart';

enum PlayerState { playing, paused }

class AudioPlayerCubit extends Cubit<PlayerState> {
  final AudioPlayer audioPlayer;

  AudioPlayerCubit() : audioPlayer = AudioPlayer(), super(PlayerState.paused);

  Future<void> playAudio(String audioUrl) async {
    await audioPlayer.play(UrlSource(audioUrl));
    emit(PlayerState.playing);
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
    emit(PlayerState.paused);
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
