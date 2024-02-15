import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
enum PlayerState { playing, paused }



class PlayCubit extends Cubit<List<PlayerState>> {
  final List<AudioPlayer> audioPlayers;

  PlayCubit(int numberOfPlayers)
      : audioPlayers = List.generate(
          numberOfPlayers,
          (index) => AudioPlayer(),
        ),
        super(List.filled(numberOfPlayers, PlayerState.paused));

  Future<void> playAudio(int playerIndex, String audioUrl) async {
    await audioPlayers[playerIndex].play(UrlSource(audioUrl));
    updateStates(playerIndex, PlayerState.playing);
  }

  Future<void> pauseAudio(int playerIndex) async {
    await audioPlayers[playerIndex].pause();
    updateStates(playerIndex, PlayerState.paused);
  }

  void updateStates(int playerIndex, PlayerState newState) {
    final List<PlayerState> newStates = List.from(state);
    newStates[playerIndex] = newState;
    emit(newStates);
  }

  @override
  Future<void> close() {
    for (final player in audioPlayers) {
      player.dispose();
    }
    return super.close();
  }
}
