import 'package:camera/camera.dart';
import 'package:codeshastra/features/ml/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ScanController>(
            init: ScanController(),
            builder: (controller) {
              return controller.isCameraInitialized.value
                  ? 
                  // Stack(children: [
                      CameraPreview(controller.cameraController)
                    //   ,
                    //   Positioned(
                    //     top: (controller.y ?? 0.0)* 700,
                    //     right: (controller.x ?? 0.0)*500,
                    //     child: 
                    //     Container(
                    //         width: ((controller.w?? 0.0)*100)*context.width / 100,
                    //         height: ((controller.h ?? 0.0)*100)* context.height / 100,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(8),
                    //             border:
                    //                 Border.all(color: Colors.green, width: 4.0)),
                    //         child:
                    //             Column(mainAxisSize: MainAxisSize.min, children: [
                    //           Container(
                    //             color: Colors.white,
                    //             child: const Text("Label of object"),
                    //           ),
                    //         ])),
                    //   )
                    // ])
                  : const Center(child: Text("Loading PreView..."),);
            }));
  }
}
