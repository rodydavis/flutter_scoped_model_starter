import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../general/shadow_text.dart';

class VideoTile extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final String title, description, image, date, id;
  final bool listView;

  VideoTile({
    @required this.id,
    @required this.title,
    @required this.date,
    @required this.description,
    @required this.image,
    this.onPressed,
    this.onLongPress,
    this.listView = false,
  });

  @override
  Widget build(BuildContext context) {
    if (listView) {
      return (Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]))),
        child: ListTile(
          leading: image == null || image.isEmpty
              ? null
              : SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: Hero(
                    tag: id ?? DateTime.now().toString(),
                    child: Image.network(
                      image + mediumQuality,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          title: Text(
            title,
            maxLines: 1,
            textScaleFactor: textScaleFactor,
          ),
          subtitle: Text(
            description,
            maxLines: 3,
            textScaleFactor: textScaleFactor,
          ),
          trailing: Text(
            date,
            textScaleFactor: textScaleFactor,
          ),
          onTap: onPressed,
          onLongPress: onLongPress,
        ),
      ));
    }
    return (InkWell(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.all(1.0),
        child: GridTile(
          header: ShadowText(
            title,
            maxLines: 1,
            textAlign: TextAlign.center,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
          ),
          footer: ShadowText(
            date,
            textScaleFactor: textScaleFactor,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white),
          ),
          child: Hero(
            tag: id ?? DateTime.now().toString(),
            child: Image.network(
              image + mediumQuality,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ));
  }
}
