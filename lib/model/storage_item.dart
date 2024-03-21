class StorageItem {
  final String hostname;
  final String code;

  StorageItem({required this.hostname, required this.code});

  Map<String, String> toJson() {
    return {
      "hostname": hostname,
      "code": code,
    };
  }

  factory StorageItem.fromJson(Map<String, dynamic> json) {
    return StorageItem(
      hostname: json["hostname"],
      code: json["code"],
    );
  }

  @override
  String toString() {
    return "StorageItem{hostname: $hostname, code: $code}";
  }
}
