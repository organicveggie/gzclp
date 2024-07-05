import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/serializer.dart';
import 'package:settings_api/settings_api.dart';

import 'models.dart';

part 'serializers.g.dart';

@SerializersFor([
  AppSettings,
  BarWeight,
  Exercise,
  ExerciseSettings,
  ExerciseTier,
  Gender,
  WeightUnit,
])
final Serializers serializers = _$serializers;

class SettingsApiSerializer {
  SettingsApiSerializer() {
    _standardSerializers = (serializers.toBuilder()
          ..addPlugin(StandardJsonPlugin())
          ..addBuilderFactory(
              const FullType(BuiltList, [FullType(Exercise)]), () => ListBuilder<Exercise>())
          ..addBuilderFactory(
              const FullType(BuiltMap, [FullType(ExerciseTier), FullType(BuiltList<Exercise>)]),
              () => MapBuilder<ExerciseTier, BuiltList<Exercise>>))
        .build();
  }

  late final Serializers _standardSerializers;

  AppSettings? appSettingsFromJson(String? json) =>
      _standardSerializers.deserializeWith(AppSettings.serializer, jsonDecode(json ?? ''));

  String? appSettingsToJson(AppSettings settings) {
    final serializedValue = _standardSerializers.serializeWith(AppSettings.serializer, settings);
    if (serializedValue != null) {
      return jsonEncode(serializedValue);
    }
    return null;
  }

  ExerciseSettings? exerciseSettingsFromJson(String? json) =>
      _standardSerializers.deserializeWith(ExerciseSettings.serializer, jsonDecode(json ?? ''));

  String? exerciseSettingsToJson(ExerciseSettings settings) {
    final serializedValue =
        _standardSerializers.serializeWith(ExerciseSettings.serializer, settings);
    if (serializedValue != null) {
      return jsonEncode(serializedValue);
    }
    return null;
  }
}
