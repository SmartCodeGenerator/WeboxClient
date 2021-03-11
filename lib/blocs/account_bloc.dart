import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/account_model.dart';
import 'package:webox/models/login_model.dart';
import 'package:webox/services/network_provider.dart';

class AccountBloc {
  final _service = NetworkProvider.accountService;
  final _accountFetcher = PublishSubject<AccountModel>();

  Stream<AccountModel> get userAccount => _accountFetcher.stream;

  Future<void> fetchUserAccount() async {
    var accountModel = await _service.getAccountInformation();
    _accountFetcher.sink.add(accountModel);
  }

  Future<void> login(LoginModel model) async {
    String token = await _service.login(model);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('apiAccessToken', token);
  }

  void dispose() {
    _accountFetcher.close();
  }
}

final accountBloc = AccountBloc();
