import 'account_service.dart';
import 'laptop_service.dart';
import 'review_service.dart';

class NetworkProvider {
  static const String _baseUrl = 'https://10.0.2.2:5001/api';

  static AccountService _accountService;
  static LaptopService _laptopService;
  static ReviewService _reviewService;

  static AccountService get accountService {
    if (_accountService == null) {
      _accountService = AccountService(_baseUrl);
    }
    return _accountService;
  }

  static LaptopService get laptopService {
    if (_laptopService == null) {
      _laptopService = LaptopService(_baseUrl);
    }
    return _laptopService;
  }

  static ReviewService get reviewService {
    if (_reviewService == null) {
      _reviewService = ReviewService(_baseUrl);
    }
    return _reviewService;
  }
}
