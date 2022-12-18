class TaskStatus {
  int? status;
  int? code;

  TaskStatus({this.status, this.code});

  TaskStatus.fromJson(Map<String, dynamic> json) {
    status = (json['status'] == -1) ? 0 : json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    return data;
  }
}