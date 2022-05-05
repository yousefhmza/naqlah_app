import 'package:url_launcher/url_launcher.dart';

import '../../core/resources/strings_manager.dart';
import '../../core/utils/alerts.dart';

class MainHelper {
  MainHelper._privateConstructor();

  static final MainHelper instance = MainHelper._privateConstructor();

  Future<void> launch(String url) async {
    final Uri _url = Uri.parse(url);
    final bool _canLaunch = await canLaunchUrl(_url);
    if (_canLaunch) {
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    } else {
      Alerts.showToast(AppStrings.errorMessage);
    }
  }
}
