import 'account_service.dart';

class NetworkProvider {
  static String _baseUrl = 'https://192.168.0.168:44386/api';

  static AccountService _accountService;

  static AccountService get accountService {
    if (_accountService == null) {
      _accountService = new AccountService(_baseUrl);
    }
    return _accountService;
  }
}
