// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/activeIcon.svg
  String get activeIcon => 'assets/icons/activeIcon.svg';

  /// File path: assets/icons/active_call_icon.svg
  String get activeCallIcon => 'assets/icons/active_call_icon.svg';

  /// File path: assets/icons/active_camera_icon.svg
  String get activeCameraIcon => 'assets/icons/active_camera_icon.svg';

  /// File path: assets/icons/add_icon.svg
  String get addIcon => 'assets/icons/add_icon.svg';

  /// File path: assets/icons/arrow_back_icon.svg
  String get arrowBackIcon => 'assets/icons/arrow_back_icon.svg';

  /// File path: assets/icons/background_chat_img.svg
  String get backgroundChatImg => 'assets/icons/background_chat_img.svg';

  /// File path: assets/icons/chatIcon.svg
  String get chatIcon => 'assets/icons/chatIcon.svg';

  /// File path: assets/icons/in_activeIcon.svg
  String get inActiveIcon => 'assets/icons/in_activeIcon.svg';

  /// File path: assets/icons/in_active_cameraIcon.svg
  String get inActiveCameraIcon => 'assets/icons/in_active_cameraIcon.svg';

  /// File path: assets/icons/inactive_call_Icon.svg
  String get inactiveCallIcon => 'assets/icons/inactive_call_Icon.svg';

  /// File path: assets/icons/inactive_cameraIcon.svg
  String get inactiveCameraIcon => 'assets/icons/inactive_cameraIcon.svg';

  /// File path: assets/icons/infoIcon.svg
  String get infoIcon => 'assets/icons/infoIcon.svg';

  /// File path: assets/icons/mic_icon.svg
  String get micIcon => 'assets/icons/mic_icon.svg';

  /// File path: assets/icons/nav_bar_call_Icon.svg
  String get navBarCallIcon => 'assets/icons/nav_bar_call_Icon.svg';

  /// File path: assets/icons/poster_icon.svg
  String get posterIcon => 'assets/icons/poster_icon.svg';

  /// File path: assets/icons/seenIcon.svg
  String get seenIcon => 'assets/icons/seenIcon.svg';

  /// File path: assets/icons/settingsIcon.svg
  String get settingsIcon => 'assets/icons/settingsIcon.svg';

  /// File path: assets/icons/statucIcon.svg
  String get statucIcon => 'assets/icons/statucIcon.svg';

  /// File path: assets/icons/unseenIcon.png
  AssetGenImage get unseenIcon =>
      const AssetGenImage('assets/icons/unseenIcon.png');

  /// File path: assets/icons/video_call_icon.svg
  String get videoCallIcon => 'assets/icons/video_call_icon.svg';

  /// List of all assets
  List<dynamic> get values => [
    activeIcon,
    activeCallIcon,
    activeCameraIcon,
    addIcon,
    arrowBackIcon,
    backgroundChatImg,
    chatIcon,
    inActiveIcon,
    inActiveCameraIcon,
    inactiveCallIcon,
    inactiveCameraIcon,
    infoIcon,
    micIcon,
    navBarCallIcon,
    posterIcon,
    seenIcon,
    settingsIcon,
    statucIcon,
    unseenIcon,
    videoCallIcon,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/background_chat_img.svg
  String get backgroundChatImg => 'assets/images/background_chat_img.svg';

  /// File path: assets/images/background_chat_img2.png
  AssetGenImage get backgroundChatImg2 =>
      const AssetGenImage('assets/images/background_chat_img2.png');

  /// List of all assets
  List<dynamic> get values => [backgroundChatImg, backgroundChatImg2];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
