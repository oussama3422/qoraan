import 'dart:convert';

import 'package:audio_app/models/qoran_model.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<List<QoranModel>> getQoranList() async {
    try {
      final url = 'https://api.quran.com/api/v4/chapter_recitations/1';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
        print("::::>$decodedData");
        if (decodedData.containsKey('audio_files')) {
          final qoranAudios =
              QoranModel.fromJsonList(decodedData['audio_files']);
          return qoranAudios;
        } else {
          print('Error: Invalid response format, "audio_files" key not found.');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Response Length: ${response.body.length}');
      }
    } catch (error) {
      print("error $error");
    }
    return [];
  }
}
