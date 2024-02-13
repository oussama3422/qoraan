import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
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
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  static AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isPlaying) {
          audioPlayer.pause();
          print(widget.audioUrl);
          print("pause");
        } else {
          print(widget.audioUrl);
          print("end");
          audioPlayer.play(
            UrlSource(widget.audioUrl),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
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
                    child: Text(
                      '${widget.index}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      widget.nameOfSoratInFrance,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        ' ${widget.typeArabic} | عدد أياتها  ${widget.numberofAyat} ',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Text(
              widget.nameOfSoratInArabic,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
