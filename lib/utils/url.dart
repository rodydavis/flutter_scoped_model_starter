import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    }
  } catch (e) {
    print(e);
  }
}
