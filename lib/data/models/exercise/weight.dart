import "package:intl/intl.dart";

class Weight {
  double kg;

  Weight(this.kg);

  @override
  String toString() {
    NumberFormat formatter = NumberFormat();
    formatter.minimumExponentDigits = 0;
    formatter.maximumFractionDigits = 2;
    return '${formatter.format(kg)}kg';
  }
}
