part of './../../core/helpers/export_manager/export_manager.dart';

class AdaptiveIndicator extends StatelessWidget {
  const AdaptiveIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive();
  }
}
