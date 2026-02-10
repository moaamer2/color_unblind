import 'dart:io';
import 'package:colors_blind/core/extensions/context/media_query.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePIckerWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final void Function(XFile pickedImage)? onImagePicked;
  final ImageProvider? initImage;
  const ImagePIckerWidget(
      {super.key, this.onImagePicked, this.height, this.width,this.initImage});

  @override
  State<ImagePIckerWidget> createState() => _ImagePIckerWidgetState();
}

class _ImagePIckerWidgetState extends State<ImagePIckerWidget> {
  final ImagePicker picker = ImagePicker();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: () async {
            final XFile? pickedImage =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              setState(() {
                imageFile = File(pickedImage.path);
              });
              widget.onImagePicked?.call(pickedImage);
            }
          },
          child: Container(
            height: widget.height ?? 100,
            width: widget.width ?? context.screenWidth,
            decoration: BoxDecoration(
              color: AppColors.veryLightGrey,
              borderRadius: BorderRadius.circular(
                16.fromRadius,
              ),
              image: (imageFile != null || widget.initImage != null)
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: imageFile == null ? widget.initImage! : FileImage(imageFile!),
                    )
                  : null,
            ),
            child: imageFile == null
                ? Icon(
                    widget.initImage == null ? Icons.add_a_photo : Icons.edit,
                    color: AppColors.grey,
                    size: 30.fromRadius,
                  )
                : null,
          ),
        );
      },
    );
  }
}
