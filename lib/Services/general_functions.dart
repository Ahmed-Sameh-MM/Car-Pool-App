String durationToTime(Duration duration) {
  String meridiem = 'AM';

  if(duration.inHours > 12) {
    meridiem = 'PM';
    duration -= const Duration(hours: 12);
  }

  final minutes = duration.inMinutes.remainder(60);

  return '${duration.inHours}:$minutes $meridiem';
}