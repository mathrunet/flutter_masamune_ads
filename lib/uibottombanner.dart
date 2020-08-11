part of masamune.ads;

/// Banner widget to place on the Bottom Sheet of Scaffold.
///
/// ```
/// @override
/// Widget bottomSheet(BuildContext context) {
///   return UIBottomBanner(
///     admobUnitId: "Admob ID"
///   );
/// }
/// ```
class UIBottomBanner extends StatelessWidget {
  /// Admob advertising ID.
  final String admobUnitId;

  /// Admob event listener.
  final void Function(AdmobAdEvent, Map<String, dynamic>) admobListener;

  /// Callback when the Admob ad is created.
  final void Function(AdmobBannerController) onAdmobBannerCreated;

  /// Banner widget to place on the Bottom Sheet of Scaffold.
  ///
  /// ```
  /// @override
  /// Widget bottomSheet(BuildContext context) {
  ///   return UIBottomBanner(
  ///     admobUnitId: "Admob unit ID"
  ///   );
  /// }
  /// ```
  ///
  /// [admobUnitId]: Admob advertising ID.
  /// [admobListener]: Admob event listener.
  /// [onAdmobBannerCreated]: Callback when the Admob ad is created.
  UIBottomBanner(
      {@required this.admobUnitId,
      this.admobListener,
      this.onAdmobBannerCreated})
      : assert(isNotEmpty(admobUnitId));

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        alignment: Alignment.center,
        color: Colors.white,
        child: AdsBanner(
            admobUnitId: this.admobUnitId,
            admobListener: this.admobListener,
            onAdmobBannerCreated: this.onAdmobBannerCreated,
            admobBannerSize: AdmobBannerSize.BANNER));
  }
}
