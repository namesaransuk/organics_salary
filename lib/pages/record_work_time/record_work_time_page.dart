import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:organics_salary/controllers/record_work_time_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

class RecordWorkTimePage extends StatefulWidget {
  final String parameter;

  const RecordWorkTimePage({super.key, required this.parameter});

  @override
  State<RecordWorkTimePage> createState() => _RecordWorkTimePageState();
}

class _RecordWorkTimePageState extends State<RecordWorkTimePage> {
  final RecordWorkTimeController recordWorkTimeController =
      Get.put(RecordWorkTimeController());

  final ImagePicker picker = ImagePicker();

  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int direction = 1;

  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {}); //To refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String parameterValue = widget.parameter;

    // if (!cameraController.value.isInitialized) {
    //   return Container();
    // }

    return Scaffold(
      backgroundColor: AppTheme.ognGreen,
      appBar: AppBar(
        title: const Text(
          'บันทึกเวลาเข้างาน',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ognGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Add your navigation logic here
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(AppTheme.ognGreen),
                        ),
                        child: const Text(
                          'ลงเวลา',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.65,
              top: -100,
              child: Transform.translate(
                offset: Offset(
                  (MediaQuery.of(context).size.width * 0.5 -
                      MediaQuery.of(context).size.width * 0.325),
                  0,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      child: !cameraController.value.isInitialized
                          ? Container(
                              color: Colors.grey[200],
                              width: double.infinity,
                              height: 415,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.flip_camera_ios_rounded,
                                    size: 50,
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              // height: 350,
                              color: Colors.grey[200],
                              child: Obx(
                                () => recordWorkTimeController
                                            .pickedFile.value !=
                                        null
                                    ? Image.file(
                                        File(recordWorkTimeController
                                            .pickedFile.value!.path),
                                        fit: BoxFit.cover)
                                    : Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(0),
                                        child: CameraPreview(cameraController)),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              direction = direction == 0 ? 1 : 0;
                              startCamera(direction);
                            });
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.flip_camera_ios_rounded,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            cameraController.takePicture().then((XFile? file) {
                              if (mounted) {
                                if (file != null) {
                                  recordWorkTimeController.pickedFile.value =
                                      file;
                                  print(
                                      "Picture saved to ${recordWorkTimeController.pickedFile.value!.path}");
                                }
                              }
                            });
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.photo_camera_rounded,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'เวลาที่สแกนเข้างาน : $parameterValue',
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
