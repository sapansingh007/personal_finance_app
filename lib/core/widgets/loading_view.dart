import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LoadingView extends StatelessWidget {
  final String message;
  final bool showShimmer;

  const LoadingView({
    super.key,
    required this.message,
    this.showShimmer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showShimmer) ...[
            ShimmerLoadingCard(height: 80),
            const SizedBox(height: 16),
            ShimmerLoadingCard(height: 80),
            const SizedBox(height: 16),
            ShimmerLoadingCard(height: 80),
          ] else ...[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
          const SizedBox(height: 24),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// Shimmer loading for cards
class ShimmerLoadingCard extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerLoadingCard({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: _ShimmerEffect(),
    );
  }
}

// Shimmer loading for transaction tiles
class ShimmerTransactionTile extends StatelessWidget {
  const ShimmerTransactionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Shimmer for icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _ShimmerEffect(),
          ),
          
          const SizedBox(width: 16),
          
          // Shimmer for text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: _ShimmerEffect(),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 120,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: _ShimmerEffect(),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Shimmer for amount
          Container(
            width: 60,
            height: 16,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: _ShimmerEffect(),
          ),
        ],
      ),
    );
  }
}

// Shimmer loading for summary cards
class ShimmerSummaryCard extends StatelessWidget {
  final double? width;

  const ShimmerSummaryCard({
    Key? key,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer for icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _ShimmerEffect(),
              ),
              
              const SizedBox(height: 16),
              
              // Shimmer for amount
              Container(
                width: 100,
                height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: _ShimmerEffect(),
              ),
              
              const SizedBox(height: 8),
              
              // Shimmer for title
              Container(
                width: 80,
                height: 14,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: _ShimmerEffect(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom shimmer effect widget
class _ShimmerEffect extends StatefulWidget {
  @override
  __ShimmerEffectState createState() => __ShimmerEffectState();
}

class __ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _animation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                Colors.transparent,
              ],
              stops: [
                0.0,
                0.5 + _animation.value / 4,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}

// Loading overlay for async operations
class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? loadingText;

  const LoadingOverlay({
    Key? key,
    required this.child,
    this.isLoading = false,
    this.loadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: LoadingView(message: loadingText ?? 'Loading...'),
          ),
      ],
    );
  }
}
