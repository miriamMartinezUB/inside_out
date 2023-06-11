import 'package:flutter/cupertino.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/resources/storage_keys.dart';

class PrivacyPolicyProvider extends ChangeNotifier {
  final LocaleStorageService localeStorageService;

  PrivacyPolicyProvider(this.localeStorageService);

  bool _loading = false;

  bool get isLoading => _loading;

  Future<void> acceptPrivacyPolicy() async {
    _loading = true;
    notifyListeners();
    await localeStorageService.saveBool(StorageKeys.privacyPolicyAccepted, true);
    _loading = false;
    notifyListeners();
  }
}
