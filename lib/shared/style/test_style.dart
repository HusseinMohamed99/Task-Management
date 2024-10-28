part of './../../core/helpers/export_manager/export_manager.dart';

TextStyle buildTextStyle({
  required double fontSize,
  required BuildContext context,
  double? letterSpacing,
  required SettingsProvider settingsProvider,
}) {
  return GoogleFonts.poppins(
    color: settingsProvider.isDarkMode()
        ? ColorManager.whiteColor
        : ColorManager.blackColor,
    fontSize: getResponsiveFontSize(context, fontSize: fontSize.sp),
    fontWeight: FontWeight.w600,
    letterSpacing: letterSpacing,
  );
}
