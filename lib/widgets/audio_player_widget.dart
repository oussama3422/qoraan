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

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with SingleTickerProviderStateMixin {
  static AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  AnimationController? _animationController;

  @override
  void dispose() {
    _animationController!.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

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
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isPlaying) {
          audioPlayer.pause();
          _animationController!.reverse();
        } else {
          audioPlayer.play(
            UrlSource(widget.audioUrl),
          );
          _animationController!.forward();
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.numberofAyat.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          widget.typeArabic,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    widget.nameOfSoratInFrance,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) {
                return isPlaying
                    ? MusicVisualizer(isPlaying: isPlaying)
                    : Container();
              },
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

class MusicVisualizer extends StatelessWidget {
  final bool isPlaying;

  List<Color> colors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.yellowAccent,
  ];

  List<int> durations = [50, 50, 50, 50, 50];

  MusicVisualizer({required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(
        10,
        (index) => VisualComponent(
          color: colors[index % 4],
          duration: durations[index % 5],
          isPlaying: isPlaying,
        ),
      ),
    );
  }
}

class VisualComponent extends StatefulWidget {
  final Color color;
  final int duration;
  final bool isPlaying;

  const VisualComponent({
    Key? key,
    required this.color,
    required this.duration,
    required this.isPlaying,
  }) : super(key: key);

  @override
  State<VisualComponent> createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    if (widget.isPlaying) {
      animationController!.repeat();
    }

    final curvedAnimation =
        CurvedAnimation(parent: animationController!, curve: Curves.decelerate);
    animation = Tween<double>(begin: 0, end: 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(covariant VisualComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying) {
      animationController!.repeat();
    } else {
      animationController!.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
      height: animation!.value,
    );
  }
}
