import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;

  const ShadowText(
    this.data, {
    Key key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  }) : assert(data != null);

  Widget build(BuildContext context) {
    AlignmentDirectional _align;
    switch (textAlign) {
      case TextAlign.justify:
      case TextAlign.center:
        _align = AlignmentDirectional.center;
        break;
      case TextAlign.end:
      case TextAlign.right:
        _align = AlignmentDirectional.centerEnd;
        break;
      case TextAlign.start:
      case TextAlign.left:
        _align = AlignmentDirectional.centerStart;
        break;
      default:
        _align = AlignmentDirectional.center;
    }
    return new ClipRect(
      child: new Stack(
        alignment: _align,
        children: [
          Text(
            data,
            style: style.copyWith(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.bold,
            ),
            textAlign: textAlign,
            textDirection: textDirection,
            softWrap: softWrap,
            overflow: overflow,
            textScaleFactor: textScaleFactor + 0.03,
            maxLines: maxLines,
          ),
          new Text(
            data,
            style: style,
            textAlign: textAlign,
            textDirection: textDirection,
            softWrap: softWrap,
            overflow: overflow,
            textScaleFactor: textScaleFactor,
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }
}
