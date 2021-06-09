import 'package:rxdart/rxdart.dart';
import 'package:webox/models/deliverer_info_model.dart';
import 'package:webox/models/deliverer_model.dart';
import 'package:webox/services/network_provider.dart';

class DelivererBloc {
  final _service = NetworkProvider.delivererService;
  final _fetcher = PublishSubject<List<DelivererInfoModel>>();

  Stream<List<DelivererInfoModel>> get deliverers => _fetcher.stream;

  Future fetchDeliverers() async {
    var result = await _service.getDeliverers();
    if (result is! Error) {
      _fetcher.sink.add(result);
    }
  }

  Future<DelivererInfoModel> getDeliverer(String id) async {
    return await _service.getDeliverer(id);
  }

  Future<int> saveDeliverer(DelivererModel data) async {
    return await _service.saveDeliverer(data);
  }

  Future<int> updateDeliverer(String id, DelivererModel data) async {
    return await _service.updateDeliverer(id, data);
  }

  Future<int> deleteDeliverer(String id) async {
    return await _service.deleteDeliverer(id);
  }

  void dispose() {
    _fetcher.close();
  }
}

final delivererBloc = DelivererBloc();
