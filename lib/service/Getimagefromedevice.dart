import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Getimagefromedevice {
  Getimagefromedevice({
    required this.cropStyle,
    required this.lockAspectRatio,
    this.cropAspectRatio,
  });
  final CropStyle cropStyle;
  final bool lockAspectRatio;
  final CropAspectRatio? cropAspectRatio;
  ImageFromDevice() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      var imageCroppedfile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: cropAspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Colors.grey.shade900,
            toolbarTitle: "edit image",
            toolbarWidgetColor: Colors.white,
            cropStyle: cropStyle,
            cropFrameColor: Colors.blue,

            navBarLight: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio3x2,
            ],

            lockAspectRatio: lockAspectRatio,
            showCropGrid: false,
          ),
        ],
      );
      if (imageCroppedfile != null) {
        return imageCroppedfile.path;
      }
    }
  }
}
