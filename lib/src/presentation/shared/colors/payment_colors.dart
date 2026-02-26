import 'dart:ui';
import 'package:resipal_core/src/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/src/domain/enums/payment_status.dart';
import 'package:resipal_core/src/presentation/shared/colors/base_app_colors.dart';

class PaymentColors {
  static Color getColor(PaymentEntity payment) {
    switch (payment.status) {
      case PaymentStatus.approved:
        return BaseAppColors.success;
      case PaymentStatus.pendingReview:
        return BaseAppColors.warning;
      case PaymentStatus.cancelled:
        return BaseAppColors.danger;
      case PaymentStatus.unknown:
        return BaseAppColors.info;
    }
  }
}
