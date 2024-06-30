import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:settings_api/settings_api.dart';

import 'package:settings_repository/settings_repository.dart';

class MockSettingsApi extends Mock implements SettingsApi {}

class FakeAppSettings extends Fake implements AppSettings {}

void main() {
  group(SettingsRepository, () {
    late SettingsApi api;

    final appSettings = AppSettings((b) => b
      ..gender = Gender.xx
      ..units = WeightUnit.kg
      ..microplates = true
      ..barWeight = BarWeight.kg15);

    setUpAll(() {
      registerFallbackValue(FakeAppSettings());
    });

    setUp(() {
      api = MockSettingsApi();
      when(() => api.getAppSettings()).thenAnswer((_) => Stream.value(appSettings));
      when(() => api.saveAppSettings(any())).thenAnswer((_) async {});
    });

    SettingsRepository createSubject() => SettingsRepository(settingsApi: api);

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('getAppSettings', () {
      test('makes correct SettingsApi request', () {
        final subject = createSubject();
        expect(
          subject.getAppSettings(),
          isNot(throwsA(anything)),
        );

        verify(() => api.getAppSettings()).called(1);
      });

      test('returns stream', () {
        final subject = createSubject();
        expect(
          subject.getAppSettings(),
          emits(appSettings),
        );
      });
    });

    group('saveAppSettings', () {
      test('makes correct SettingsApi request', () {
        final newSettings = AppSettings((b) => b
          ..barWeight = BarWeight.kg20
          ..gender = Gender.xy
          ..microplates = true
          ..units = WeightUnit.lb);

        final subject = createSubject();

        expect(subject.saveAppSettings(newSettings), completes);
        verify(() => api.saveAppSettings(newSettings)).called(1);
      });
    });
  });
}
