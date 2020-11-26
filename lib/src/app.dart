import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'bloc/stories_provider.dart';
import 'screens/news_detail.dart';
import 'bloc/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lifting the state
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: "Hacker News",
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(
        builder: (context){
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context){
          //Get access of BLOC
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          // Fetch Items
          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(
            itemId: itemId,
          );
        }
      );
    }
  }
}
