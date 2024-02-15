import 'package:audio_app/logic/cubit/playcubit.dart';
import 'package:audio_app/logic/cubit/qoran_cubit.dart';
import 'package:audio_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/audio_player_qoran_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AudioPlayerQoranCubit(),
          ),
          BlocProvider(
            create: (context) => PlayCubit(144),
          ),
          BlocProvider(
            create: (context) => QuranCubit()..loadQuran(),
          ),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
