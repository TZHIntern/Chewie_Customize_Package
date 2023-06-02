import 'package:flutter/material.dart';
import 'package:chitmaymay_player/chitmaymay_player.dart';
import 'package:chitmaymay_player/src/model/m3u8.dart';
import 'package:path/path.dart';

class VideoQualityPicker extends StatefulWidget {
  final List<M3U8Data> videoData;
  final bool showPicker;
  final double? positionRight;
  final double? positionTop;
  final double? positionLeft;
  final double? positionBottom;
  final VideoStyle videoStyle;
  final void Function(M3U8Data data)? onQualitySelected;

  const VideoQualityPicker({
    Key? key,
    required this.videoData,
    this.videoStyle = const VideoStyle(),
    this.showPicker = false,
    this.positionRight,
    this.positionTop,
    this.onQualitySelected,
    this.positionLeft,
    this.positionBottom,
  }) : super(key: key);

  @override
  State<VideoQualityPicker> createState() => _VideoQualityPickerState();
}

class _VideoQualityPickerState extends State<VideoQualityPicker> {
  late var currentQuality = 0;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.showPicker,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            widget.videoData.length,
            (index) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      widget.onQualitySelected?.call(widget.videoData[index]);
                      currentQuality = index;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22, left: 25),
                      child: Row(
                        children: [
                          currentQuality == index
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : Container(),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.videoData[index].dataQuality}",
                            style: widget.videoStyle.qualityOptionStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
