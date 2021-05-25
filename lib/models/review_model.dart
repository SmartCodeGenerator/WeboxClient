class ReviewFormModel {
  String reviewText;
  double rating;
  String laptopId;

  Map<String, dynamic> toJson() {
    return {
      'reviewText': reviewText,
      'rating': rating,
      'laptopId': laptopId,
    };
  }
}

class ReviewInfoModel {
  String _id;
  String _text;
  DateTime _pubDateTime;
  double _rating;
  String _userName;
  String _laptopId;

  ReviewInfoModel.fromJson(Map<String, dynamic> data) {
    _id = data['id'];
    _text = data['text'];
    _pubDateTime = DateTime.parse(data['pubDateTime']);
    _rating = data['rating'] + .0;
    _userName = data['userName'];
    _laptopId = data['laptopId'];
  }

  String get id => _id;
  String get text => _text;
  DateTime get pubDateTime => _pubDateTime;
  double get rating => _rating;
  String get userName => _userName;
  String get laptopId => _laptopId;
}
