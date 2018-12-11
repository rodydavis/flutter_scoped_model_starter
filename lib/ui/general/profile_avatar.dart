import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../utils/network_image_ssl.dart';

class AvatarWidget extends StatelessWidget {
  final String imageURL, noImageText;
  final bool hideImage;

  AvatarWidget({
    this.imageURL,
    this.noImageText,
    this.hideImage = false,
  });

  @override
  Widget build(BuildContext context) {
    String _url = imageURL;
    if (devMode) {
      _url = imageURL.replaceAll("www", "devm");
    }
    if (hideImage || _url == null || _url.isEmpty) {
      return new CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: new Text(noImageText ?? "No URL"),
      );
    }
    return new CircleAvatar(
      backgroundColor: Colors.blueGrey,
      backgroundImage: NetworkImageSSL(_url),
    );
  }
}
