import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../data/ledger_repository.dart';
import '../../data/providers.dart';
import '../../domain/categories.dart';
import '../../theme/tokens.dart';
import '../../widgets/feed_dot.dart';
import '../../widgets/format.dart';

/// Opens the add / edit form and shows the feed feedback afterwards.
Future<void> openTransactionSheet(BuildContext context, {TxRecord? existing}) async {
  final messenger = ScaffoldMessenger.of(context);
  final result = await showModalBottomSheet<SheetResult>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => TransactionSheet(existing: existing),
  );
  if (result == null) return;

  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(SnackBar(content: _feedbackContent(result)));
}

Widget _feedbackContent(SheetResult result) {
  if (result.deleted) return const Text('已刪除這筆紀錄');
  final save = result.save;
  if (save == null) return const Text('已儲存');
  final reward = save.reward;
  if (reward != null) {
    final text = reward.streakBonus
        ? '連續記帳 ${LedgerRepository.streakDaysForB} 天！獲得 ${reward.color.label}飼料 ${reward.level.label} ×1'
        : '獲得 ${reward.color.label}飼料 ${reward.level.label} ×1';
    return Row(children: [
      FeedDot(color: reward.color, size: 18, glow: reward.streakBonus),
      const SizedBox(width: 10),
      Expanded(child: Text(text)),
    ]);
  }
  return Text(switch (save.noFeedReason) {
    NoFeedReason.zeroAmount => '金額為 0，這筆不會獲得飼料',
    NoFeedReason.dailyLimit => '今天的 ${LedgerRepository.dailyFeedLimit} 份飼料已經領完囉',
    null => '已記下這筆帳',
  });
}

class SheetResult {
  const SheetResult({this.save, this.deleted = false});
  final SaveResult? save;
  final bool deleted;
}

class TransactionSheet extends ConsumerStatefulWidget {
  const TransactionSheet({super.key, this.existing});

  final TxRecord? existing;

  @override
  ConsumerState<TransactionSheet> createState() => _TransactionSheetState();
}

class _TransactionSheetState extends ConsumerState<TransactionSheet> {
  static String _lastExpenseCategory = 'food';
  static const _maxDigits = 9;

  late TxType _type;
  late String _categoryId;
  late String _digits;
  late DateTime _date;
  late final TextEditingController _note;
  bool _editingNote = false;
  bool _busy = false;

  bool get _isEdit => widget.existing != null;
  int get _amount => int.tryParse(_digits) ?? 0;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _type = e?.type ?? TxType.expense;
    _categoryId = e?.categoryId ?? _lastExpenseCategory;
    _digits = e == null ? '' : '${e.amount}';
    _date = e?.date ?? ref.read(clockProvider)();
    _note = TextEditingController(text: e?.note ?? '');
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  void _setType(TxType t, List<Category> cats) {
    setState(() {
      _type = t;
      final current = cats.where((c) => c.id == _categoryId).firstOrNull;
      if (current?.type != t) {
        _categoryId = t == TxType.income
            ? cats.firstWhere((c) => c.type == TxType.income).id
            : _lastExpenseCategory;
      }
    });
  }

  void _press(String key) {
    setState(() {
      switch (key) {
        case 'back':
          if (_digits.isNotEmpty) _digits = _digits.substring(0, _digits.length - 1);
        case 'clear':
          _digits = '';
        default:
          final next = (_digits + key).replaceFirst(RegExp(r'^0+'), '');
          if (next.length <= _maxDigits) _digits = next;
      }
    });
  }

