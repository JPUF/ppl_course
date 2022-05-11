import 'package:ppl_course/common/utils/date_time_day.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';

class SessionLog {
  final Weight totalVolume;
  final DateTimeDay dateTime;

  SessionLog(this.totalVolume, this.dateTime);
}
