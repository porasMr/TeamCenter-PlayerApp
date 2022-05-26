import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'AppColors.dart';

class FullScreenImage extends StatefulWidget {
  var url;
  bool? isDrawingData = false;
  FullScreenImage({this.url, this.isDrawingData});
  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(1.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.url,
                    imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: PhotoView(
                          imageProvider: imageProvider,
                        )),
                    placeholder: (context, url) => Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Container(child: Icon(Icons.perm_identity)),
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
