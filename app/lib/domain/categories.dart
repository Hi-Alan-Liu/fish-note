import 'feed.dart';

enum TxType { expense, income }

class DefaultCategory {
  const DefaultCategory(this.id, this.name, this.type, this.feedColor);
  final String id;
  final String name;
  final TxType type;
  final FeedColor feedColor;
}

/// The 8 default categories (docs/02-gameplay-economy.md).
const defaultCategories = <DefaultCategory>[
  DefaultCategory('food', '餐飲', TxType.expense, FeedColor.orange),
  DefaultCategory('transport', '交通', TxType.expense, FeedColor.blue),
  DefaultCategory('shopping', '購物', TxType.expense, FeedColor.pink),
  DefaultCategory('fun', '娛樂', TxType.expense, FeedColor.purple),
  DefaultCategory('home', '居家 / 帳單', TxType.expense, FeedColor.green),
  DefaultCategory('health', '醫療 / 學習', TxType.expense, FeedColor.cyan),
  DefaultCategory('other', '其他支出', TxType.expense, FeedColor.white),
  DefaultCategory('income', '收入', TxType.income, FeedColor.gold),
];
