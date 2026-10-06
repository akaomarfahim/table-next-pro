import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/daily_stats.dart';

/// Lightweight animated bar chart (no chart dependency) for the last days'
/// revenue. Today's bar is highlighted.
class RevenueBarChart extends StatefulWidget {
  const RevenueBarChart({super.key, required this.days, required this.format});

  final List<DailyStats> days;
  final String Function(num) format;

  @override
  State<RevenueBarChart> createState() => _RevenueBarChartState();
}

class _RevenueBarChartState extends State<RevenueBarChart> {
  int? _hover;

  @override
  Widget build(BuildContext context) {
    final max = widget.days.fold<double>(0, (m, d) => d.revenue > m ? d.revenue : m);
    final today = DateUtilsX.startOfDay(DateTime.now());

    return LayoutBuilder(
      builder: (context, c) {
        const labelHeight = 36.0;
        final barArea = c.maxHeight - labelHeight - 22;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (var i = 0; i < widget.days.length; i++)
              Expanded(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hover = i),
                  onExit: (_) => setState(() => _hover = null),
                  child: GestureDetector(
                    onTap: () => setState(() => _hover = _hover == i ? null : i),
                    child: _Bar(
                      day: widget.days[i],
                      fraction: max == 0 ? 0 : widget.days[i].revenue / max,
                      maxHeight: barArea.clamp(20.0, 400.0),
                      highlighted: DateUtilsX.isSameDay(widget.days[i].date, today),
                      showValue: _hover == i,
                      value: widget.format(widget.days[i].revenue),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.day,
    required this.fraction,
    required this.maxHeight,
    required this.highlighted,
    required this.showValue,
    required this.value,
  });

  final DailyStats day;
  final double fraction;
  final double maxHeight;
  final bool highlighted;
  final bool showValue;
  final String value;

  @override
  Widget build(BuildContext context) {
    final color = highlighted ? context.colors.primary : context.colors.primary.withValues(alpha: 0.35);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedOpacity(
            duration: AppDurations.fast,
            opacity: showValue ? 1 : 0,
            child: FittedBox(
              child: Text(
                value,
                style: context.text.labelSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(height: 4),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: fraction),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (context, f, _) => Container(
              height: (maxHeight * f).clamp(4.0, maxHeight),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(3)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            Formatters.weekday(day.date),
            style: context.text.labelSmall?.copyWith(
              color: highlighted ? context.colors.primary : context.palette.textMuted,
              fontWeight: highlighted ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
          Text(
            '${day.date.day}',
            style: context.text.labelSmall?.copyWith(color: context.palette.textMuted),
          ),
        ],
      ),
    );
  }
}
