import 'account_service.dart';
import 'comparison_service.dart';
import 'deliverer_service.dart';
import 'laptop_service.dart';
import 'order_service.dart';
import 'preference_service.dart';
import 'review_service.dart';
import 'storage_lot_service.dart';

class NetworkProvider {
  static const String _baseUrl = 'https://10.0.2.2:5001/api';

  static AccountService _accountService;
  static LaptopService _laptopService;
  static ReviewService _reviewService;
  static DelivererService _delivererService;
  static StorageLotService _storageLotService;
  static OrderService _orderService;
  static PreferenceService _preferenceService;
  static ComparisonService _comparisonService;

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

  static DelivererService get delivererService {
    if (_delivererService == null) {
      _delivererService = DelivererService(_baseUrl);
    }
    return _delivererService;
  }

  static StorageLotService get storageLotService {
    if (_storageLotService == null) {
      _storageLotService = StorageLotService(_baseUrl);
    }
    return _storageLotService;
  }

  static OrderService get orderService {
    if (_orderService == null) {
      _orderService = OrderService(_baseUrl);
    }
    return _orderService;
  }

  static PreferenceService get preferenceService {
    if (_preferenceService == null) {
      _preferenceService = PreferenceService(_baseUrl);
    }
    return _preferenceService;
  }

  static ComparisonService get comparisonService {
    if (_comparisonService == null) {
      _comparisonService = ComparisonService(_baseUrl);
    }
    return _comparisonService;
  }
}
