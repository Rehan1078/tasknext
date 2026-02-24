import 'package:flutter/material.dart';

class AppTextStyles {
  // Base Typography (No Colors)
  static const TextStyle _baseHeadline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _baseTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle _baseBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle _baseSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle _baseButton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle _baseHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  // Constants for Theme Definition
  static const TextStyle headline = _baseHeadline;
  static const TextStyle title = _baseTitle;
  static const TextStyle body = _baseBody;
  static const TextStyle small = _baseSmall;
  static const TextStyle button = _baseButton;
  static const TextStyle hint = _baseHint;

  // Theme-Consuming Methods (For UI)
  static TextStyle headlineStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!;

  static TextStyle titleStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!;

  static TextStyle bodyStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!;

  static TextStyle smallStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!;

  static TextStyle buttonStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          );

  static TextStyle hintStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).hintColor,
          );
}
