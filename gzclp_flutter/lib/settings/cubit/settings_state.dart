part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState({required this.appSettings});

  final AppSettings appSettings;

  @override
  List<Object> get props => [appSettings];
}
