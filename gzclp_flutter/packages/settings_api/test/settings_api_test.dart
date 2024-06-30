import 'package:flutter_test/flutter_test.dart';

import 'package:settings_api/settings_api.dart';

class TestSettingsApi extends SettingsApi {
  const TestSettingsApi() : super();

  @override
  Stream<AppSettings> getAppSettings() => throw UnimplementedError("getAppSettings");

  @override
  Future<void> saveAppSettings(AppSettings settings) => throw UnimplementedError("saveAppSettings");
}

void main() {
  group(SettingsApi, () {
    test('can be constructed', () {
      expect(TestSettingsApi.new, returnsNormally);
    });
  });
}
