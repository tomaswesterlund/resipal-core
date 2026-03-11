import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class HomeOverview extends StatelessWidget {
  final CommunityEntity community;
  final UserEntity user;
  final VoidCallback onPendingPaymentsPressed;
  final VoidCallback onPendingApplicationsPressed;

  const HomeOverview({
    required this.community,
    required this.user,
    required this.onPendingPaymentsPressed,
    required this.onPendingApplicationsPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => HomeOverviewCubit()..initialize(community, user),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: BlocBuilder<HomeOverviewCubit, AdminHomeOverviewState>(
          builder: (context, state) {
            if (state is AdminHomeOverviewLoadingState) return const LoadingView();
            if (state is AdminHomeOverviewErrorState) return const ErrorView();

            if (state is AdminHomeOverviewLoadedState) {
              final community = state.community;

              return Column(
                children: [
                  HeaderText.four('¡Bienvenido, ${state.user.name}!'),
                  const SizedBox(height: 4),
                  Text(
                    community.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colorScheme.outline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  HeaderText.five('Acciones Pendientes'),
                  const SizedBox(height: 12),

                  _buildActionTile(
                    context,
                    title: 'Pagos por revisar',
                    count: community.paymentLedger.pendingPayments.length,
                    icon: Icons.receipt_long_outlined,
                    // Replaces AppColors.warning with Terracotta/Secondary
                    color: colorScheme.surfaceTint,
                    onPressed: onPendingPaymentsPressed,
                  ),
                  const SizedBox(height: 12),
                  _buildActionTile(
                    context,
                    title: 'Solicitudes de ingreso',
                    count: community.applications.length,
                    icon: Icons.person_add_outlined,
                    // Replaces AppColors.info with System/Info Tertiary
                    color: colorScheme.surfaceTint,
                    onPressed: onPendingApplicationsPressed,
                  ),
                  const SizedBox(height: 24),

                  HeaderText.five('Resumen'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      StatCard(
                        label: 'Propiedades',
                        value: community.propertyRegistry.count.toString(),
                        icon: Icons.home_work_outlined,
                      ),
                      StatCard(
                        label: 'Usuarios',
                        value: community.memberDirectory.length.toString(),
                        icon: Icons.people_outline,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      StatCard(label: 'Balance total', value: '-1', icon: Icons.home_work_outlined),

                      StatCard(
                        label: 'Deuda vencida',
                        value: CurrencyFormatter.fromCents(community.propertyRegistry.totalDebtAmountInCents),
                        icon: Icons.home_work_outlined,
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required int count,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: count > 0 ? color : color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                count.toString(),
                style: theme.textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.arrow_forward_ios, size: 14, color: colorScheme.outline),
          ],
        ),
      ),
    );
  }
}
