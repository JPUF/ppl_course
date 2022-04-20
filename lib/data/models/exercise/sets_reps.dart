import 'dart:convert';

class SetsReps {
  late int sets;
  late int reps;
  bool amrapFinalSet;

  SetsReps(
      {required this.sets, required this.reps, this.amrapFinalSet = false});

  @override
  String toString() {
    if (amrapFinalSet) {
      if (sets > 1) {
        return "${sets - 1}×$reps\n1×$reps+";
      } else {
        return "1×$reps+";
      }
    } else {
      return "$sets×$reps";
    }
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'sets': sets});
    result.addAll({'reps': reps});
    result.addAll({'amrapFinalSet': amrapFinalSet});
  
    return result;
  }

  factory SetsReps.fromMap(Map<String, dynamic> map) {
    final sets = map['sets'];
    final reps = map['reps'];
    return SetsReps(
      sets: sets,
      reps: reps,
      amrapFinalSet: map['amrapFinalSet'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SetsReps.fromJson(String source) => SetsReps.fromMap(json.decode(source));
}
