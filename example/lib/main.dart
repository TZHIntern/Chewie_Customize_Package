import 'package:flutter/material.dart';
import 'package:chitmaymay_player/chitmaymay_player.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool fullscreen = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: Padding(
          padding:
              fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top: 32.0),
          child: ChitMayMayPlayer(
            aspectRatio: 16 / 9,
            url:
                "https://storage.googleapis.com/chitmaymayappvideo/Upload/Video/2023/05/23/20230523_060425/646c576922d6a.m3u8",
            allowCacheFile: true,
            onCacheFileCompleted: (files) {
              print('Cached file length ::: ${files?.length}');

              if (files != null && files.isNotEmpty) {
                for (var file in files) {
                  print('File path ::: ${file.path}');
                }
              }
            },
            onCacheFileFailed: (error) {
              print('Cache file error ::: $error');
            },
            videoStyle: const VideoStyle(
              qualityStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),

              forwardAndBackwardBtSize: 30.0,
              playButtonIconSize: 40.0,
              playIcon: Icon(
                Icons.play_arrow,
                size: 26.0,
                color: Colors.white,
              ),
              pauseIcon: Icon(
                Icons.pause_outlined,
                size: 26.0,
                color: Colors.white,
              ),
              videoQualityPadding: EdgeInsets.all(5.0),
              // showLiveDirectButton: true,
              // enableSystemOrientationsOverride: false,
            ),
            videoLoadingStyle: VideoLoadingStyle(
              loading: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(height: 16.0),
                    CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            onFullScreen: (value) {
              setState(() {
                if (fullscreen != value) {
                  fullscreen = value;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