  Future<void> _pickDate() async {
    final now = ref.read(clockProvider)();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1, 12, 31),
    );
    if (picked != null) {
      setState(() => _date = DateTime(picked.year, picked.month, picked.day, _date.hour, _date.minute));
    }
  }

  Future<void> _save() async {
    if (_amount <= 0 || _busy) return;
    setState(() => _busy = true);
    final repo = ref.read(ledgerRepositoryProvider);
    if (_type == TxType.expense) _lastExpenseCategory = _categoryId;
    final navigator = Navigator.of(context);
    if (_isEdit) {
      await repo.update(widget.existing!.id,
          type: _type, amount: _amount, categoryId: _categoryId, date: _date, note: _note.text);
      navigator.pop(const SheetResult());
    } else {
      final save = await repo.add(
          type: _type, amount: _amount, categoryId: _categoryId, date: _date, note: _note.text);
      navigator.pop(SheetResult(save: save));
    }
  }

  Future<void> _delete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('刪除這筆紀錄？'),
        content: const Text('刪除後無法復原。已經拿到的飼料不會收回。'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('刪除'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final navigator = Navigator.of(context);
    await ref.read(ledgerRepositoryProvider).delete(widget.existing!.id);
    navigator.pop(const SheetResult(deleted: true));
  }

  @override
  Widget build(BuildContext context) {
    final cats = ref.watch(categoriesProvider).value ?? const <Category>[];
    final visible = cats.where((c) => c.type == _type).toList();
    final selected = cats.where((c) => c.id == _categoryId).firstOrNull;
    final today = ref.read(clockProvider)();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: AppColors.line, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 4, 0),
            child: Row(
              children: [
                if (_isEdit)
                  Text('編輯紀錄', style: Theme.of(context).textTheme.titleLarge)
                else
                  const SizedBox.shrink(),
                if (_isEdit) const SizedBox(width: 12),
                SegmentedButton<TxType>(
                  segments: const [
                    ButtonSegment(value: TxType.expense, label: Text('支出')),
                    ButtonSegment(value: TxType.income, label: Text('收入')),
                  ],
                  selected: {_type},
                  showSelectedIcon: false,
                  onSelectionChanged: (s) => _setType(s.first, cats),
                  style: SegmentedButton.styleFrom(
                    selectedBackgroundColor: AppColors.primary,
                    selectedForegroundColor: Colors.white,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: '關閉',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          // amount display
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (selected != null) ...[
                  FeedDot(color: selected.feedColor, size: 16),
                  const SizedBox(width: 6),
                  Text(selected.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                ],
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('NT\$ ', style: Theme.of(context).textTheme.bodySmall),
                        Text(
                          formatAmount(_amount),
                          key: const Key('amount-display'),
                          style: TextStyle(
                            fontFamily: AppFonts.number,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                            color: _type == TxType.income ? AppColors.primaryDeep : AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 16, color: AppColors.line),
          // categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in visible)
                  _CategoryChip(
                    key: Key('cat-${c.id}'),
                    category: c,
                    selected: c.id == _categoryId,
                    onTap: () => setState(() => _categoryId = c.id),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // date + note
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.event_rounded, size: 20),
                  label: Text(isSameDay(_date, today) ? '今天 ${_date.month}/${_date.day}' : formatDayHeader(_date)),
                ),
                Expanded(
                  child: _editingNote
                      ? TextField(
                          controller: _note,
                          autofocus: true,
                          maxLength: 40,
                          decoration: const InputDecoration(hintText: '備註（選填）', counterText: '', isDense: true),
                          onSubmitted: (_) => setState(() => _editingNote = false),
                        )
                      : TextButton.icon(
                          onPressed: () => setState(() => _editingNote = true),
                          icon: const Icon(Icons.edit_note_rounded, size: 20),
                          label: Text(
                            _note.text.isEmpty ? '備註…' : _note.text,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                ),
              ],
            ),
          ),
          if (!_editingNote) _Keypad(onKey: _press, onSubmit: _save, canSubmit: _amount > 0 && !_busy, isEdit: _isEdit),
          if (_isEdit && !_editingNote)
            TextButton(
              onPressed: _delete,
              style: TextButton.styleFrom(foregroundColor: AppColors.danger),
              child: const Text('刪除這筆'),
            ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom + 8),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({super.key, required this.category, required this.selected, required this.onTap});

  final Category category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ring = category.feedColor.color;
    return Material(
      color: selected ? Color.lerp(ring, Colors.white, 0.82) : AppColors.paper,
      shape: StadiumBorder(side: BorderSide(color: selected ? ring : AppColors.line, width: selected ? 2 : 1)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 7, 12, 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FeedDot(color: category.feedColor, size: 14),
              const SizedBox(width: 6),
              Text(
                category.name,
                style: TextStyle(fontWeight: selected ? FontWeight.w700 : FontWeight.w500, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({required this.onKey, required this.onSubmit, required this.canSubmit, required this.isEdit});

  final ValueChanged<String> onKey;
  final VoidCallback onSubmit;
  final bool canSubmit;
  final bool isEdit;

  static const _rows = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    ['00', '0', '.'],
  ];

  @override
  Widget build(BuildContext context) {
    const h = 54.0, gap = 8.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                for (final row in _rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: gap),
                    child: Row(
                      children: [
                        for (final k in row)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: gap),
                              child: _Key(
                                key: Key('key-$k'),
                                label: k,
                                height: h,
                                // NT$ has no decimals in phase 1.
                                onTap: k == '.' ? null : () => onKey(k),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _Key(key: const Key('key-back'), icon: Icons.backspace_outlined, height: h, onTap: () => onKey('back')),
                const SizedBox(height: gap),
                _Key(key: const Key('key-clear'), label: 'C', height: h, onTap: () => onKey('clear')),
                const SizedBox(height: gap),
                SizedBox(
                  height: h * 2 + gap,
                  width: double.infinity,
                  child: FilledButton(
                    key: const Key('key-submit'),
                    onPressed: canSubmit ? onSubmit : null,
                    style: FilledButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(isEdit ? '儲存' : '記一筆', textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Key extends StatelessWidget {
  const _Key({super.key, this.label, this.icon, required this.height, this.onTap});

  final String? label;
  final IconData? icon;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Material(
        color: AppColors.chip,
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.button),
          onTap: onTap,
          child: Center(
            child: icon != null
                ? Icon(icon, color: AppColors.ink)
                : Text(
                    label!,
                    style: TextStyle(
                      fontFamily: AppFonts.number,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: enabled ? AppColors.ink : AppColors.line,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
