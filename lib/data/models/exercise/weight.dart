import 'dart:convert';

import "package:intl/intl.dart";

class Weight {
  double kg;

  Weight(this.kg);

  @override
  String toString() {
    return '${formattedKg()}kg';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'kg': kg});

    return result;
  }

  factory Weight.fromMap(Map<String, dynamic> map) {
    return Weight(
      map['kg']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Weight.fromJson(String source) => Weight.fromMap(json.decode(source));
}

extension DoubleFormat on Weight {
  String formattedKg() {
    NumberFormat formatter = NumberFormat();
    formatter.minimumExponentDigits = 0;
    formatter.maximumFractionDigits = 1;
    return formatter.format(kg);
  }
}
