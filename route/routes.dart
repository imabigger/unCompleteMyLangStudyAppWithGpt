import 'package:go_router/go_router.dart';
import 'package:study_language_ai_flutter_project/common/view/home_screen.dart';
import 'package:study_language_ai_flutter_project/search/hot/view/hot_screen.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/view/self_card_rendering_screen.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/view/text_input_screen.dart';
import 'package:study_language_ai_flutter_project/search/upload/view/upload_selection_screen.dart';
import 'package:study_language_ai_flutter_project/sound/view/sound_selection.dart';
import 'package:study_language_ai_flutter_project/user/auth/auth.dart';
import 'package:study_language_ai_flutter_project/user/view/account_detail_screen.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
            path: 'selfmake',
            builder: (context, state) => TextInputScreen(),
            routes: [
              GoRoute(
                path: 'selfcard/:directory',
                builder: (context, state) => SelfCardRenderingScreen(
                  directory: state.pathParameters['directory']!,
                ),
                redirect: (context, GoRouterState state) {
                  if (state.pathParameters.isEmpty) return '/';
                  return null;
                },
              ),
            ]),
        GoRoute(
          path: 'upload',
          builder: (context, state) => UploadSelectionScreen(),
        ),
        GoRoute(
          path: 'hot',
          builder: (context, state) => HotScreen(),
        ),
        GoRoute(
          path: 'account_detail',
          builder: (context, state) => AccountDetailScreen(),
          redirect: (context, GoRouterState state) {
            if (Auth().currentUser == null) return '/';
            return null;
          },
        ),
        GoRoute(
          path: 'sound_selection',
          builder: (context, state) => UserSoundSelectPage(),
          redirect: (context, GoRouterState state) {
            if (Auth().currentUser == null) return '/';
            return null;
          },
        ),
      ],
    ),
  ],
);
