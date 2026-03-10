import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';
import 'package:resipal_core/lib.dart';

class PropertyHeader extends StatelessWidget {
  final PropertyEntity property;
  final int outstandingDebtInCents;

  const PropertyHeader({required this.property, required this.outstandingDebtInCents, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool hasDebt = outstandingDebtInCents > 0;

    return DefaultCard(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Property Identification
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_work_outlined, size: 16, color: colorScheme.primary),
                const SizedBox(width: 8),
                HeaderText.three(property.name),
              ],
            ),
            const SizedBox(height: 4),

            // Resident Info
            if (property.resident != null)
              BodyText.medium(property.resident!.name, color: colorScheme.onSurfaceVariant)
            else
              const StatusBadge(color: Colors.orange, label: 'SIN RESIDENTE'),

            const SizedBox(height: 24),
            const Divider(height: 1),
            const SizedBox(height: 24),

            // Financial Status Section
            OverlineText('Deuda Pendiente'),
            const SizedBox(height: 8),
            AmountText(
              amountInCents: outstandingDebtInCents,
              fontSize: 36,
              color: hasDebt ? Colors.red : Colors.green,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            BodyText.small(hasDebt ? 'Saldo por liquidar' : 'Sin adeudos pendientes', color: colorScheme.outline),
          ],
        ),
      ),
    );
  }
}
