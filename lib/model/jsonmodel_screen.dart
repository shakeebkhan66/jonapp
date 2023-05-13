class JsonModelClass {
  String? name;
  String? message;
  String? time;
  List<String>? footerIcons;

  JsonModelClass({this.name, this.message, this.time, this.footerIcons});

  factory JsonModelClass.fromJson(Map<String, dynamic> json) {
    return JsonModelClass(
      name: json['name'],
      message: json['message'],
      time: json['time'],
      footerIcons: json['footerIcons'] != null ? List<String>.from(json['footerIcons']) : [],
    );
  }
}