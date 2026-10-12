import 'package:flutter/material.dart';

import '../backpack/backpack_page.dart';
import '../home/home_page.dart';
import '../ledger/ledger_page.dart';
import '../ledger/transaction_sheet.dart';
import '../shop/shop_page.dart';
import 'fish_nav_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _items = [
    NavItem(Icons.water_rounded, '魚缸'),
    NavItem(Icons.pie_chart_rounded, '明細'),
    NavItem(Icons.storefront_rounded, '商城'),
    NavItem(Icons.backpack_rounded, '背包'),
  ];

  void _openAddTransaction() => openTransactionSheet(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [HomePage(), LedgerPage(), ShopPage(), BackpackPage()],
      ),
      bottomNavigationBar: FishNavBar(
        items: _items,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        onAdd: _openAddTransaction,
      ),
    );
  }
}
