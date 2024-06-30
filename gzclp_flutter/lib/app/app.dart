import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gzclp_flutter/home/view/view.dart';
import 'package:gzclp_flutter/theme/theme.dart';
import 'package:settings_repository/settings_repository.dart';

class App extends StatelessWidget {
  const App({required this.settingsRepository, super.key});

  final SettingsRepository settingsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: settingsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GzlcpTheme.light,
      darkTheme: GzlcpTheme.dark,
      home: const HomePage(),
    );
  }
}
