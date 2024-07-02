import 'package:test/test.dart';
import 'package:settings_api/settings_api.dart';

void main() {
  group(AppSettings, () {
    group('creation', () {
      test('works with defaults', () {
        final settings = AppSettings.withDefaults();
        expect(settings, isNotNull);
      });
    });

    group('serialize', () {
      final serializer = SettingsApiSerializer();

      const rawJson = '''{"gender":"xy","units":"lb","microplates":false,"barWeight":"kg20"}''';

      group('from json', () {
        test('works with valid json', () {
          final expected = AppSettings((b) => b
            ..gender = Gender.xy
            ..units = WeightUnit.lb
            ..microplates = false
            ..barWeight = BarWeight.kg20);

          final settings = serializer.appSettingsFromJson(rawJson);
          expect(settings, equals(expected));
        });
      });

      group('to json', () {
        test('works correctly', () {
          final settings = AppSettings((b) => b
            ..gender = Gender.xy
            ..units = WeightUnit.lb
            ..microplates = false
            ..barWeight = BarWeight.kg20);
          final json = serializer.appSettingsToJson(settings);
          expect(json, equals(rawJson));
        });
      });
    });
  });
}
