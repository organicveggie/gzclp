import 'dart:developer';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gzclp_flutter/settings/cubit/settings_cubit.dart';
import 'package:settings_repository/settings_repository.dart';

const _settingLabelWidth = 200.0;

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
  static const labelWidth = 200;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 50.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          constraints: const BoxConstraints(maxHeight: 50.0, maxWidth: 400),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(Icons.wc),
                              ),
                              const Text('Gender'),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: DropdownMenu<Gender>(
                                    initialSelection: context.select(
                                        (SettingsCubit cubit) => cubit.state.appSettings.gender),
                                    requestFocusOnTap: true,
                                    onSelected: (Gender? newValue) {
                                      context
                                          .read<SettingsCubit>()
                                          .setGender(newValue ?? Gender.xy);
                                    },
                                    dropdownMenuEntries:
                                        Gender.values.map<DropdownMenuEntry<Gender>>((g) {
                                      return DropdownMenuEntry(
                                        value: g,
                                        label: g.name,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
    // return Card(
    //   shadowColor: Colors.transparent,
    //   margin: const EdgeInsets.all(8.0),
    //   child: SizedBox.expand(
    //     child: Column(children: [
    //       GenderDropdownWidget(),
    //       Padding(padding: const EdgeInsets.only(top: 5), child: WeightUnitDropdownWidget()),
    //       const Padding(padding: EdgeInsets.only(top: 5), child: MicroplatesSettingWidget()),
    //       Padding(padding: const EdgeInsets.only(top: 5), child: BarWeightDropdownWidget()),
    //     ]),
    //   ),
    // );
  }
}

class BarWeightDropdownWidget extends DropdownSettingWidget<BarWeight> {
  BarWeightDropdownWidget({super.key})
      : super(
            label: 'BarWeight',
            getSettingFn: (settings) => settings.barWeight,
            setSettingFn: (cubit, newValue) => cubit.setBarWeight(newValue ?? BarWeight.kg20),
            values: BuiltMap.from(<BarWeight, String>{
              BarWeight.kg15: '15 kg / 30 lbs',
              BarWeight.kg20: '20 kg / 45 lbs'
            }));
}

class GenderDropdownWidget extends DropdownSettingWidget<Gender> {
  GenderDropdownWidget({super.key})
      : super(
            label: 'Gender',
            getSettingFn: (settings) => settings.gender,
            setSettingFn: (cubit, newValue) => cubit.setGender(newValue ?? Gender.xy),
            values: BuiltMap.from(<Gender, String>{for (var v in Gender.values) v: v.name}));
}

class WeightUnitDropdownWidget extends DropdownSettingWidget<WeightUnit> {
  WeightUnitDropdownWidget({super.key})
      : super(
            label: 'Weight units',
            getSettingFn: (settings) => settings.units,
            setSettingFn: (cubit, newValue) => cubit.setUnits(newValue ?? WeightUnit.kg),
            values:
                BuiltMap.from(<WeightUnit, String>{for (var v in WeightUnit.values) v: v.name}));
}

class DropdownSettingWidget<T> extends StatelessWidget {
  const DropdownSettingWidget(
      {required this.label,
      required this.getSettingFn,
      required this.setSettingFn,
      required this.values,
      super.key});

  final String label;
  final T Function(AppSettings settings) getSettingFn;
  final void Function(SettingsCubit cubit, T? newValue) setSettingFn;
  final BuiltMap<T, String> values;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
            child: SizedBox(width: _settingLabelWidth, child: Text(label))),
        DropdownMenu<T>(
          initialSelection:
              context.select((SettingsCubit cubit) => getSettingFn(cubit.state.appSettings)),
          requestFocusOnTap: true,
          onSelected: (T? newValue) {
            setSettingFn(context.read<SettingsCubit>(), newValue);
          },
          dropdownMenuEntries: values.entries.map<DropdownMenuEntry<T>>((entry) {
            return DropdownMenuEntry(
              value: entry.key,
              label: entry.value,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class MicroplatesSettingWidget extends StatelessWidget {
  const MicroplatesSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
          child: SizedBox(width: _settingLabelWidth, child: Text('Microplates')),
        ),
        Switch(
          value: context.select((SettingsCubit cubit) => cubit.state.appSettings.microplates),
          onChanged: (newValue) {
            context.read<SettingsCubit>().setMicroplates(newValue);
          },
        ),
      ],
    );
  }
}
