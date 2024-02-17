import 'package:audio_app/settings/style.dart';
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
    return BlocProvider(
      create: (context) => AudioPlayerCubit(),
      child: BlocBuilder<AudioPlayerCubit, PlayerState>(
        builder: (context, playerState) {
          return InkWell(
            onTap: () {
              final audioPlayerCubit = context.read<AudioPlayerCubit>();
              if (playerState == PlayerState.playing) {
                audioPlayerCubit.pauseAudio();
              } else {
                audioPlayerCubit.pauseAudio();
                audioPlayerCubit.playAudio(audioUrl);
              }
            },
            child: ListTile(
              // subtitle: Text('test',style: TextStyle(),),
              selectedColor: AppColors.terracotta_red,
              leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.light_beige,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: AppColors.muted_teal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        numberofAyat.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.terracotta_red,
                          fontFamily: AppColors.fontF2,
                        ),
                      ),
                      Text(
                        typeArabic,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.terracotta_red,
                          fontFamily: AppColors.fontF2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: Text(
                nameOfSoratInArabic,
                style: TextStyle(
                  fontSize: 19,
                  color: AppColors.terracotta_red,
                  fontFamily: AppColors.fontF2,
                ),
              ),
              trailing: CircleAvatar(
                backgroundColor: AppColors.light_beige,
                child: Container(
                  alignment: Alignment.center,
                  child: playerState == PlayerState.paused
                      ? Icon(
                          Icons.play_circle_filled,
                          color: AppColors.terracotta_red,
                        )
                      : Icon(
                          Icons.pause_circle_filled,
                          color: AppColors.muted_teal,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
