import 'package:flutter/material.dart';
import '../bloc/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  const Refresh({this.child});


  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async{
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
