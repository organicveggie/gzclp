import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gzclp_flutter/settings/cubit/settings_cubit.dart';
import 'package:settings_repository/settings_repository.dart';

class Tier3ExercisesPage extends StatelessWidget {
  const Tier3ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(context.read<SettingsRepository>()),
      child: const Tier3ExercisesView(),
    );
  }
}

class Tier3ExercisesView extends StatelessWidget {
  const Tier3ExercisesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tier 3 Exercises'),
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: const <Widget>[
            Text('Foo bar'),
          ],
        ),
      ),
    );
  }
}
