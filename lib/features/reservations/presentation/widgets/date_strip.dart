import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';

/// Date navigator: arrows, "Today", date picker and a scrollable strip of
/// the next two weeks.
class DateStrip extends StatelessWidget {
  const DateStrip({
    super.key,
    required this.selected,
    required this.onChanged,
    this.showStrip = true,
  });

  final DateTime selected;
  final ValueChanged<DateTime> onChanged;
  final bool showStrip;

  @override
  Widget build(BuildContext context) {
    final today = DateUtilsX.startOfDay(DateTime.now());
    final isToday = DateUtilsX.isSameDay(selected, today);

    final nav = Row(
      children: [
        IconButton.outlined(
          tooltip: 'Previous day',
          onPressed: () => onChanged(selected.subtract(const Duration(days: 1))),
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: InkWell(
            borderRadius: AppRadius.mdAll,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selected,
                firstDate: today.subtract(const Duration(days: 365)),
                lastDate: today.add(const Duration(days: 365)),
              );
              if (picked != null) onChanged(picked);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Text(Formatters.relativeDay(selected), style: context.text.titleMedium),
                  Text(
                    Formatters.dayFull(selected),
                    style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        if (!isToday) ...[
          TextButton(onPressed: () => onChanged(today), child: const Text('Today')),
          const SizedBox(width: AppSpacing.xs),
        ],
        IconButton.outlined(
          tooltip: 'Next day',
          onPressed: () => onChanged(selected.add(const Duration(days: 1))),
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );

    if (!showStrip) return nav;

    return Column(
      children: [
        nav,
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 64,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 21,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, i) {
              final day = today.add(Duration(days: i - 3));
              final active = DateUtilsX.isSameDay(day, selected);
              return Material(
                color: active ? context.colors.primary : context.colors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.mdAll,
                  side: BorderSide(
                    color: active ? context.colors.primary : context.palette.border,
                  ),
                ),
                child: InkWell(
                  borderRadius: AppRadius.mdAll,
                  onTap: () => onChanged(day),
                  child: SizedBox(
                    width: 54,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Formatters.weekday(day).toUpperCase(),
                          style: context.text.labelSmall?.copyWith(
                            color: active ? context.colors.onPrimary : context.palette.textMuted,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${day.day}',
                          style: context.text.titleMedium?.copyWith(
                            color: active ? context.colors.onPrimary : null,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (DateUtilsX.isSameDay(day, today))
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: active ? context.colors.onPrimary : context.colors.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
