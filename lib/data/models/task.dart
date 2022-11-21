class Task {
  String id;
  String? description;
  String title;
  String? ptsValue;
  String minsToNotification;
  String isHidden;
  String isCompleted;
  String createdDate;
  String dueDate;
  String completedDate;
  Task({
    required this.id,
    required this.title,
    this.ptsValue,
    required this.minsToNotification,
    required this.isHidden,
    required this.createdDate,
    required this.isCompleted,
    required this.dueDate,
    required this.completedDate
  });
}