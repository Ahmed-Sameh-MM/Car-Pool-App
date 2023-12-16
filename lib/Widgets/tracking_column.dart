import 'package:car_pool_app/Model%20Classes/trip.dart';
import 'package:car_pool_app/Widgets/tracking_item.dart';
import 'package:flutter/material.dart';

import 'package:timeline_tile/timeline_tile.dart';

class TrackingColumn extends StatelessWidget {
  const TrackingColumn({
    super.key,
    required this.status,
  });

  final TripStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PendingItem(),

        status == TripStatus.pending || status == TripStatus.approved || status == TripStatus.completed ? Column(
          children: [
            ApprovedItem(
              status: status,
            ),

            CompletedItem(
              status: status,
            ),
          ],
        ) : const SizedBox.shrink(),

        status == TripStatus.canceled ? const CanceledItem() : const SizedBox.shrink(),

        status == TripStatus.rejected ? const RejectedItem() : const SizedBox.shrink(),
      ],
    );
  }
}

class PendingItem extends StatelessWidget {
  const PendingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: true,
      indicatorStyle: const IndicatorStyle(
        width: 20,
        color: Color(0xFF27AA69),
        padding: EdgeInsets.all(6),
      ),
      endChild: const TrackingItem(
        icon: Icons.pending,
        title: 'Pending',
        message: "Waiting for driver's confirmation",
      ),
      beforeLineStyle: const LineStyle(
        color: Color(0xFF27AA69),
      ),
    );
  }
}

class ApprovedItem extends StatelessWidget {
  const ApprovedItem({
    super.key,
    required this.status,
  });

  final TripStatus status;

  @override
  Widget build(BuildContext context) {

    final isApproved = status == TripStatus.approved;

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: isApproved ?const Color(0xFF2B619C) : const Color(0xFF27AA69),
        padding: const EdgeInsets.all(6),
      ),
      endChild: TrackingItem(
        disabled: isApproved,
        icon: Icons.check_circle,
        title: 'Approved',
        message: "Trip has been approved !",
      ),
      beforeLineStyle: LineStyle(
        color: isApproved ? const Color(0xFF27AA69) : const Color(0xFFDADADA),
      ),
    );
  }
}

class CompletedItem extends StatelessWidget {
  const CompletedItem({
    super.key,
    required this.status,
  });

  final TripStatus status;

  @override
  Widget build(BuildContext context) {

    final isCompleted = status == TripStatus.completed;

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isLast: true,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: isCompleted ?const Color(0xFF27AA69) : const Color(0xFF2718278),
        padding: const EdgeInsets.all(6),
      ),
      endChild: TrackingItem(
        icon: Icons.flag,
        title: 'Completed',
        message: "Trip's Done",
        disabled: isCompleted,
      ),
      beforeLineStyle: LineStyle(
        color: isCompleted ? const Color(0xFF27AA69) : const Color(0xFFDADADA),
      ),
    );
  }
}

class RejectedItem extends StatelessWidget {
  const RejectedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isLast: true,
      indicatorStyle: const IndicatorStyle(
        width: 20,
        color: Color(0xFF27AA69),
        padding: EdgeInsets.all(6),
      ),
      endChild: const TrackingItem(
        icon: Icons.cancel,
        iconColor: Colors.red,
        title: 'Rejected',
        message: "Drived Rejected",
      ),
      beforeLineStyle: const LineStyle(
        color: Color(0xFF27AA69),
      ),
    );
  }
}

class CanceledItem extends StatelessWidget {
  const CanceledItem({super.key});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isLast: true,
      indicatorStyle: const IndicatorStyle(
        width: 20,
        color: Color(0xFF27AA69),
        padding: EdgeInsets.all(6),
      ),
      endChild: const TrackingItem(
        icon: Icons.cancel,
        iconColor: Colors.grey,
        title: 'Canceled',
        message: "You've canceled Your Request",
      ),
      beforeLineStyle: const LineStyle(
        color: Color(0xFF27AA69),
      ),
    );
  }
}