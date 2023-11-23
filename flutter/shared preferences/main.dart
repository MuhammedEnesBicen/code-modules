import 'bussiness/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalStorageService? localStorageService =
      await LocalStorageService.getInstance();
  User user = localStorageService?.user ?? User();
  bool darkMode = localStorageService?.darkMode ?? false;
  runApp(GetMaterialApp(
      home: IntroductionPage(), debugShowCheckedModeBanner: false));
}
