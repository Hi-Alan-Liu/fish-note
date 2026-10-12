import 'package:flutter/material.dart';

import '../../widgets/empty_state.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('商城')),
      body: const EmptyState(
        icon: Icons.storefront_rounded,
        message: '商城準備中，橘橘正在進貨',
      ),
    );
  }
}
