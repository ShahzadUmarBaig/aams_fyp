class Class {
  final String className;
  final DateTime classTime;

  Class({
    required this.className,
    required this.classTime,
  });

  factory Class.fromMap(Map<String, dynamic> json) {
    return Class(
      className: json["className"],
      classTime: DateTime.parse(json["classTime"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "className": className,
      "classTime": classTime.toIso8601String(),
    };
  }
}
