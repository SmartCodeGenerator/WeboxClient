import 'package:rxdart/rxdart.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/laptop_page_model.dart';
import 'package:webox/services/network_provider.dart';

class LaptopBloc {
  final _service = NetworkProvider.laptopService;
  final _laptopPageFetcher = PublishSubject<LaptopPageModel>();
  final _laptopModelFetcher = PublishSubject<LaptopWithIdModel>();

  Stream<LaptopPageModel> get laptopPageModel => _laptopPageFetcher.stream;
  Stream<LaptopWithIdModel> get laptopModel => _laptopModelFetcher.stream;

  Future fetchLaptopPageModel(
      int pageIndex, String sortOrder, LaptopQueryParams params) async {
    var model = await _service.getLaptopPage(pageIndex, sortOrder, params);
    _laptopPageFetcher.sink.add(model);
  }

  Future fetchLaptopModel(String id) async {
    var model = await _service.getLaptop(id);
    _laptopModelFetcher.sink.add(model);
  }

  Future<bool> addLaptop(LaptopModel model) async {
    try {
      return await _service.addLaptop(model);
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }

  Future<bool> updateLaptop(String id, LaptopModel model) async {
    try {
      return await _service.updateLaptop(id, model);
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }

  Future<bool> deleteLaptop(String id) async {
    try {
      return await _service.deleteLaptop(id);
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }

  void dispose() {
    _laptopPageFetcher.close();
    _laptopModelFetcher.close();
  }
}

final laptopBloc = LaptopBloc();
