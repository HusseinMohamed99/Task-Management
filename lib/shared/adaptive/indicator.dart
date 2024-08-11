import 'package:flutter/material.dart';

class AdaptiveIndicator extends StatelessWidget {
  final String os;
  const AdaptiveIndicator({required this.os, super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive();
  }
}
