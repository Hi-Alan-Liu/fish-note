import 'package:flutter/material.dart';

import '../../theme/tokens.dart';

class NavItem {
  const NavItem(this.icon, this.label);
  final IconData icon;
  final String label;
}

/// Bottom navigation with a raised centre "＋" button (docs/stages/S01-skeleton.md).
class FishNavBar extends StatelessWidget {
  const FishNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.onAdd,
  }) : assert(items.length == 4);

  /// Four tabs; the add button sits between items[1] and items[2].
  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAdd;

  static const barHeight = 68.0;
  static const addSize = 60.0;
  static const addRise = 18.0;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return SizedBox(
      height: barHeight + bottom + addRise,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: barHeight + bottom,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.line)),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Row(
                  children: [
                    _tab(0),
                    _tab(1),
                    const SizedBox(width: addSize + 16),
                    _tab(2),
                    _tab(3),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(child: _AddButton(onTap: onAdd)),
          ),
        ],
      ),
    );
  }

  Widget _tab(int i) {
    final selected = i == currentIndex;
    final color = selected ? AppColors.primary : AppColors.muted;
    return Expanded(
      child: Semantics(
        selected: selected,
        button: true,
        child: InkResponse(
          onTap: () => onTap(i),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(items[i].icon, color: color, size: 26),
              const SizedBox(height: 2),
              Text(
                items[i].label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '記一筆帳',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          key: const Key('nav-add'),
          width: FishNavBar.addSize,
          height: FishNavBar.addSize,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surface, width: 4),
            boxShadow: const [
              BoxShadow(color: Color(0x33E2622A), blurRadius: 10, offset: Offset(0, 4)),
            ],
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 34),
        ),
      ),
    );
  }
}
