import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

class SelectImage extends StatefulWidget {
  const SelectImage({Key? key, required this.loading}) : super(key: key);
  final bool loading;

  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage>
    with SingleTickerProviderStateMixin {
  late AnimationController loadingController;

  File? _file;
  PlatformFile? _platformFile;

  Future<void> segmentImage(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://192.168.1.114:5001/segment'));
      request.files.add(await http.MultipartFile.fromPath(
          'image', _file!.path)); // 'image' is the key

      final response = await request.send();

      if (response.statusCode == 200) {
        Navigator.pop(context); // Hide progress indicator

        final bytes = await response.stream.toBytes();
        final image = Image.memory(
          bytes,
          width: double.infinity,
          fit: BoxFit.cover,
        );

        // Display the image in a dialog
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'Image segmented successfully',
          body: Container(
            padding: const EdgeInsets.all(8),
            child:
                ClipRRect(borderRadius: BorderRadius.circular(8), child: image),
          ),
          btnOkOnPress: () {},
        ).show();
      } else {
        Navigator.pop(context); // Hide progress indicator

        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Error',
          body: Image.asset('assets/error.png'),
          btnOkOnPress: () {},
        ).show();
        print(response.reasonPhrase);
      }
    } catch (error) {
      Navigator.pop(context); // Hide progress indicator
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        body: Image.asset('assets/error.png'),
      ).show();
    }
  }

  selectFile() async {
    setState(() {
      _platformFile = null;
      loadingController.reset();
    });
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
    }

    loadingController.forward();
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Text(
            'Upload Your Image To Segment',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'The image will be analyzed and segmented to detect objects in the image',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
          ),
          const SizedBox(
            height: 20,
          ),
          AnimatedSwitcher(
            switchInCurve: Curves.elasticOut,
            switchOutCurve: Curves.ease,
            reverseDuration: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 1200),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: widget.loading
                ? const CircularProgressIndicator.adaptive()
                : GestureDetector(
                    onTap: selectFile,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 20.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          color: const Color(0xffC53F3F),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade50.withOpacity(.3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Iconsax.folder_open,
                                  color: Color(0xffC53F3F),
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select your image',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
          ),
          _platformFile != null
              ? Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected File',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(0, 1),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _file!,
                                    width: 70,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _platformFile!.name,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${(_platformFile!.size / 1024).ceil()} KB',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        height: 5,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.blue.shade50,
                                        ),
                                        child: LinearProgressIndicator(
                                          value: loadingController.value,
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ))
              : Container(),
          AnimatedSwitcher(
            switchInCurve: Curves.elasticOut,
            switchOutCurve: Curves.ease,
            reverseDuration: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 1200),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: _file != null &&
                    loadingController.isCompleted &&
                    _platformFile != null
                ? Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Original Image',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(0, 1),
                                    blurRadius: 3,
                                    spreadRadius: 2,
                                  )
                                ]),
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      _file!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [

                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _file = null;
                                          _platformFile = null;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(100, 50),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 15),
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: const Text('Clear'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        segmentImage(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(100, 50),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 15),
                                          textStyle: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      child: const Text('Segment'),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : const Text(""),
          ),
        ],
      ),
    );
  }
}
