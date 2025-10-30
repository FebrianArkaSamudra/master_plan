class Task {
  final String description;
  final bool complete;

  const Task({
    this.description = '',
    this.complete = false,
  });

  Task copyWith({String? description, bool? complete}) {
    return Task(
      description: description ?? this.description,
      complete: complete ?? this.complete,
    );
  }
}