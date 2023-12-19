import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Model%20Classes/trip.dart';
import 'package:driver_car_pool_app/Widgets/tracking_item.dart';

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
        OpenItem(
          status: status,
        ),

        status == TripStatus.canceled ? const CanceledItem() : Column(
          children: [
            ApprovedItem(
              status: status,
            ),
            
            CompletedItem(
              status: status,
            ),
          ],
        ),
      ],
    );
  }
}

class OpenItem extends StatelessWidget {
  const OpenItem({
    super.key,
    required this.status,
  });

  final TripStatus status;

  @override
  Widget build(BuildContext context) {

    final isOpen = status == TripStatus.open;

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: true,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: isOpen ? const Color(0xFF2B619C) :const Color(0xFF27AA69),
        padding: const EdgeInsets.all(6),
      ),
      endChild: TrackingItem(
        icon: Icons.pending,
        title: 'Open',
        message: "Open for Any User",
        enabled: isOpen,
      ),
      afterLineStyle: LineStyle(
        color: isOpen ? const Color(0xFFDADADA) : const Color(0xFF27AA69),
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
        color: isCompleted ?const Color(0xFF27AA69) : Colors.grey,
        padding: const EdgeInsets.all(6),
      ),
      endChild: TrackingItem(
        icon: Icons.flag,
        title: 'Completed',
        message: "Trip's Done",
        enabled: isCompleted,
      ),
      beforeLineStyle: LineStyle(
        color: isCompleted ? const Color(0xFF27AA69) : const Color(0xFFDADADA),
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

  Color getIndicatorColor(bool isApproved, bool isCompleted) {
    if(isApproved) {
      return const Color(0xFF2B619C);
    }
    else {
      if(isCompleted) {
        return const Color(0xFF27AA69);
      }
    }

    return Colors.grey;
  }

  Color getBeforeLineColor(bool isApproved, bool isCompleted) {
    if(isApproved || isCompleted) {
      return const Color(0xFF27AA69);
    }

    return const Color(0xFFDADADA);
  }

  Color getAfterLineColor(bool isCompleted) {
    if(isCompleted) {
      return const Color(0xFF27AA69);
    }

    return const Color(0xFFDADADA);
  }

  @override
  Widget build(BuildContext context) {

    final isApproved = status == TripStatus.approved;

    final isCompleted = status == TripStatus.completed;

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: getIndicatorColor(isApproved, isCompleted),
        padding: const EdgeInsets.all(6),
      ),
      endChild: TrackingItem(
        icon: Icons.check_circle,
        iconColor: Colors.green,
        title: 'Approved',
        message: "Drived Approved the Trip",
        enabled: isApproved,
      ),
      beforeLineStyle: LineStyle(
        color: getBeforeLineColor(isApproved, isCompleted),
      ),
      afterLineStyle: LineStyle(
        color: getAfterLineColor(isCompleted),
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
        message: "You've canceled The Trip",
        enabled: true,
      ),
      beforeLineStyle: const LineStyle(
        color: Color(0xFF27AA69),
      ),
    );
  }
}