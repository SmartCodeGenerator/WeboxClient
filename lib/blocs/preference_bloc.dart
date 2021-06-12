import 'package:rxdart/rxdart.dart';
import 'package:webox/models/preference_model.dart';
import 'package:webox/services/network_provider.dart';

class PreferenceBloc {
  final _service = NetworkProvider.preferenceService;
  final _preferencesFetcher = PublishSubject<List<PreferenceModel>>();

  Stream<List<PreferenceModel>> get preferences => _preferencesFetcher.stream;

  Future fetchPreferences() async {
    try {
      var event = await _service.getPreferences();
      _preferencesFetcher.sink.add(event);
    } catch (ex) {
      print(ex);
    }
  }

  Future<bool> getPreferenceStatus(String laptopId) async {
    try {
      return await _service.checkPresence(laptopId);
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<int> addPreference(String laptopId) async {
    return await _service.addPreference(laptopId);
  }

  Future<int> removePreference(String id) async {
    return await _service.removePreference(id);
  }

  void dispose() {
    _preferencesFetcher.close();
  }
}

final preferenceBloc = PreferenceBloc();
