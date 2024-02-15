import 'package:bloc/bloc.dart';
import 'package:audio_app/models/qoran_model.dart';
import 'package:audio_app/services/api.dart';

enum QuranState { loading, loaded, error }

class QuranCubit extends Cubit<List<QoranModel>> {
  final Api api = Api();

  QuranCubit() : super([]);

  Future<void> loadQuran() async {
    emit([]);
    try {
      final qoranModel = await api.getQoranList();
      print(qoranModel);
      emit(qoranModel);
    } catch (e) {
      print('error');
      // emit();
    }
  }
}
