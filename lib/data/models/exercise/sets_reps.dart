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
}
