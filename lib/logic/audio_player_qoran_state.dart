abstract class AudioPlayerQoranState {
  const AudioPlayerQoranState();

}

class AudioPlayerQoranInitial extends AudioPlayerQoranState {}

class AudioPlayerQoranLoading extends AudioPlayerQoranState {}

class AudioPlayerQoranLoaded extends AudioPlayerQoranState {
  final bool isPlay;

  const AudioPlayerQoranLoaded(this.isPlay);

}