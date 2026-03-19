import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Wraps children in a shimmer effect. Adapts colors to current theme.
class SkeletonShimmer extends StatelessWidget {
  const SkeletonShimmer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE0DCD7),
      highlightColor:
          isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF5F3F0),
      child: child,
    );
  }
}

/// A rectangular skeleton placeholder line.
class SkeletonLine extends StatelessWidget {
  const SkeletonLine({
    super.key,
    this.width = double.infinity,
    this.height = 14,
    this.borderRadius = 6,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// A circular skeleton placeholder.
class SkeletonCircle extends StatelessWidget {
  const SkeletonCircle({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// A card-shaped skeleton placeholder with rounded corners.
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({
    super.key,
    this.width = double.infinity,
    this.height = 120,
    this.borderRadius = 12,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Skeleton that mimics a menu item card layout (image + text lines).
class MenuItemSkeleton extends StatelessWidget {
  const MenuItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            const SkeletonCard(width: 80, height: 80, borderRadius: 10),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonLine(width: 160, height: 14),
                  const SizedBox(height: 8),
                  SkeletonLine(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 10),
                  const SizedBox(height: 8),
                  const SkeletonLine(width: 80, height: 14),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const SkeletonCard(width: 60, height: 36, borderRadius: 12),
          ],
        ),
      ),
    );
  }
}

/// Skeleton for the loyalty dashboard (points card + tier card + transactions).
class LoyaltySkeleton extends StatelessWidget {
  const LoyaltySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Points balance card
            const SkeletonCard(height: 200, borderRadius: 16),
            const SizedBox(height: 20),
            // Tier progress card
            const SkeletonCard(height: 160, borderRadius: 12),
            const SizedBox(height: 20),
            // Transaction history header
            const SkeletonLine(width: 180, height: 16),
            const SizedBox(height: 12),
            // Transaction items
            for (int i = 0; i < 4; i++) ...[
              const SkeletonCard(height: 72, borderRadius: 10),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}

/// Skeleton for the profile screen (avatar + info + menu items).
class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar + name card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonCard(
                height: 200,
                borderRadius: 16,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(height: 24),
            // Quick actions row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(
                  4,
                  (_) => const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: SkeletonCard(height: 70, borderRadius: 12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Menu items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonCard(
                height: 350,
                borderRadius: 12,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton for the store locator screen (map + store cards).
class StoreLocatorSkeleton extends StatelessWidget {
  const StoreLocatorSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: Column(
        children: [
          // Map placeholder
          const SkeletonCard(height: 300, borderRadius: 0),
          // Store cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (int i = 0; i < 3; i++) ...[
                  const SkeletonCard(height: 180, borderRadius: 12),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton for the cart screen (item cards + summary).
class CartSkeleton extends StatelessWidget {
  const CartSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart item cards
            for (int i = 0; i < 3; i++) ...[
              const SkeletonCard(height: 130, borderRadius: 12),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 8),
            // Delivery address
            const SkeletonCard(height: 72, borderRadius: 12),
            const SizedBox(height: 16),
            // Payment method
            const SkeletonLine(width: 160, height: 16),
            const SizedBox(height: 8),
            for (int i = 0; i < 3; i++) ...[
              const SkeletonCard(height: 56, borderRadius: 10),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 8),
            // Order summary
            const SkeletonCard(height: 160, borderRadius: 12),
          ],
        ),
      ),
    );
  }
}
