import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gzclp_flutter/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
            child: Text(
          'Home Page',
          style: theme.textTheme.titleLarge,
        )),
      ),
    );
  }
}

// class _HomeTabButton extends StatelessWidget {
//   const _HomeTabButton({
//     required this.groupValue,
//     required this.value,
//     required this.icon,
//   });

//   final HomeTab groupValue;
//   final HomeTab value;
//   final Widget icon;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () => context.read<HomeCubit>().setTab(value),
//       iconSize: 32,
//       color: groupValue != value ? null : Theme.of(context).colorScheme.secondary,
//       icon: icon,
//     );
//   }
// }
