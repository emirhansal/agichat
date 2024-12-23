import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:agichat/models/model_alert_dialog.dart';
import 'package:agichat/models/model_file.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agichat/enums/enum_app.dart' as enumApp;
import 'permission_utils.dart';

const List<String> allowedExtensions = ['pdf'];

class AlertUtils {
  static Future<void> showPlatformAlert(BuildContext context, ModelAlertDialog model) async {
    final result = await showAlertDialog(
      context: context,
      title: AppStrings.appName,
      message: model.description,
      barrierDismissible: model.isDismissible!,
      style: AdaptiveStyle.adaptive,
      actions: model.isActiveCancelButton!
          ? [
              AlertDialogAction(
                label: R.string.cancel,
                key: OkCancelAlertDefaultType.cancel,
                textStyle: TextStyle(color: R.color.gray),
              ),
              AlertDialogAction(label: R.string.ok, key: OkCancelAlertDefaultType.ok, textStyle: TextStyle(color: R.color.primary))
            ]
          : [AlertDialogAction(label: R.string.ok, key: OkCancelAlertDefaultType.ok, textStyle: TextStyle(color: R.color.primary))],
    );

    if (result == OkCancelAlertDefaultType.ok && model.onPressedButton != null) model.onPressedButton!();
  }
  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: R.color.black,
      textColor: R.color.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void hideSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void showInSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String value) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(value),
        showCloseIcon: true,
        closeIconColor: R.color.white,
      ),
    );
  }


  static Future<List<ModelFile>> chooseFileSource(
    BuildContext context, {
    bool isActivePhotoPick = true,
    bool isActivePhotoTake = true,
    bool isActiveVideoPick = true,
    bool isActiveVideoTake = true,
    bool isActiveFileTake = true,
  }) async {
    final files = <ModelFile>[];
    final fileType = await showCupertinoModalPopup<enumApp.FileType?>(
      context: context,
      builder: (context) => CupertinoTheme(
        data: const CupertinoThemeData(brightness: Brightness.dark),
        child: CupertinoActionSheet(
          actions: [
            if (isActivePhotoPick)
              CupertinoActionSheetAction(
                child: Text(R.string.pickPhoto),
                onPressed: () => Navigator.pop(context, enumApp.FileType.camera),
              ),
            if (isActivePhotoTake)
              CupertinoActionSheetAction(
                child: Text(R.string.selectPhoto),
                onPressed: () => Navigator.pop(context, enumApp.FileType.gallery),
              ),
            if (isActiveFileTake)
              CupertinoActionSheetAction(
                child: Text(R.string.file),
                onPressed: () => Navigator.pop(context, enumApp.FileType.pdf),
              ),
            if (isActiveVideoPick)
              CupertinoActionSheetAction(
                child: Text(R.string.pickVideo),
                onPressed: () => Navigator.pop(context, enumApp.FileType.videoCamera),
              ),
            if (isActiveVideoTake)
              CupertinoActionSheetAction(
                child: Text(R.string.selectVideo),
                onPressed: () => Navigator.pop(context, enumApp.FileType.videoGallery),
              ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: Text(R.string.cancel),
          ),
        ),
      ),
    );

    if (fileType != null) {
      final picker = ImagePicker();
      if (context.mounted) {
        if (fileType == enumApp.FileType.videoGallery) {
          if (context.mounted) {}
          if (await accessGalleryVideosPermission(context)) {
            final file = await picker.pickVideo(source: ImageSource.gallery);
            if (file != null) {
              final f = ModelFile(path: File(file.path).path, type: fileType);
              files.add(f);
            }
          }
        } else if (fileType == enumApp.FileType.videoCamera) {
          if (await accessCameraPermission(context)) {
            final file = await picker.pickVideo(source: ImageSource.camera);
            if (file != null) {
              final f = ModelFile(path: File(file.path).path, type: fileType);
              files.add(f);
            }
          }
        } else if (fileType == enumApp.FileType.camera) {
          if (await accessCameraPermission(context)) {
            final file = await picker.pickImage(source: ImageSource.camera);
            if (file != null) {
              final f = ModelFile(path: File(file.path).path, type: fileType);
              files.add(f);
            }
          }
        } else if (fileType == enumApp.FileType.gallery) {
          if (await accessGalleryPermission(context)) {
            final f = await picker.pickMultiImage();
            files.addAll(f.map((e) => ModelFile(path: File(e.path).path, type: fileType)));
          }
        }
      }
    }
    return files;
  }
}
