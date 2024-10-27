part of './../../core/helpers/export_manager/export_manager.dart';

TextStyle buildTextStyle({
  required double fontSize,
  required BuildContext context,
  double? letterSpacing,
  Color? color,
}) {
  return GoogleFonts.poppins(
    color: color ?? ColorManager.whiteColor,
    fontSize: getResponsiveFontSize(context, fontSize: fontSize.sp),
    fontWeight: FontWeight.w600,
    letterSpacing: letterSpacing,
  );
}
