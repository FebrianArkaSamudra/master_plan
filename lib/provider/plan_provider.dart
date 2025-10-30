
import 'package:flutter/material.dart';
import '../models/plan.dart';

class PlanProvider extends InheritedNotifier<ValueNotifier<List<Plan>>> {
  const PlanProvider({
    super.key,
    required ValueNotifier<List<Plan>> notifier,
    required super.child,
  }) : super(notifier: notifier);

  static ValueNotifier<List<Plan>> of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PlanProvider>()!.notifier!;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<ValueNotifier<List<Plan>>> oldWidget) {
    return notifier != oldWidget.notifier;
  }
}
