import 'package:flutter/widgets.dart';
import 'package:gzclp_flutter/bootstrap.dart';
import 'package:local_storage_settings_api/local_storage_settings_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsApi = LocalStorageSettingsApi(plugin: await SharedPreferences.getInstance());

  bootstrap(settingsApi: settingsApi);
}
