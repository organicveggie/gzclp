import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gzclp_flutter/settings/cubit/settings_cubit.dart';
import 'package:settings_repository/settings_repository.dart';

class Tier1ExercisesPage extends StatelessWidget {
  const Tier1ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(context.read<SettingsRepository>()),
      child: const Tier1ExercisesView(),
    );
  }
}

class Tier1ExercisesView extends StatelessWidget {
  const Tier1ExercisesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tier 1 Exercises'),
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
