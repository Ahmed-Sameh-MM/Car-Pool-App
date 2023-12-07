const emailDomain = "@eng.asu.edu.eg";

const List<String> gates = ['Gate 3', 'Gate 4'];

enum RouteType {
  none,
  ainshamsToAny,
  anyToAinshams,
}

const List<Duration> timeSlots = [
  Duration(
    hours: 7,
    minutes: 30,
  ),

  Duration(
    hours: 17,
    minutes: 30,
  ),
];

const Map<String, Duration> timeConstraints = {
  "7:30 AM": Duration(
    hours: -24 - 9,
    minutes: -30,
  ),

  "5:30 PM": Duration(
    hours: 13,
    minutes: 00,
  ),
};