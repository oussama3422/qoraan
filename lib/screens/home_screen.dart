import 'package:audio_app/models/qoran_model.dart';
import 'package:audio_app/services/api.dart';
import 'package:audio_app/services/sorat_arabic.dart';
import 'package:flutter/material.dart';

import '../settings/style.dart';
import '../utils/services.dart';
import '../widgets/audio_player_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QoranModel> qoranModel = [];
  Api api = Api();

  @override
  void initState() {
    super.initState();
    getAudios();
  }

  getAudios() async {
    final qoranModel2 = await api.getQoranList();
    setState(() {
      qoranModel = qoranModel2;
    });
  }

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
      body: ListView.builder(
          itemCount: qoranModel.length,
          itemBuilder: (context, index) {
            print(qoranModel[index].audioUrl!);
            print(qoranModel[index].chapterId);
            print(qoranModel[index].fileSize);
            print(qoranModel[index].id);
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
          }),
    );
  }
}
