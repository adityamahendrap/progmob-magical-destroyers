import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:color_log/color_log.dart';
import 'package:lelang_app/controller/profile_controller.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  XFile? _image;
  final _profileC = Get.find<ProfileController>();

  final _picker = ImagePicker();

  Future getImageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    // setState(() {
    // if (pickedImage != null) _image = pickedImage;
    // });

    if (pickedImage != null) _profileC.image.value = pickedImage;
  }

  Future getImageFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);

    // setState(() {
    // if (pickedImage != null) _image = pickedImage;
    // });

    if (pickedImage != null) _profileC.image.value = pickedImage;
  }

  Future showChangeImageOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('From Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Take Picture'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Delete Picture', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                // _image = null;
                _profileC.image.value = null;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showChangeImageOptions,
      child: Stack(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 50,
              backgroundImage: _profileC.image.value != null
                  ? FileImage(File(_profileC.image.value!.path))
                  : AssetImage(defaultImagePath) as ImageProvider,
              // backgroundImage: _image != null
              //   ? FileImage(File(_image!.path))
              //  : AssetImage('assets/magical_destroyers.jpg') as ImageProvider,
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
