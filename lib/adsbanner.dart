part of masamune.ads;

/// Display banner ads.
class AdsBanner extends StatelessWidget {
  static Map<String, AdmobBanner> _cache = {};

  /// Admob advertising ID.
  final String admobUnitId;

  /// Admob banner size.
  final AdmobBannerSize admobBannerSize;

  /// Admob event listener.
  final void Function(AdmobAdEvent, Map<String, dynamic>) admobListener;

  /// Callback when the Admob ad is created.
  final void Function(AdmobBannerController) onAdmobBannerCreated;

  /// Display banner ads.
  ///
  /// [admobUnitId]: Admob advertising ID.
  /// [admobBannerSize]: Admob banner size.
  /// [admobListener]: Admob event listener.
  /// [onAdmobBannerCreated]: Callback when the Admob ad is created.
  AdsBanner(
      {@required this.admobUnitId,
      this.admobBannerSize = AdmobBannerSize.BANNER,
      this.admobListener,
      this.onAdmobBannerCreated})
      : assert(isNotEmpty(admobUnitId));

  /// Run build.
  ///
  /// [context]: Build Context.
  @override
  Widget build(BuildContext context) {
    if (Config.isWeb) {
      return Container();
    } else {
      if (_cache
          .containsKey("${this.admobUnitId}${admobBannerSize.toString()}")) {
        return _cache["${this.admobUnitId}${admobBannerSize.toString()}"];
      }
      return _cache["${this.admobUnitId}${admobBannerSize.toString()}"] =
          AdmobBanner(
              adUnitId: this.admobUnitId,
              adSize: this.admobBannerSize,
              listener: this.admobListener,
              onBannerCreated: this.onAdmobBannerCreated);
    }
  }
}
