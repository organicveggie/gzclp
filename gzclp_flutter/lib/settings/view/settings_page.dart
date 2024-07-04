import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gzclp_flutter/settings/cubit/settings_cubit.dart';
import 'package:settings_repository/settings_repository.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(context.read<SettingsRepository>()),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  static const rowHeight = 50.0;
  static const maxRowWidth = 400.0;

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            SettingRowInputWidget(
              icon: const Icon(Icons.wc),
              label: 'Gender',
              child: DropdownMenu<Gender>(
                initialSelection:
                    context.select((SettingsCubit cubit) => cubit.state.appSettings.gender),
                requestFocusOnTap: true,
                onSelected: (Gender? newValue) {
                  context.read<SettingsCubit>().setGender(newValue ?? Gender.xy);
                },
                dropdownMenuEntries: Gender.values.map<DropdownMenuEntry<Gender>>((g) {
                  return DropdownMenuEntry(
                    value: g,
                    label: g.name,
                  );
                }).toList(),
              ),
            ),
            SettingRowInputWidget(
              icon: const Icon(Icons.scale),
              label: 'Weight units',
              child: DropdownMenu<WeightUnit>(
                initialSelection:
                    context.select((SettingsCubit cubit) => cubit.state.appSettings.units),
                requestFocusOnTap: true,
                onSelected: (WeightUnit? newValue) {
                  context.read<SettingsCubit>().setUnits(newValue ?? WeightUnit.lb);
                },
                dropdownMenuEntries: WeightUnit.values.map<DropdownMenuEntry<WeightUnit>>((w) {
                  return DropdownMenuEntry(
                    value: w,
                    label: w.name,
                  );
                }).toList(),
              ),
            ),
            SettingRowInputWidget(
              icon: const Icon(Icons.fitness_center),
              label: 'Bar Weight',
              child: DropdownMenu<BarWeight>(
                initialSelection:
                    context.select((SettingsCubit cubit) => cubit.state.appSettings.barWeight),
                requestFocusOnTap: true,
                onSelected: (BarWeight? newValue) {
                  context.read<SettingsCubit>().setBarWeight(newValue ?? BarWeight.kg20);
                },
                dropdownMenuEntries: BarWeight.values.map<DropdownMenuEntry<BarWeight>>((b) {
                  return DropdownMenuEntry(
                    value: b,
                    label: b.name,
                  );
                }).toList(),
              ),
            ),
            SettingRowInputWidget(
              icon: const Icon(Icons.zoom_out),
              label: 'Microplates',
              child: Switch(
                value: context.select((SettingsCubit cubit) => cubit.state.appSettings.microplates),
                onChanged: (newValue) {
                  context.read<SettingsCubit>().setMicroplates(newValue);
                },
              ),
            ),
            SettingRowListTile(
              leadingIcon: const Icon(Icons.military_tech),
              trailingIcon: const Icon(Icons.arrow_right),
              title: 'Tier 1 Exercises',
              rowHeight: rowHeight,
              maxRowWidth: maxRowWidth,
              onTap: () => log('ListTile for Tier 1 Exercises'),
            ),
            SettingRowListTile(
              leadingIcon: const Icon(Icons.military_tech),
              trailingIcon: const Icon(Icons.arrow_right),
              title: 'Tier 2 Exercises',
              rowHeight: rowHeight,
              maxRowWidth: maxRowWidth,
              onTap: () => log('ListTile for Tier 2 Exercises'),
            ),
            SettingRowListTile(
              leadingIcon: const Icon(Icons.military_tech),
              trailingIcon: const Icon(Icons.arrow_right),
              title: 'Tier 3 Exercises',
              rowHeight: rowHeight,
              maxRowWidth: maxRowWidth,
              onTap: () => log('ListTile for Tier 3 Exercises'),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class SettingRowWidget extends StatelessWidget {
  static const defaultRowHeight = 50.0;
  static const defaultMaxRowWidth = 400.0;

  const SettingRowWidget({
    this.rowHeight = defaultRowHeight,
    this.maxRowWidth = defaultMaxRowWidth,
    super.key,
  });

  final double rowHeight;
  final double maxRowWidth;

  Widget buildChild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: rowHeight,
        child: Container(
          constraints: BoxConstraints(maxHeight: rowHeight, maxWidth: maxRowWidth),
          child: buildChild(context),
        ),
      ),
    );
  }
}

class SettingRowInputWidget extends SettingRowWidget {
  const SettingRowInputWidget({
    required this.icon,
    required this.label,
    required this.child,
    super.rowHeight,
    super.maxRowWidth,
    super.key,
  });

  final Icon icon;
  final String label;
  final Widget child;

  @override
  Widget buildChild(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: icon,
        ),
        Text(label),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: child,
          ),
        ),
      ],
    );
  }
}

class SettingRowListTile extends SettingRowWidget {
  const SettingRowListTile({
    this.leadingIcon,
    this.trailingIcon,
    required this.title,
    super.rowHeight,
    super.maxRowWidth,
    required this.onTap,
    super.key,
  });

  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final String title;

  final Function() onTap;

  @override
  Widget buildChild(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding: const EdgeInsets.all(0.0),
        leading: leadingIcon,
        title: Text(title),
        trailing: trailingIcon,
        onTap: onTap,
      ),
    );
  }
}
