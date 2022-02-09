class SetsReps {
  int? sets;
  int? minReps;
  int? maxReps;
  int? endSetReps;

  SetsReps.fixed(this.sets, this.minReps);

  SetsReps.fixedEndSet(this.sets, this.minReps, this.endSetReps);

  SetsReps.range(this.sets, this.minReps, this.maxReps);

  SetsReps.rangeEndSet(this.sets, this.minReps, this.maxReps, this.endSetReps);

  SetsReps.endSetOnly(this.endSetReps);

  @override
  String toString() {
    var setString = '';
    if (sets != null && minReps != null) {
      var firstReps = '$minReps';
      if (maxReps != null) {
        firstReps += '–$maxReps';
      }
      setString += '${sets}x$firstReps';
      if (endSetReps != null) {
        setString += ', 1x$endSetReps+';
      }
    } else {
      setString += '1x$endSetReps+';
    }
    return setString;
  }
}
