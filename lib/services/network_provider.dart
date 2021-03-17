import 'account_service.dart';

class NetworkProvider {
  static const String _baseUrl = 'https://10.0.2.2:5001/api';

  static AccountService _accountService;

  static AccountService get accountService {
    if (_accountService == null) {
      _accountService = new AccountService(_baseUrl);
    }
    return _accountService;
  }
}
