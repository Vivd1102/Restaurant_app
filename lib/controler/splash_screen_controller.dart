import 'package:get/get.dart';
import 'package:zensar_recipe_app/screens/welcome_screen.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _goToWelcomeScreenPage();
  }

  void _goToWelcomeScreenPage() async {
    await Future.delayed(Duration(seconds: 2));
    Get.off(() => WelcomeScreen());
  }
}
