import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gzclp_flutter/home/view/view.dart';
import 'package:gzclp_flutter/settings/view/settings_page.dart';
import 'package:gzclp_flutter/start/cubit/start_cubit.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StartCubit(),
      child: const StartView(),
    );
  }
}

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    final int selectedPageIndex = context.select((StartCubit cubit) => cubit.state.pageIndex);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          log('Old index: $selectedPageIndex, new index: $index');
          context.read<StartCubit>().setPageIndex(index);
        },
        selectedIndex: selectedPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: const <Widget>[
        HomePage(),
        SettingsPage(),
      ][selectedPageIndex],
    );
  }
}
