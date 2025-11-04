import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lelang_app/configs/colors/colors_planet.dart';
import 'package:lelang_app/screens/get_started_screen.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IntroductionScreen(
            // pages: listPagesViewModel,
            rawPages: [
              _page(
                imagePath: "assets/introduction_image_3.jpeg",
                title: "Welcome to APP_NAME!",
                description:
                    "APP_NAME is here. With cutting-edge technology and user-friendly design, we're excited to embark on this journey with you.",
              ),
              _page(
                imagePath: "assets/introduction_image_2.jpeg",
                title: "Explore Exciting Features",
                description:
                    "Discover a range of features designed to simplify your life. From FEATURE_1 to FEATURE_2, APP_NAME has everything you need to APP_BENEFIT.",
              ),
              _page(
                imagePath: "assets/introduction_image_1.jpeg",
                title: "Let's Get Started!",
                description:
                    "Ready to experience the future of APP_FOCUS? Tap the button below to begin your journey with APP_NAME. Welcome aboard!",
              )
            ],
            onDone: () => Get.offAll(() => GetStarted()),
            showSkipButton: true,
            skip: Text(
              "Skip",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorPlanet.primary,
              ),
            ),
            skipStyle: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor: ColorPlanet.secondary,
              elevation: 0,
            ),
            next: Text(
              "Next",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            nextStyle: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor: ColorPlanet.primary,
              elevation: 0,
            ),
            done: const Text(
              "Start",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
            doneStyle: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor: ColorPlanet.primary,
              elevation: 0,
            ),
            dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(24.0, 10.0),
              activeColor: ColorPlanet.primary,
              color: Colors.grey.shade300,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
          _gradient(context),
        ],
      ),
    );
  }

  Positioned _gradient(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        ignoring: true,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.3),
                Colors.white.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _page({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Get.width * 0.9,
            child: Center(
              child: Image.asset(imagePath),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.poppins(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // List<PageViewModel> get listPagesViewModel {
  //   return [
  //     PageViewModel(
  //       titleWidget: Text(
  //         "Welcome to APP_NAME!",
  //         style: GoogleFonts.poppins(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 28,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //       bodyWidget: Text(
  //         "APP_NAME is here to revolutionize the way you APP_PURPOSE. With cutting-edge technology and user-friendly design, we're excited to embark on this journey with you.",
  //         style: GoogleFonts.poppins(fontSize: 14),
  //         textAlign: TextAlign.center,
  //       ),
  // image: Container(
  //   width: Get.width * 0.9,
  //
  //   child: Center(
  //     child: Image.asset("assets/introduction_image_3.jpeg"),
  //   ),
  // ),
  //     ),
  //     PageViewModel(
  //       titleWidget: Text(
  //         " Explore Exciting Features",
  //         style: GoogleFonts.poppins(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 28,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //       bodyWidget: Text(
  //         "Discover a range of features designed to simplify your life. From FEATURE_1 to FEATURE_2, APP_NAME has everything you need to APP_BENEFIT.",
  //         style: GoogleFonts.poppins(fontSize: 14),
  //         textAlign: TextAlign.center,
  //       ),
  //       image: Container(
  //         width: Get.width * 0.9,
  //
  //         child: Center(
  //           child: Image.asset("assets/introduction_image_2.jpeg"),
  //         ),
  //       ),
  //     ),
  //     PageViewModel(
  //       titleWidget: Text(
  //         "Let's Get Started!",
  //         style: GoogleFonts.poppins(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 28,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //       bodyWidget: Text(
  //         "Ready to experience the future of APP_FOCUS? Tap the button below to begin your journey with APP_NAME. Welcome aboard!",
  //         style: GoogleFonts.poppins(fontSize: 14),
  //         textAlign: TextAlign.center,
  //       ),
  //       image: Container(
  //         width: Get.width * 0.9,
  //
  //         child: Center(
  //           child: Image.asset("assets/introduction_image_1.jpeg"),
  //         ),
  //       ),
  //     ),
  //   ];
  // }
}
