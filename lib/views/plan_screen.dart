
import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../provider/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;

  // convenience getter for the plan passed when opening this screen
  Plan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        // dismiss keyboard on scroll (useful on iOS)
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final currentPlan = plan;
        final planIndex =
            plansNotifier.value.indexWhere((p) => p.name == currentPlan.name);
        if (planIndex == -1) return; 

        final updatedTasks = List<Task>.from(currentPlan.tasks)..add(const Task());
        final updatedPlan = Plan(name: currentPlan.name, tasks: updatedTasks);

        plansNotifier.value = List<Plan>.from(plansNotifier.value)
          ..[planIndex] = updatedPlan;
      },
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          final currentPlan = plan;
          final planIndex =
              plansNotifier.value.indexWhere((p) => p.name == currentPlan.name);
          if (planIndex == -1) return;

          final updatedTasks = List<Task>.from(currentPlan.tasks)
            ..[index] = Task(
              description: task.description,
              complete: selected ?? false,
            );

          final updatedPlan = Plan(name: currentPlan.name, tasks: updatedTasks);
          plansNotifier.value = List<Plan>.from(plansNotifier.value)
            ..[planIndex] = updatedPlan;
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          final currentPlan = plan;
          final planIndex =
              plansNotifier.value.indexWhere((p) => p.name == currentPlan.name);
          if (planIndex == -1) return;

          final updatedTasks = List<Task>.from(currentPlan.tasks)
            ..[index] = Task(description: text, complete: task.complete);

          final updatedPlan = Plan(name: currentPlan.name, tasks: updatedTasks);
          plansNotifier.value = List<Plan>.from(plansNotifier.value)
            ..[planIndex] = updatedPlan;
        },
      ),
    );
  }

  Widget _buildList(Plan currentPlan) {
    return ListView.builder(
      controller: scrollController,
      keyboardDismissBehavior:
          Theme.of(context).platform == TargetPlatform.iOS
              ? ScrollViewKeyboardDismissBehavior.onDrag
              : ScrollViewKeyboardDismissBehavior.manual,
      itemCount: currentPlan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(currentPlan.tasks[index], index, context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          final Plan currentPlan =
              plans.firstWhere((p) => p.name == plan.name, orElse: () => plan);

          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentPlan.completenessMessage,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }
}
