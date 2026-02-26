import 'dart:ui';
import 'package:resipal_core/src/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/src/domain/enums/maintenance_fee_status.dart';
import 'package:resipal_core/src/presentation/shared/colors/base_app_colors.dart';

class MaintenanceColors {

  static Color getColor(MaintenanceFeeEntity maintenance) {
    switch (maintenance.status) {
      case MaintenanceFeeStatus.paid:
        return BaseAppColors.success;
      case MaintenanceFeeStatus.pending:
        return BaseAppColors.warning;
      case MaintenanceFeeStatus.overdue:
        return BaseAppColors.danger;
      case MaintenanceFeeStatus.upcoming:
        return BaseAppColors.info;
    }
  }
}