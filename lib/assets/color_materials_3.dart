import 'package:flutter/material.dart';

class ColorMaterials3 extends StatelessWidget {
  const ColorMaterials3({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  static ColorScheme getColors(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  // Usage function - call this from your UI
  static Color getBlueContainer(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;

  static Color getOnBlueContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryContainer;

  static Color getGreenContainer(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  static Color getOnGreenContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onSecondaryContainer;

  static Color getYellowContainer(BuildContext context) =>
      Theme.of(context).colorScheme.tertiaryContainer;

  static Color getOnYellowContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onTertiaryContainer;

  static Color getNeutralContainer(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerHighest;

  static Color getOnNeutralContainer(BuildContext context) =>
      Theme.of(context).colorScheme.onSurfaceVariant;
}
