class NotificationModel {
  final String? message;

  NotificationModel(this.message);

  factory NotificationModel.fromFirestore(Map<String, dynamic> json) {
    return NotificationModel(json['message']);
  }
}
