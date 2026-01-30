import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool showTrend;
  final double? trendPercentage;
  final bool isPositiveTrend;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.showTrend = false,
    this.trendPercentage,
    this.isPositiveTrend = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and title row
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (backgroundColor ?? AppColors.primaryLight).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: 24,
                      color: iconColor ?? AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  if (showTrend && trendPercentage != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (isPositiveTrend ? AppColors.success : AppColors.error).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPositiveTrend ? Icons.trending_up : Icons.trending_down,
                            size: 16,
                            color: isPositiveTrend ? AppColors.success : AppColors.error,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${trendPercentage!.abs().toStringAsFixed(1)}%',
                            style: AppTextStyles.caption.copyWith(
                              color: isPositiveTrend ? AppColors.success : AppColors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Amount
              Text(
                amount,
                style: AppTextStyles.amountMedium.copyWith(
                  color: Get.theme.colorScheme.onSurface,
                ),
              ),
              
              const SizedBox(height: 4),
              
              // Title
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Compact variant for horizontal scrolling
class CompactSummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double? width;

  const CompactSummaryCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 160,
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (backgroundColor ?? AppColors.primaryLight).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: iconColor ?? AppColors.primary,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Amount
                Text(
                  amount,
                  style: AppTextStyles.amountSmall.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Title
                Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
