import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

enum TripStatus { // Can be active or previous, there can be only one active reservation
  active,
  cancelled,
  pending,
  approved,
  expired,
  confirmed,
}

@JsonSerializable()
class Trip {
  int id;
  double price;
  String source;
  String destination;
  DateTime date;
  Duration time;
  TripStatus status;

  Trip({
    required this.id,
    required this.price,
    required this.source,
    required this.destination,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);

  static String statusToString(TripStatus bookingStatus) {

    const Map<TripStatus, String> statusMap = {
      TripStatus.active: 'active',
      TripStatus.cancelled: 'cancelled',
      TripStatus.pending: 'pending',
      TripStatus.approved: 'approved',
      TripStatus.expired: 'expired',
      TripStatus.confirmed: 'confirmed',
    };

    return statusMap[bookingStatus]!;
  }

  static TripStatus stringToStatus(String bookingStatus) {

    const Map<String, TripStatus> statusMap = {
      'active': TripStatus.active,
      'cancelled': TripStatus.cancelled,
      'pending': TripStatus.pending,
      'approved': TripStatus.approved,
      'expired': TripStatus.expired,
      'confirmed': TripStatus.confirmed,
    };

    return statusMap[bookingStatus] as TripStatus;
  }
}