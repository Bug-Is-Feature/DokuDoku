import 'dart:io';

import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/image_service.dart';
import 'package:dokudoku/services/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditImageUploadWidget extends StatefulWidget {
  final LibraryBooks libraryBook;
  final void Function(String) imageCallback;

  const EditImageUploadWidget({
    super.key,
    required this.imageCallback,
    required this.libraryBook,
  });

  @override
  State<EditImageUploadWidget> createState() => _EditImageUploadWidgetState();
}

class _EditImageUploadWidgetState extends State<EditImageUploadWidget> {
  final StorageService storage = StorageService();
  File? fileImage;
  bool imageTooLarge = false;
  bool isUploadFailed = false;
  ImageProvider image =
      const AssetImage('assets/images/upload-image-placeholder.png');

  void _getImageFrom({required ImageSource source}) async {
    final pickedImage = await ImageService.imagePicker(source: source);
    setState(() => imageTooLarge = false);

    if (pickedImage != null) {
      if (pickedImage.lengthSync() / 1024 > 100) {
        setState(() => imageTooLarge = true);
      } else {
        setState(() => fileImage = pickedImage);
        widget.imageCallback(pickedImage.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoActionSheet(
            title: const Text(
              'Upload Image',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              _buildCupertinoActionSheetAction(
                icon: Icons.camera_alt,
                title: 'Take Photo',
                voidCallback: () {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.camera);
                },
              ),
              _buildCupertinoActionSheetAction(
                icon: Icons.image,
                title: 'Gallery',
                voidCallback: () {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.gallery);
                },
              ),
              _buildCupertinoActionSheetAction(
                title: 'Cancel',
                textColor: Colors.red,
                voidCallback: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
      child: Column(
        children: [
          FutureBuilder(
            future: ImageService.getImageUrl(
                imageRef: widget.libraryBook.book.thumbnail),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: widget.libraryBook.book.thumbnail == ''
                      ? BoxDecoration(
                          border: Border.all(
                            color: isUploadFailed ? Colors.red : Colors.black12,
                            width: 1,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.transparent,
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/upload-image-placeholder.png'),
                            fit: BoxFit.cover,
                          ),
                        )
                      : widget.libraryBook.book.thumbnail.substring(0, 4) ==
                              'gs::'
                          ? BoxDecoration(
                              border: Border.all(
                                color: isUploadFailed
                                    ? Colors.red
                                    : Colors.black12,
                                width: 1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: fileImage != null
                                    ? FileImage(fileImage!)
                                    : Image.network(snapshot.data.toString())
                                        .image,
                              ),
                            )
                          : BoxDecoration(
                              border: Border.all(
                                color: isUploadFailed
                                    ? Colors.red
                                    : Colors.black12,
                                width: 1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.transparent,
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/upload-image-placeholder.png'),
                                fit: BoxFit.cover,
                              ),
                            )

                  //   fileImage != null
                  //       ? BoxDecoration(
                  //           border: Border.all(
                  //             color: isUploadFailed ? Colors.red : Colors.black12,
                  //             width: 1,
                  //           ),
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(10)),
                  //           color: Colors.transparent,
                  //           image: DecorationImage(
                  //             image: FileImage(fileImage!),
                  //             // fit: BoxFit.cover,
                  //           ),
                  //         )
                  //       : BoxDecoration(
                  //           border: Border.all(
                  //             color: imageTooLarge ? Colors.red : Colors.black12,
                  //             width: 1,
                  //           ),
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(10)),
                  //           color: Colors.transparent,
                  //           image:
                  //               DecorationImage(
                  //                   image: widget.libraryBook.book.thumbnail == ''
                  //                       ? const AssetImage(
                  //                           'assets/images/upload-image-placeholder.png')
                  //                       : widget.libraryBook.book.thumbnail
                  //                                   .substring(0, 4) ==
                  //                               'gs::'
                  //                           ? Image.network(
                  //                                   snapshot.data.toString())
                  //                               .image
                  //                           : const AssetImage(
                  //                               'assets/images/upload-image-placeholder.png'),
                  //                   fit: widget.libraryBook.book.thumbnail == ''
                  //                       ? BoxFit.cover
                  //                       : widget.libraryBook.book.thumbnail
                  //                                   .substring(0, 4) ==
                  //                               'gs::'
                  //                           ? null
                  //                           : BoxFit.cover),
                  //         ),
                  );
            },
          ),
          if (imageTooLarge)
            const Text(
              'The image is too large, please compress the image or choose other smaller image.',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          if (isUploadFailed)
            const Text(
              'Upload unsuccessfully, please try again.',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          //   if (widget.libraryBook.book.thumbnail == '')
          //     ...[]
          //   else if (widget.libraryBook.book.thumbnail.substring(0, 4) ==
          //       'gs::') ...[
          //     const SizedBox(
          //       height: 10,
          //     ),
          //     ElevatedButton(
          //       onPressed: () => setState(() {
          //         fileImage = null;
          //         widget.imageCallback('');
          //       }),
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: context.resources.color.colorDarkest,
          //         minimumSize: const Size.fromHeight(50),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //       child: const Text(
          //         'Clear Image',
          //         style: TextStyle(
          //           fontSize: 16,
          //         ),
          //       ),
          //     ),
          //   ],
        ],
      ),
    );
  }

  CupertinoActionSheetAction _buildCupertinoActionSheetAction({
    IconData? icon,
    required String title,
    required VoidCallback voidCallback,
    Color? iconColor,
    textColor,
  }) {
    return CupertinoActionSheetAction(
      onPressed: voidCallback,
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor ?? const Color(0xFF2564AF),
            ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? const Color(0xFF2564AF),
              ),
            ),
          ),
          if (icon != null)
            const SizedBox(
              width: 25,
            ),
        ],
      ),
    );
  }
}
