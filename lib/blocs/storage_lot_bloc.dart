import 'package:rxdart/rxdart.dart';
import 'package:webox/models/storage_lot_info_model.dart';
import 'package:webox/models/storage_lot_model.dart';
import 'package:webox/models/storage_replenishment_model.dart';
import 'package:webox/services/network_provider.dart';

class StorageLotBloc {
  final service = NetworkProvider.storageLotService;
  final lotsFetcher = PublishSubject<List<StorageLotInfoModel>>();
  final lotFetcher = PublishSubject<StorageLotInfoModel>();

  Stream<List<StorageLotInfoModel>> get storageLots => lotsFetcher.stream;
  Stream<StorageLotInfoModel> get storageLotInfo => lotFetcher.stream;

  Future fetchStorageLots() async {
    var event = await service.getStorageLots();
    lotsFetcher.sink.add(event);
  }

  Future fetchStorageLot(String id) async {
    var event = await service.getStorageLot(id);
    lotFetcher.sink.add(event);
  }

  Future<dynamic> getLaptopAmount(String laptopId) async {
    return await service.getLaptopAmount(laptopId);
  }

  Future<int> saveStorageLot(StorageLotModel model) async {
    return await service.saveStorageLot(model);
  }

  Future<int> updateStorageLot(String id, StorageLotModel model) async {
    return await service.updateStorageLot(id, model);
  }

  Future<int> replenishStorageLot(
      String id, StorageReplenishmentModel model) async {
    return await service.replenishStorageLot(id, model);
  }

  Future<int> deleteStorageLot(String id) async {
    return await service.deleteStorageLot(id);
  }

  void dispose() {
    lotsFetcher.close();
    lotFetcher.close();
  }
}

final storageLotBloc = StorageLotBloc();
