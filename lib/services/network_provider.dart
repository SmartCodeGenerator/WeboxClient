import 'account_service.dart';
import 'laptop_service.dart';

class NetworkProvider {
  static const String _baseUrl = 'https://10.0.2.2:5001/api';

  static AccountService _accountService;
  static LaptopService _laptopService;

  static AccountService get accountService {
    if (_accountService == null) {
      _accountService = new AccountService(_baseUrl);
    }
    return _accountService;
  }

  static LaptopService get laptopService {
    if (_laptopService == null) {
      _laptopService = new LaptopService(_baseUrl);
    }
    return _laptopService;
  }
}
