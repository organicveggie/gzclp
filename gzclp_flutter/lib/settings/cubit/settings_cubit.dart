import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:settings_repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(appSettings: AppSettings.withDefaults()));

  void setBarWeight(BarWeight barWeight) {
    final newSettings = state.appSettings.rebuild((b) => b.barWeight = barWeight);
    emit(SettingsState(appSettings: newSettings));
  }

  void setGender(Gender gender) {
    final newSettings = state.appSettings.rebuild((b) => b.gender = gender);
    emit(SettingsState(appSettings: newSettings));
  }

  void setMicroplates(bool microplates) {
    final newSettings = state.appSettings.rebuild((b) => b.microplates = microplates);
    emit(SettingsState(appSettings: newSettings));
  }

  void setUnits(WeightUnit units) {
    final newSettings = state.appSettings.rebuild((b) => b.units = units);
    emit(SettingsState(appSettings: newSettings));
  }
}
