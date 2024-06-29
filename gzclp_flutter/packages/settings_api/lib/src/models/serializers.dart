import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/serializer.dart';

import 'app_settings.dart';

part 'serializers.g.dart';

class SettingsApiSerializer {
  SettingsApiSerializer() {
    _standardSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
  }

  late final Serializers _standardSerializers;

  @SerializersFor([
    AppSettings,
  ])
  final Serializers serializers = _$serializers;

  AppSettings? appSettingsFromJson(String json) =>
      _standardSerializers.deserializeWith(AppSettings.serializer, json);

  String? appSettingsToJson(AppSettings settings) =>
      _standardSerializers.serializeWith(AppSettings.serializer, settings)?.toString();
}
