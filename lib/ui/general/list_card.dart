import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  final List<Widget> children;
  final bool initiallyExpanded, hideShowAllButton;
  final Widget leading, title, onEmpty;

  ListCard({
    this.children,
    this.initiallyExpanded = true,
    this.hideShowAllButton = true,
    this.leading,
    this.title,
    this.onEmpty,
  });

  @override
  ListCardState createState() {
    return new ListCardState();
  }
}

class ListCardState extends State<ListCard> {
  bool _showAll = false;
  @override
  Widget build(BuildContext context) {
    if (widget?.children == null) {
      return Card(
        child: ExpansionTile(
            title: widget.title,
            leading: widget.leading,
            initiallyExpanded: widget.initiallyExpanded,
            children: <Widget>[
              ListTile(
                title: Text("Loading..."),
                trailing: CircularProgressIndicator(),
              ),
            ]),
      );
    }

    if (widget.children.isEmpty) {
      return Card(
        child: ExpansionTile(
            title: widget.title,
            leading: widget.leading,
            initiallyExpanded: widget.initiallyExpanded,
            children: <Widget>[
              ListTile(
                title: widget.onEmpty ?? Text("No Items Found"),
              ),
            ]),
      );
    }

    if (_showAll || widget.children.length <= 5 || widget.hideShowAllButton) {
      return Card(
        child: ExpansionTile(
          title: widget.title,
          leading: widget.leading,
          initiallyExpanded: widget.initiallyExpanded,
          children: <Widget>[]
            ..addAll(widget.children)
            ..add(
              Container(
                  child: widget.hideShowAllButton || widget.children.length <= 5
                      ? null
                      : ListTile(
                          title: RaisedButton(
                            onPressed: () {
                              setState(() {
                                _showAll = false;
                              });
                            },
                            child: Text("Hide"),
                          ),
                        )),
            ),
        ),
      );
    }

    return Card(
      child: ExpansionTile(
        title: widget.title,
        leading: widget.leading,
        initiallyExpanded: widget.initiallyExpanded,
        children: <Widget>[]
          ..addAll(widget.children.getRange(0, 5)?.toList())
          ..add(
            Container(
                child: widget.hideShowAllButton
                    ? null
                    : ListTile(
                        title: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _showAll = true;
                            });
                          },
                          child: Text("Show All"),
                        ),
                      )),
          ),
      ),
    );
  }
}

class ExpandingListTile extends StatefulWidget {
  final String title, subtitle;
  final Widget leading;

  ExpandingListTile({this.subtitle, this.title, this.leading});

  @override
  ExpandingListTileState createState() {
    return new ExpandingListTileState();
  }
}

class ExpandingListTileState extends State<ExpandingListTile> {
  bool _showMore = false;

  var controller = TextEditingController();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        mytext = controller.text;
      });
    });
    controller.text = widget.title;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String mytext = "";

  @override
  Widget build(BuildContext context) {
    if (_showMore) {
      return ListTile(
        title: Text(widget.title),
        subtitle: widget.subtitle == null ? null : Text(widget.subtitle),
      );
    }

    int maxLines = 1;
    double fontSize = 30.0;

    return LayoutBuilder(builder: (context, size) {
      // Build the textspan
      var span = TextSpan(
        text: mytext,
        style: TextStyle(fontSize: fontSize),
      );

      // Use a textpainter to determine if it will exceed max lines
      var tp = TextPainter(
        maxLines: maxLines,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        text: span,
      );

      // trigger it to layout
      tp.layout(maxWidth: size.maxWidth);

      // whether the text overflowed or not
      var exceeded = tp.didExceedMaxLines;

      return ListTile(
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: widget.subtitle == null ? null : Text(widget.subtitle),
        trailing: !exceeded
            ? null
            : IconButton(
                icon: Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _showMore = true;
                  });
                }),
      );
    });
  }
}

//typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);
