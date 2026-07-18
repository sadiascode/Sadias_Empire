import 'package:flutter/material.dart';
import '../custom_color.dart';
import 'bottom_tab_item.dart';

class CustomBottomNav extends StatelessWidget {
  final List<BottomTabItem> tabs;
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    int centerIndex = tabs.indexWhere((e) => e.isCenter);
    if (centerIndex == -1) centerIndex = tabs.length ~/ 2;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E24),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(tabs.length, (i) {
              return _buildTab(i, isCenter: i == centerIndex);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index, {required bool isCenter}) {
    final isActive = currentIndex == index;

    Widget iconWidget = SizedBox(
      width: isCenter ? 30 : 30,
      height: isCenter ? 30 : 30,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: tabs[index].icon,
      ),
    );

    iconWidget = ColorFiltered(
      colorFilter: ColorFilter.mode(
        isActive ? Colors.white : const Color(0xFFA0A0A0),
        BlendMode.srcIn,
      ),
      child: iconWidget,
    );

    final double translateY = isActive ? (isCenter ? -8.0 : -2.0) : 0.0;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(0, translateY, 0),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isActive ? 1.0 : 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColors.secondaryGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(isCenter ? 18 : 14),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1E6BD1).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.all(isActive ? (isCenter ? 10.0 : 8.0) : 8.0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isActive ? 1.0 : 0.6,
                      child: iconWidget,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}