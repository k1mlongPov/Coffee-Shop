import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkController extends GetxController {
  Future<void> launchUrlSiteBrowser({required String url}) async {
    final Uri urlParsed = Uri.parse(url);

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
