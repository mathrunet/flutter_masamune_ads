part of masamune.ads;

/// Class for managing ads.
///
/// This handle Admob and Adsense.
///
/// Execute [initialize] to initialize.
class AdsCore extends Task {
  /// Admob application ID.
  String get admobAppId => this._admobAppId;
  String _admobAppId;

  /// Create a Completer that matches the class.
  ///
  /// Do not use from external class
  @override
  @protected
  Completer createCompleter() => Completer<AdsCore>();

  /// Process to create a new instance.
  ///
  /// Do not use from outside the class.
  ///
  /// [path]: Destination path.
  /// [isTemporary]: True if the data is temporary.
  @override
  T createInstance<T extends IClonable>(String path, bool isTemporary) =>
      AdsCore._(path, admobAppId: this.admobAppId) as T;

  /// Class for managing ads.
  ///
  /// This handle Admob and Adsense.
  ///
  /// Execute [initialize] to initialize.
  ///
  /// [admobAppId]: Admob App ID.
  /// [timeout]: Timeout setting.
  static Future<AdsCore> initialize(
      {String admobAppId, Duration timeout = Const.timeout}) {
    assert(isNotEmpty(admobAppId));
    if (isEmpty(admobAppId)) {
      Log.error("The admob app id is invalid.");
      return Future.delayed(Duration.zero);
    }
    AdsCore unit = PathMap.get<AdsCore>(_systemPath);
    if (unit != null) return unit.future;
    unit = AdsCore._(_systemPath, admobAppId: admobAppId);
    unit._initialize(timeout: timeout);
    return unit.future;
  }

  AdsCore._(String path, {String admobAppId})
      : this._admobAppId = admobAppId,
        super(
            path: path, value: null, isTemporary: false, group: -1, order: 10);
  static const String _systemPath = "system://ads";
  void _initialize({Duration timeout}) async {
    try {
      if (Config.isWeb) {
      } else {
        if (isNotEmpty(this.admobAppId)) Admob.initialize(this.admobAppId);
      }
      this.done();
    } catch (e) {
      this.error(e.toString());
    }
  }

  /// Get the protocol of the path.
  String get protocol => Protocol.system;
}
