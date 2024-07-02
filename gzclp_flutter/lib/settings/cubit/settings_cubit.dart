import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:settings_repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository) : super(SettingsState(appSettings: AppSettings.withDefaults()));

  final SettingsRepository _repository;

  void setBarWeight(BarWeight barWeight) {
    final newSettings = state.appSettings.rebuild((b) => b.barWeight = barWeight);
    _repository.saveAppSettings(newSettings);
    emit(SettingsState(appSettings: newSettings));
  }

  void setGender(Gender gender) {
    final newSettings = state.appSettings.rebuild((b) => b.gender = gender);
    _repository.saveAppSettings(newSettings);
    emit(SettingsState(appSettings: newSettings));
  }

  void setMicroplates(bool microplates) {
    final newSettings = state.appSettings.rebuild((b) => b.microplates = microplates);
    _repository.saveAppSettings(newSettings);
    emit(SettingsState(appSettings: newSettings));
  }

  void setUnits(WeightUnit units) {
    final newSettings = state.appSettings.rebuild((b) => b.units = units);
    _repository.saveAppSettings(newSettings);
    emit(SettingsState(appSettings: newSettings));
  }
}
