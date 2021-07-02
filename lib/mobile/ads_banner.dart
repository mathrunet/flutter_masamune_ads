part of masamune_ads.mobile;

/// Display banner ads.
class AdsBanner extends StatefulWidget {
  /// Display banner ads.
  const AdsBanner({
    required this.unitId,
    this.bannerSize = AdsSize.banner,
  });

  /// Admob advertising ID.
  final String unitId;

  /// Admob banner size.
  final AdsSize bannerSize;

  @override
  State<StatefulWidget> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  late final BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerAd =
        _AdsBannerCacheManager._getBannerAd(widget.unitId, widget.bannerSize);
  }

  @override
  void dispose() {
    super.dispose();
    _AdsBannerCacheManager._disposeBannerAd(
        widget.unitId, widget.bannerSize, _bannerAd);
  }

  /// Run build.
  ///
  /// [context]: Build Context.
  @override
  Widget build(BuildContext context) {
    return AdWidget(ad: _bannerAd);
  }
}

class _AdsBannerCacheManager {
  const _AdsBannerCacheManager();

  static final Map<String, List<BannerAd>> _bannerAdCache = {};
  static BannerAd _getBannerAd(String unitId, AdsSize bannerSize) {
    final contextId = "${unitId}_${bannerSize.width}x${bannerSize.height}";
    if (_bannerAdCache.containsKey(contextId)) {
      final cache = _bannerAdCache[contextId];
      if (cache.isNotEmpty) {
        return cache!.removeLast();
      }
    }
    final banner = _createBannerAd(unitId, bannerSize);
    return banner;
  }

  static BannerAd _createBannerAd(String unitId, AdsSize bannerSize) {
    return BannerAd(
      adUnitId: unitId,
      size: AdSize(width: bannerSize.width, height: bannerSize.height),
      request: const AdRequest(),
      listener: const BannerAdListener(),
    )..load();
  }

  static void _disposeBannerAd(
      String unitId, AdsSize bannerSize, BannerAd? banner) {
    if (banner == null) {
      return;
    }
    final contextId = "${unitId}_${bannerSize.width}x${bannerSize.height}";
    if (_bannerAdCache.containsKey(contextId)) {
      _bannerAdCache[contextId]!.add(banner);
    } else {
      _bannerAdCache[contextId] = [banner];
    }
  }
}
