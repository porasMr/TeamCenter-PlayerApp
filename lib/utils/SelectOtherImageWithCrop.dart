import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'AppColors.dart';
import 'AppImages.dart';
import 'AppTextSize.dart';
import 'SelectImageInterface.dart';
import 'TeamCenterLocalizations.dart';

class SelectImageWithCrop {
  static void photoClickDiloag(BuildContext context, SelectedImage callBack) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 4.0, // soften the shadow
                      offset: Offset(
                        2.0, // Move to right 10  horizontally
                        2.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: AppTextSize.textSize18(
                      TeamCenterLocalizations.of(context)!.find('Selectsource'),
                      Colors.black,
                      FontWeight.bold,
                      "rubikregular",
                      1),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: AppColors.mediumGrey,
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  getImage(ImageSource.camera, callBack);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.camera,
                        width: 25,
                        height: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AppTextSize.textSize14(
                          TeamCenterLocalizations.of(context)!
                              .find('Fromcamera'),
                          AppColors.blue,
                          FontWeight.bold,
                          "rubikregular",
                          1),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  getImage(ImageSource.gallery, callBack);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.galery,
                        width: 25,
                        height: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AppTextSize.textSize14(
                          TeamCenterLocalizations.of(context)!
                              .find('Fromlocalgallery'),
                          AppColors.blue,
                          FontWeight.bold,
                          "rubikregular",
                          1),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ]),
          );
        });
  }

  //------------------------------
  static File? _selectedImage;
  static String? _imagePath = "";
  static getImage(ImageSource source, SelectedImage callBack) async {
    File? image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    File? cropped = await ImageCropper.cropImage(
        sourcePath: image!.path,
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarColor: AppColors.whiteColor[500],
            backgroundColor: AppColors.whiteColor[500],
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: true,
        ));

    if (cropped != null) {
      _selectedImage = cropped;
      _imagePath = _selectedImage!.path.toString();
      callBack.onImage(_imagePath);
    } else {
      _imagePath = image.path.toString();
      callBack.onImage(_imagePath);
    }
  }
}
