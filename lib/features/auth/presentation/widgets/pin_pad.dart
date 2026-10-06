import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_tokens.dart';

/// Row of dots showing how many PIN digits were entered.
class PinDots extends StatelessWidget {
  const PinDots({
    super.key,
    required this.length,
    required this.filled,
    this.shakeCount = 0,
    this.error = false,
  });

  final int length;
  final int filled;
  final int shakeCount;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final active = error ? context.palette.danger : context.colors.primary;
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < length; i++)
          AnimatedContainer(
            duration: AppDurations.fast,
            margin: const EdgeInsets.symmetric(horizontal: 9),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i < filled ? active : Colors.transparent,
              border: Border.all(
                color: i < filled ? active : context.colors.outline,
                width: 2,
              ),
            ),
          ),
      ],
    );
    if (shakeCount == 0) return row;
    return row
        .animate(key: ValueKey(shakeCount))
        .shake(hz: 5, offset: const Offset(10, 0), duration: 420.ms);
  }
}

/// Numeric keypad used by the lock screen. Also accepts hardware keyboard
/// input (digits, backspace, enter) when focused.
class PinPad extends StatelessWidget {
  const PinPad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    this.onSubmit,
    this.enabled = true,
    this.buttonSize = 76,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback? onSubmit;
  final bool enabled;
  final double buttonSize;

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (!enabled || event is KeyUpEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;
    final label = event.character;
    if (label != null && RegExp(r'^\d$').hasMatch(label)) {
      onDigit(label);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.backspace || key == LogicalKeyboardKey.delete) {
      onBackspace();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.numpadEnter) {
      onSubmit?.call();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    Widget key(String digit) => _PadButton(
          size: buttonSize,
          enabled: enabled,
          onTap: () => onDigit(digit),
          child: Text(
            digit,
            style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        );

    return Focus(
      autofocus: true,
      onKeyEvent: _onKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final row in const [
            ['1', '2', '3'],
            ['4', '5', '6'],
            ['7', '8', '9'],
          ])
            Row(mainAxisSize: MainAxisSize.min, children: [for (final d in row) key(d)]),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: buttonSize + 20, height: buttonSize + 16),
              key('0'),
              _PadButton(
                size: buttonSize,
                enabled: enabled,
                filled: false,
                onTap: onBackspace,
                child: Icon(
                  Icons.backspace_outlined,
                  color: context.palette.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PadButton extends StatelessWidget {
  const _PadButton({
    required this.size,
    required this.onTap,
    required this.child,
    this.enabled = true,
    this.filled = true,
  });

  final double size;
  final VoidCallback onTap;
  final Widget child;
  final bool enabled;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: SizedBox(
        width: size,
        height: size,
        child: Material(
          color: filled ? context.colors.surfaceContainerHigh : Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: enabled
                ? () {
                    HapticFeedback.lightImpact();
                    onTap();
                  }
                : null,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
