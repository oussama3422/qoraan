import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/playcubit.dart';

class AudioPlayerWidget extends StatelessWidget {
  final String audioUrl;
  final String nameOfSoratInArabic;
  final String nameOfSoratInFrance;
  final int index;
  final int numberofAyat;
  final String typeArabic;

  const AudioPlayerWidget({
    required this.audioUrl,
    required this.nameOfSoratInFrance,
    required this.nameOfSoratInArabic,
    required this.index,
    required this.numberofAyat,
    required this.typeArabic,
  });

  @override
  Widget build(BuildContext context) {
    final playerCubit = context.read<PlayCubit>();
    final PlayerState playerState = playerCubit.state[index];
    return InkWell(
      onTap: () {
          if (playerState == PlayerState.playing) {
          playerCubit.pauseAudio(index);
        } else {
          playerCubit.playAudio(index, audioUrl);
        }
      },
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.lightBlueAccent,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            backgroundColor:
                const Color.fromARGB(255, 72, 93, 247).withOpacity(0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  numberofAyat.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  typeArabic,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        title: Text(
          nameOfSoratInArabic,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.blue,
          ),
        ),
        trailing: CircleAvatar(
          child: Container(
            alignment: Alignment.center,
            child: playerCubit.state == PlayerState.paused
                ? Icon(
                    Icons.pause_circle_filled,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.grey,
                  ),
          ),
        ),
      ),
  
    );
  }
}