part of './../../../core/helpers/export_manager/export_manager.dart';

class BuildEmptyTaskWidget extends StatelessWidget {
  const BuildEmptyTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/search.png',
            color: ColorManager.greyColor,
            width: 80.w,
            height: 80.h,
          ),
          Space(width: 0, height: 20.h),
          Text(
            AppLocalizations.of(context)!.no_task,
            style: buildTextStyle(
              fontSize: 20,
              context: context,
              settingsProvider: Provider.of<SettingsProvider>(context),
            ),
          ),
        ],
      ),
    );
  }
}
