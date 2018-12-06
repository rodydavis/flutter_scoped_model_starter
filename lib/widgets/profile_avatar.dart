import 'package:flutter/material.dart';

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
    if (hideImage || imageURL == null || imageURL.isEmpty) {
      return new CircleAvatar(
        backgroundColor: Colors.brown,
        child: new Text(noImageText ?? "No URL"),
      );
    }
    return new CircleAvatar(
      backgroundColor: Colors.brown,
      backgroundImage: NetworkImage(imageURL),
    );
  }
}
