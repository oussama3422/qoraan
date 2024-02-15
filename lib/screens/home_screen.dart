import 'package:audio_app/logic/cubit/qoran_cubit.dart';
import 'package:audio_app/models/qoran_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings/style.dart';
import '../utils/services.dart';
import '../widgets/audio_player_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundApp,
      appBar: AppBar(
        backgroundColor: Style.backgroundApp,
        title: const Text(
          'القرأن الكريم',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<QuranCubit, List<QoranModel>>(
        builder: (context, qoranModel) {
          print(qoranModel.length);
          return qoranModel.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : _buildQuranList(context, qoranModel);
        },
      ),
    );
  }

  Widget _buildQuranList(BuildContext context, List<QoranModel> qoranModel) {
    return ListView.builder(
      itemCount: qoranModel.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            AudioPlayerWidget(
              audioUrl: qoranModel[index].audioUrl!,
              nameOfSoratInFrance: surahList[index].name,
              nameOfSoratInArabic: surahList[index].arabicName,
              numberofAyat: surahList[index].verses,
              index: index,
              typeArabic: surahList[index].type,
            ),
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
          ],
        );
      },
    );
  }
}
