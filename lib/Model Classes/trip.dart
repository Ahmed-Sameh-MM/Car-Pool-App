import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

enum TripStatus { // Can be active or previous, there can be only one active reservation
  rejected,
  pending,
  approved,
}

@JsonSerializable()
class Trip {
  String id;
  double price;
  String source;
  String destination;
  DateTime currentDate;
  DateTime tripDate;
  Duration time;
  TripStatus status;

  Trip({
    required this.id,
    required this.price,
    required this.source,
    required this.destination,
    required this.currentDate,
    required this.tripDate,
    required this.time,
    required this.status,
  });

  Trip.empty({
    this.id = "",
    this.price = 10,
    this.source = "",
    this.destination = "",
    this.time = Duration.zero,
    this.status = TripStatus.pending,
  }) : currentDate = DateTime(2024), tripDate = DateTime(2024);

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);

  static String statusToString(TripStatus bookingStatus) {

    const Map<TripStatus, String> statusMap = {
      TripStatus.rejected: 'rejected',
      TripStatus.pending: 'pending',
      TripStatus.approved: 'approved',
    };

    return statusMap[bookingStatus]!;
  }

  static TripStatus stringToStatus(String bookingStatus) {

    const Map<String, TripStatus> statusMap = {
      'rejected': TripStatus.rejected,
      'pending': TripStatus.pending,
      'approved': TripStatus.approved,
    };

    return statusMap[bookingStatus] as TripStatus;
  }
}