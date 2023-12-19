import 'package:flutter/material.dart';

import 'package:car_pool_app/Model%20Classes/order.dart';
import 'package:car_pool_app/Widgets/tracking_item.dart';

import 'package:timeline_tile/timeline_tile.dart';

class TrackingColumn extends StatelessWidget {
  const TrackingColumn({
    super.key,
    required this.status,
  });

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PendingItem(
          status: status,
        ),

        status == OrderStatus.pending || status == OrderStatus.approved || status == OrderStatus.completed ? Column(
          children: [
            ApprovedItem(
              status: status,
            ),

            CompletedItem(
              status: status,
            ),
          ],
        ) : const SizedBox.shrink(),

        status == OrderStatus.canceled ? const CanceledItem() : const SizedBox.shrink(),

        status == OrderStatus.rejected ? const RejectedItem() : const SizedBox.shrink(),
      ],
    );
  }
}

class PendingItem extends StatelessWidget {
  const PendingItem({
    super.key,
    required this.status,
  });

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {

    final isPending = status == OrderStatus.pending;

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: true,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: isPending ? const Color(0xFF2B619C) : const Color(0xFF27AA69),
        padding: const EdgeInsets.all(6),
      ),
      endChild: TrackingItem(
        icon: Icons.pending,
        title: 'Pending',
        message: "Waiting for driver's confirmation",
        enabled: isPending,
      ),
      afterLineStyle: LineStyle(
        color: isPending ? const Color(0xFFDADADA) : const Color(0xFF27AA69),
      ),
    );
  }
}

class ApprovedItem extends StatelessWidget {
  const ApprovedItem({
    super.key,
    required this.status,
  });

  final OrderStatus status;

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
    if(isApproved|| isCompleted) {
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

    final isApproved = status == OrderStatus.approved;

    final isCompleted = status == OrderStatus.completed;

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: getIndicatorColor(isApproved, isCompleted),
        padding: const EdgeInsets.all(6),
      ),
      endChild: TrackingItem(
        enabled: isApproved,
        icon: Icons.check_circle,
        title: 'Approved',
        message: "Trip has been approved !",
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

class CompletedItem extends StatelessWidget {
  const CompletedItem({
    super.key,
    required this.status,
  });

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {

    final isCompleted = status == OrderStatus.completed;

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
        enabled: isCompleted,
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
        message: "Driver Canceled the Trip",
        enabled: true,
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
        enabled: true,
      ),
      beforeLineStyle: const LineStyle(
        color: Color(0xFF27AA69),
      ),
    );
  }
}