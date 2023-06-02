import 'package:chitmaymay_player/src/widgets/video_quality_widget.dart';
import 'package:flutter/material.dart';
import 'package:chitmaymay_player/chitmaymay_player.dart';
import 'package:chitmaymay_player/src/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

/// Widget use to display the bottom bar buttons and the time texts
class PlayerBottomBar extends StatelessWidget {
  /// Constructor
  PlayerBottomBar({
    Key? key,
    required this.controller,
    required this.showBottomBar,
    this.onPlayButtonTap,
    this.onFullScreenTap,
    this.onQualityTap,
    this.videoDuration = "00:00:00",
    this.videoSeek = "00:00:00",
    this.videoStyle = const VideoStyle(),
    this.onFastForward,
    this.onRewind,
    // required this.progress,
    // required this.total,
  }) : super(key: key);

  /// The controller of the playing video.
  final VideoPlayerController controller;

  /// If set to [true] the bottom bar will appear and if you want that user can not interact with the bottom bar you can set it to [false].
  /// Default value is [true].
  final bool showBottomBar;

  /// The text to display the current position progress.
  final String videoSeek;

  /// The text to display the video's duration.
  final String videoDuration;

  /// The callback function execute when user tapped the play button.
  final void Function()? onPlayButtonTap;
  final void Function()? onFullScreenTap;
  final void Function()? onQualityTap;

  /// The model to provide custom style for the video display widget.
  final VideoStyle videoStyle;

  /// The callback function execute when user tapped the rewind button.
  final ValueChanged<VideoPlayerValue>? onRewind;

  /// The callback function execute when user tapped the forward button.
  final ValueChanged<VideoPlayerValue>? onFastForward;
  GlobalKey videoQualityKey = GlobalKey();
  // final Duration progress;
  // final Duration total;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showBottomBar,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            centerIcons(),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: onPlayButtonTap,
                            child: () {
                              var defaultIcon = Icon(
                                controller.value.isPlaying
                                    ? Icons.pause_circle_outline
                                    : Icons.play_circle_outline,
                                color: videoStyle.playButtonIconColor ??
                                    Colors.white,
                                size: videoStyle.playButtonIconSize ?? 10.0,
                              );

                              if (videoStyle.playIcon != null &&
                                  videoStyle.pauseIcon == null) {
                                return controller.value.isPlaying
                                    ? defaultIcon
                                    : videoStyle.playIcon;
                              } else if (videoStyle.pauseIcon != null &&
                                  videoStyle.playIcon == null) {
                                return controller.value.isPlaying
                                    ? videoStyle.pauseIcon
                                    : defaultIcon;
                              } else if (videoStyle.playIcon != null &&
                                  videoStyle.pauseIcon != null) {
                                return controller.value.isPlaying
                                    ? videoStyle.pauseIcon
                                    : videoStyle.playIcon;
                              }

                              return defaultIcon;
                            }(),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            videoSeek,
                            style: videoStyle.videoSeekStyle ??
                                const TextStyle(
                                    color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            "/$videoDuration",
                            style: videoStyle.videoDurationStyle ??
                                const TextStyle(
                                    color: Colors.white, fontSize: 14),
                          ),
                        ],
                      )),
                  Transform.translate(
                    offset: const Offset(0.0, -4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     controller.rewind().then((value) {
                        //       onRewind?.call(controller.value);
                        //     });
                        //   },
                        //   child: videoStyle.backwardIcon ??
                        //       Icon(
                        //         Icons.fast_rewind_rounded,
                        //         color: videoStyle.forwardIconColor,
                        //         size: videoStyle.forwardAndBackwardBtSize,
                        //       ),
                        // ),
                        InkWell(
                          onTap: () => () {},
                          child: const Icon(
                            Icons.volume_mute,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        VideoQualityWidget(
                          key: videoQualityKey,
                          videoStyle: videoStyle,
                          onTap: onQualityTap,
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: onFullScreenTap,
                          child: const Icon(
                            Icons.fullscreen,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     controller.fastForward().then((value) {
                        //       onFastForward?.call(controller.value);
                        //     });
                        //   },
                        //   child: videoStyle.forwardIcon ??
                        //       Icon(
                        //         Icons.fast_forward_rounded,
                        //         color: videoStyle.forwardIconColor,
                        //         size: videoStyle.forwardAndBackwardBtSize,
                        //       ),
                        // ),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 16.0),
                  //   child: Text(
                  //     videoDuration,
                  //     style: videoStyle.videoDurationStyle ??
                  //         const TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 10, left: 10, right: 10),
              child:
                  // ProgressBar(
                  //   progress: progress,
                  //   total: total,
                  //   progressBarColor: Colors.red,
                  //   bufferedBarColor: Colors.white.withOpacity(0.24),
                  //   thumbColor: Colors.red,
                  // )
                  VideoProgressIndicator(
                controller,
                allowScrubbing: videoStyle.allowScrubbing ?? true,
                colors: videoStyle.progressIndicatorColors ??
                    const VideoProgressColors(
                        playedColor: Colors.red, bufferedColor: Colors.red),
                padding: videoStyle.progressIndicatorPadding ?? EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget centerIcons() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              controller.rewind().then((value) {
                onRewind?.call(controller.value);
              });
            },
            child: videoStyle.backwardIcon ??
                Icon(
                  Icons.fast_rewind_rounded,
                  color: videoStyle.forwardIconColor,
                  size: videoStyle.forwardAndBackwardBtSize,
                ),
          ),
          InkWell(
            onTap: onPlayButtonTap,
            child: () {
              var defaultIcon = Icon(
                controller.value.isPlaying
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline,
                color: videoStyle.playButtonIconColor ?? Colors.white,
                size: videoStyle.playButtonIconSize ?? 10.0,
              );

              if (videoStyle.playIcon != null && videoStyle.pauseIcon == null) {
                return controller.value.isPlaying
                    ? defaultIcon
                    : videoStyle.playIcon;
              } else if (videoStyle.pauseIcon != null &&
                  videoStyle.playIcon == null) {
                return controller.value.isPlaying
                    ? videoStyle.pauseIcon
                    : defaultIcon;
              } else if (videoStyle.playIcon != null &&
                  videoStyle.pauseIcon != null) {
                return controller.value.isPlaying
                    ? videoStyle.pauseIcon
                    : videoStyle.playIcon;
              }

              return defaultIcon;
            }(),
          ),
          InkWell(
            onTap: () {
              controller.fastForward().then((value) {
                onFastForward?.call(controller.value);
              });
            },
            child: videoStyle.forwardIcon ??
                Icon(
                  Icons.fast_forward_rounded,
                  color: videoStyle.forwardIconColor,
                  size: videoStyle.forwardAndBackwardBtSize,
                ),
          ),
        ],
      ),
    );
  }
}
