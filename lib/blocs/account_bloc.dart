import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/account_model.dart';
import 'package:webox/models/edit_user_info_model.dart';
import 'package:webox/models/login_model.dart';
import 'package:webox/models/register_model.dart';
import 'package:webox/services/network_provider.dart';

class AccountBloc {
  final _service = NetworkProvider.accountService;
  final _accountFetcher = PublishSubject<AccountModel>();

  Stream<AccountModel> get userAccount => _accountFetcher.stream;

  Future fetchUserAccount() async {
    var accountModel = await _service.getAccountInformation();
    _accountFetcher.sink.add(accountModel);
  }

  Future login(LoginModel model) async {
    String token = await _service.login(model);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('apiAccessToken', token);
  }

  Future register(RegisterModel model) async {
    String token = await _service.register(model);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('apiAccessToken', token);
  }

  Future<int> restorePassword(String email) async {
    return await _service.restorePassword(email);
  }

  Future<int> updateProfileImage(String profileImagePath) async {
    return await _service.updateProfileImage(profileImagePath);
  }

  Future<int> editAccountInformation(EditUserInfoModel model) async {
    return await _service.editAccountInformation(model);
  }

  Future<String> getEmailUpdateVerificationCode() async {
    return await _service.getUpdateEmailVerificationCode();
  }

  Future<int> updateEmail(String email) async {
    return await _service.updateEmail(email);
  }

  void dispose() {
    _accountFetcher.close();
  }
}

final accountBloc = AccountBloc();
