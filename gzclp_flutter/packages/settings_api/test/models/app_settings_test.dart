import 'dart:convert';

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

      group('from json', () {
        test('works with valid json', () {
          const rawJson =
              '''{"gender": "xy", "units": "lb", "microplates": false, "barWeight": "kg20"}''';
          final json = jsonDecode(rawJson);
          final expected = AppSettings((b) => b
            ..gender = Gender.xy
            ..units = WeightUnit.lb
            ..microplates = false
            ..barWeight = BarWeight.kg20);

          final settings = serializer.appSettingsFromJson(json);
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
          const expected = '{gender: xy, units: lb, microplates: false, barWeight: kg20}';
          expect(json, equals(expected));
        });
      });
    });
  });
}
