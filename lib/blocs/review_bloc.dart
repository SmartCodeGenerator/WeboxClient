import 'package:rxdart/subjects.dart';
import 'package:webox/models/review_model.dart';
import 'package:webox/services/network_provider.dart';

class ReviewBloc {
  final _service = NetworkProvider.reviewService;
  final _reviewsFetcher = PublishSubject<List<ReviewInfoModel>>();
  final _reviewFetcher = PublishSubject<ReviewInfoModel>();

  Stream<List<ReviewInfoModel>> get reviews => _reviewsFetcher.stream;
  Stream<ReviewInfoModel> get review => _reviewFetcher.stream;

  Future<int> getReviews() async {
    var event = await _service.getReviews();
    if (event is List<ReviewInfoModel>) {
      _reviewsFetcher.sink.add(event);
      return 200;
    }
    return event;
  }

  Future<int> getReview(String id) async {
    var event = await _service.getReview(id);
    if (event is ReviewInfoModel) {
      _reviewFetcher.sink.add(event);
      return 200;
    }
    return event;
  }

  Future<int> saveReview(ReviewFormModel model) async {
    return await _service.saveReview(model);
  }

  Future<int> updateReview(ReviewFormModel model, String id) async {
    return await _service.updateReview(model, id);
  }

  Future<int> deleteReview(String id) async {
    return await _service.deleteReview(id);
  }

  void dispose() {
    _reviewsFetcher.close();
    _reviewFetcher.close();
  }
}

final reviewBloc = ReviewBloc();
