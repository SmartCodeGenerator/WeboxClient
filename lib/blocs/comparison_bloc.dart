import 'package:rxdart/rxdart.dart';
import 'package:webox/models/comparison_model.dart';
import 'package:webox/services/network_provider.dart';

class ComparisonBloc {
  final _service = NetworkProvider.comparisonService;
  final _comparisonsFetcher = PublishSubject<List<ComparisonModel>>();

  Stream<List<ComparisonModel>> get comparisons => _comparisonsFetcher.stream;

  Future fetchComparisons() async {
    try {
      var event = await _service.getComparisons();
      _comparisonsFetcher.sink.add(event);
    } catch (ex) {
      print(ex);
    }
  }

  Future<bool> getComparisonStatus(String laptopId) async {
    try {
      return await _service.checkPresence(laptopId);
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<int> addComparison(String laptopId) async {
    return await _service.addComparison(laptopId);
  }

  Future<int> removeComparison(String id) async {
    return await _service.removeComparison(id);
  }

  void dispose() {
    _comparisonsFetcher.close();
  }
}

final comparisonBloc = ComparisonBloc();
