import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final String search, name;

  final bool isSearching;

  final Function(String) onSearchChanged;

  AppSearchBar({
    this.search,
    this.name,
    this.onSearchChanged,
    this.isSearching = false,
  });

  @override
  Widget build(BuildContext context) {
    var title = name ?? "search".toString();
    var _theme = Theme.of(context);
    return isSearching
        ? Container(
            padding: const EdgeInsets.only(left: 8.0),
            height: 38.0,
            margin: EdgeInsets.only(bottom: 2.0),
            decoration: BoxDecoration(
              color: _theme?.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.search),
                  ),
                  border: InputBorder.none,
                  hintText: 'Search'),
              autofocus: true,
              autocorrect: false,
              onChanged: (value) => onSearchChanged(value),
            ),
          )
        : Text(title.toUpperCase());
  }
}

class AppSearchButton extends StatelessWidget {
  final bool isSearching;
  final VoidCallback onSearchPressed;
  AppSearchButton({this.onSearchPressed, this.isSearching});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isSearching ? Icons.close : Icons.search),
      tooltip: 'Search',
      onPressed: onSearchPressed,
    );
  }
}
