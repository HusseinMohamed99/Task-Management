part of './../../../core/helpers/export_manager/export_manager.dart';

class BuildErrorTaskWidget extends StatelessWidget {
  const BuildErrorTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.error_loading,
            style: buildTextStyle(
              fontSize: 20,
              context: context,
              settingsProvider: Provider.of<SettingsProvider>(context),
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.try_again,
              style: buildTextStyle(
                fontSize: 20,
                context: context,
                settingsProvider: Provider.of<SettingsProvider>(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
