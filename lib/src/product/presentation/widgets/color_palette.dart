import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ColorPalette extends StatefulWidget {
  const ColorPalette(
      {super.key,
      required this.colors,
      this.onColorSelect,
      required this.radius,
      this.canScroll = false,
      this.spacing,
      this.padding});

  final List<Color> colors;
  final ValueChanged<Color>? onColorSelect;
  final double radius;
  final bool canScroll;
  final double? spacing;
  final EdgeInsetsGeometry? padding;

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  Color? selectedColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          gradient: LinearGradient(colors: [
            Color(0x50aa4b6b),
            Color(0x506b6b83),
            Color(0x503b8d99),
          ])),
      child: SizedBox(
        height: widget.radius * 2,
        child: ListView.separated(
          physics:
              widget.canScroll ? null : const NeverScrollableScrollPhysics(),
          itemCount: widget.colors.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          separatorBuilder: (_, __) => Gap(widget.spacing ?? 2),
          itemBuilder: (context, int index) {
            final color = widget.colors[index];
            final isActive = selectedColor == color;
            final innerContainer = Container(
              height: widget.radius * 2,
              width: widget.radius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            );

            return GestureDetector(
                onTap: widget.onColorSelect == null
                    ? null
                    : () {
                        Color? activeColor = color;
                        if (selectedColor == activeColor) activeColor = null;
                        widget.onColorSelect!(activeColor!);
                        setState(() => selectedColor = activeColor);
                      },
                child: isActive
                    ? Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: color, width: 2)),
                      )
                    : innerContainer);
          },
        ),
      ),
    );
  }
}
