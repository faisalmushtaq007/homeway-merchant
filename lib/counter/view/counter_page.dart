import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemakers_merchant/app/shared/utils/app_scroll_behavior.dart';
import 'package:homemakers_merchant/app/shared/widgets/universal/theme_mode_switch_list_tile.dart';
import 'package:homemakers_merchant/counter/counter.dart';
import 'package:homemakers_merchant/l10n/l10n.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key, required this.controller});
  final ThemeController controller;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: CounterView(controller: controller),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key, required this.controller});
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ScrollConfiguration(
      behavior: const DragScrollBehavior(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
        body: SafeArea(child: const Center(child: CounterText())),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ThemeModeSwitchListTile(controller: controller),
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
