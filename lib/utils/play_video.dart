import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

import 'AppColors.dart';

class PlayVideoScreen extends StatefulWidget {
  var url;

  PlayVideoScreen({this.url});
  @override
  _PlayVideoScreenState createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  VideoPlayerController? _videocontroller;
  ChewieController? chewieController;
  @override
  void initState() {
    super.initState();
    _videocontroller = VideoPlayerController.network(widget.url);

    inilization();
  }

  @override
  inilization() async {
    await _videocontroller!.initialize().then((value) {
      setState(() {});
    });
    _videocontroller!.addListener(listener);
    chewieController = ChewieController(
      videoPlayerController: _videocontroller!,
      autoPlay: true,
      looping: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videocontroller!.dispose();
    chewieController!.dispose();
  }

  void listener() {
    setState(() {
      if (chewieController!.isPlaying) {
        if (Platform.isIOS) {
          if (chewieController!.isFullScreen) {
          } else {
            WidgetsFlutterBinding.ensureInitialized();
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor[500],
      body: SafeArea(
          top: false,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios,
                            size: 24, color: AppColors.blue),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(height: 1, color: AppColors.strokeColor),
              AspectRatio(
                aspectRatio: _videocontroller!.value.aspectRatio,
                child: chewieController != null
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                        child: Chewie(
                          controller: chewieController!,
                        ),
                      )
                    : Container(),
              ),
            ]),
          )),
    );
  }
}
