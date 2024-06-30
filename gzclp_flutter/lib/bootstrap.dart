import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gzclp_flutter/app/app.dart';
import 'package:gzclp_flutter/app/app_bloc_observer.dart';
import 'package:settings_api/settings_api.dart';
import 'package:settings_repository/settings_repository.dart';

void bootstrap({required SettingsApi settingsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final settingsRepo = SettingsRepository(settingsApi: settingsApi);
  runZonedGuarded(
    () => runApp(App(settingsRepository: settingsRepo)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
