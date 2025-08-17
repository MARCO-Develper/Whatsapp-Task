import 'package:flutter/material.dart';

class HomeFAB extends StatelessWidget {
  final TabController tabController;
  final AnimationController animationController;

  const HomeFAB({
    super.key,
    required this.tabController,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: tabController.animation!,
      builder: (_, __) => ScaleTransition(
        scale: animationController,
        child: _getFAB(tabController.index),
      ),
    );
  }

  Widget _getFAB(int index) {
    switch (index) {
      case 0:
        return FloatingActionButton(
          onPressed: () {},
          heroTag: "status_fab",
          child: const Icon(Icons.camera_alt, color: Colors.white),
        );
      case 1:
        return FloatingActionButton(
          onPressed: () {},
          heroTag: "chat_fab",
          child: const Icon(Icons.message, color: Colors.white),
        );
      case 2:
        return FloatingActionButton(
          onPressed: () {},
          heroTag: "call_fab",
          child: const Icon(Icons.add_call, color: Colors.white),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
