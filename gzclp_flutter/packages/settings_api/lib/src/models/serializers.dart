import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/serializer.dart';

import 'models.dart';

part 'serializers.g.dart';

@SerializersFor([
  AppSettings,
  BarWeight,
  Exercise,
  Gender,
  WeightUnit,
])
final Serializers serializers = _$serializers;

class SettingsApiSerializer {
  SettingsApiSerializer() {
    _standardSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
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
}
