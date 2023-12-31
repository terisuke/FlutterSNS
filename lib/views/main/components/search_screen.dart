// flutter
import 'package:flutter/material.dart';
// constants
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen(
      {Key? key, required this.onQueryChanged, required this.child})
      : super(key: key);
  final void Function(String)? onQueryChanged;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      onQueryChanged: onQueryChanged,
      clearQueryOnClose: true,
      body: IndexedStack(
          children: [FloatingSearchBarScrollNotifier(child: child)]),
      builder: (context, transition) {
        return Container();
      },
    );
  }
}
