import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class PictureScreen extends StatefulWidget {
  const PictureScreen({super.key});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen>
    with WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  FlashMode _flashMode = FlashMode.auto;
  late CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      enableAudio:
          false, // for android emulator bug. remove this line for real device
    );

    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording(); // ony for iOS
    _flashMode = _cameraController.value.flashMode;

    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _takePicture() async {
    if (!_cameraController.value.isInitialized) return; // for safety

    final image = await _cameraController.takePicture();

    if (!mounted) return;
    Navigator.pop(context, image.path);
  }

  Future<void> _onPickVideoPressed() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;

    if (!mounted) return;
    Navigator.pop(context, image.path);
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Initializing...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size20,
                      ),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CameraPreview(_cameraController),
                        Positioned(
                          bottom: Sizes.size20,
                          child: Row(
                            children: [
                              IconButton(
                                color: _flashMode != FlashMode.off
                                    ? Colors.amber.shade200
                                    : Colors.white,
                                onPressed: () => _flashMode == FlashMode.off
                                    ? _setFlashMode(FlashMode.auto)
                                    : _setFlashMode(FlashMode.off),
                                icon: Icon(
                                  _flashMode == FlashMode.off
                                      ? Icons.flash_off_rounded
                                      : Icons.flash_on_rounded,
                                ),
                              ),
                              Gaps.h32,
                              GestureDetector(
                                onTap: _takePicture,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const SizedBox(
                                      width: Sizes.size60 + Sizes.size14,
                                      height: Sizes.size60 + Sizes.size14,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: Sizes.size4,
                                        value: 1.0,
                                      ),
                                    ),
                                    Container(
                                      width: Sizes.size60,
                                      height: Sizes.size60,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.h32,
                              IconButton(
                                color: Colors.white,
                                onPressed: _toggleSelfieMode,
                                icon: const Icon(
                                  Icons.cameraswitch,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Gaps.v32,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Spacer(),
                      const Text(
                        'Camera',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: _onPickVideoPressed,
                            child: Text(
                              'Library',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: Sizes.size24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
