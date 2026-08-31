import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/offer_banner_item.dart';

class OfferBanner extends StatefulWidget {
  final List<OfferBannerItem> items;
  final ValueChanged<int>? onCtaTap;
  final ValueChanged<int>? onDismiss;

  const OfferBanner({
    super.key,
    required this.items,
    this.onCtaTap,
    this.onDismiss,
  });

  @override
  State<OfferBanner> createState() => _OfferBannerState();
}

class _OfferBannerState extends State<OfferBanner> {
  late final PageController _pageController;

  Timer? _autoScrollTimer;

  // Start from a large multiple so we can scroll infinitely
  // in both directions.
  late int _currentPage;

  @override
  void initState() {
    super.initState();

    _currentPage = widget.items.isNotEmpty
        ? widget.items.length * 1000
        : 0;

    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 1.0,
    );

    _startAutoScroll();
  }

  // ============================================================
  // CURRENT BANNER INDEX
  // ============================================================

  int get _realIndex {
    if (widget.items.isEmpty) {
      return 0;
    }

    return _currentPage % widget.items.length;
  }

  // ============================================================
  // AUTO SCROLL
  // ============================================================

  void _startAutoScroll() {
    if (widget.items.length <= 1) {
      return;
    }

    _autoScrollTimer = Timer.periodic(
      const Duration(seconds: 3),
          (_) {
        if (!_pageController.hasClients) {
          return;
        }

        _currentPage++;

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  // ============================================================
  // STOP AUTO SCROLL
  // ============================================================

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  // ============================================================
  // RESTART AUTO SCROLL
  // ============================================================

  void _restartAutoScroll() {
    _stopAutoScroll();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // ============================================================
        // INFINITE VIEW PAGER
        // ============================================================

        SizedBox(
          height: 116,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                _stopAutoScroll();
              }

              if (notification is ScrollEndNotification) {
                _restartAutoScroll();
              }

              return false;
            },
            child: PageView.builder(
              controller: _pageController,

              // Very large number = practically infinite
              itemCount: 1000000,

              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },

              itemBuilder: (context, page) {
                // Convert infinite page to actual banner index
                final index = page % widget.items.length;

                final item = widget.items[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 14,
                      top: 12,
                      bottom: 12,
                      right: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        // ==================================================
                        // ICON
                        // ==================================================

                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.local_offer_outlined,
                            color: Colors.white,
                            size: 21,
                          ),
                        ),

                        const SizedBox(width: 10),

                        // ==================================================
                        // TEXT
                        // ==================================================

                        Expanded(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  height: 1.2,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                item.subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 11.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 6),

                        // ==================================================
                        // CTA
                        // ==================================================

                        TextButton(
                          onPressed: () {
                            widget.onCtaTap?.call(index);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 7,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(9),
                            ),
                          ),
                          child: Text(
                            item.ctaLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // ==================================================
                        // CLOSE
                        // ==================================================

                        // SizedBox(
                        //   width: 30,
                        //   height: 36,
                        //   child: IconButton(
                        //     onPressed: () {
                        //       widget.onDismiss?.call(index);
                        //     },
                        //     padding: EdgeInsets.zero,
                        //     splashRadius: 16,
                        //     icon: const Icon(
                        //       Icons.close,
                        //       color: Colors.white,
                        //       size: 18,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // ============================================================
        // PAGE INDICATORS
        // ============================================================
SizedBox(height: 2),
        if (widget.items.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.items.length,
                  (index) {
                final selected = index == _realIndex;

                return AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 250,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  width: selected ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),

        const SizedBox(height: 4),
      ],
    );
  }
}