import 'package:rxdart/rxdart.dart';
import 'package:webox/models/preference_model.dart';
import 'package:webox/services/network_provider.dart';

class PreferenceBloc {
  final _service = NetworkProvider.preferenceService;
  final _preferencesFetcher = PublishSubject<List<PreferenceModel>>();
  final _statusFetcher = PublishSubject<Map<String, dynamic>>();

  Stream<List<PreferenceModel>> get preferences => _preferencesFetcher.stream;
  Stream<Map<String, dynamic>> get preferenceStatus => _statusFetcher.stream;

  Future fetchPreferences() async {
    try {
      var event = await _service.getPreferences();
      _preferencesFetcher.sink.add(event);
    } catch (ex) {
      print(ex);
    }
  }

  Future fetchPreferenceStatus(String laptopId) async {
    try {
      var result = await _service.checkPresence(laptopId);
      var event = {
        'id': laptopId,
        'result': result,
      };
      _statusFetcher.sink.add(event);
    } catch (ex) {
      print(ex);
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
    _statusFetcher.close();
  }
}

final preferenceBloc = PreferenceBloc();
