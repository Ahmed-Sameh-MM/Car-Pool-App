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
    hours: -24 + 22,
    minutes: 00,
  ),

  "5:30 PM": Duration(
    hours: 13,
    minutes: 00,
  ),
};

Map<Duration, String> timeConstraintsErrorMessages = {
  const Duration(
    hours: 7,
    minutes: 30,
  ): "10:00 PM Yesterday",

  const Duration(
    hours: 17,
    minutes: 30,
  ): "1:00 PM Today",
};

const Map<String, Duration> approvalTimeConstraints = {
  "7:30 AM": Duration(
    hours: -24 + 23,
    minutes: 30,
  ),

  "5:30 PM": Duration(
    hours: 16,
    minutes: 30,
  ),
};

Map<Duration, String> approvalErrorMessages = {
  const Duration(
    hours: 7,
    minutes: 30,
  ): "11:30 PM Yesterday",

  const Duration(
    hours: 17,
    minutes: 30,
  ): "4:30 PM Today",
};