import 'package:git_touch/home.dart';
import 'package:git_touch/screens/code_theme.dart';
import 'package:git_touch/screens/gl_blob.dart';
import 'package:git_touch/screens/gl_commit.dart';
import 'package:git_touch/screens/gl_commits.dart';
import 'package:git_touch/screens/gl_group.dart';
import 'package:git_touch/screens/gl_issue.dart';
import 'package:git_touch/screens/gl_issue_form.dart';
import 'package:git_touch/screens/gl_issues.dart';
import 'package:git_touch/screens/gl_members.dart';
import 'package:git_touch/screens/gl_merge_requests.dart';
import 'package:git_touch/screens/gl_project.dart';
import 'package:git_touch/screens/gl_starrers.dart';
import 'package:git_touch/screens/gl_tree.dart';
import 'package:git_touch/screens/gl_user.dart';
import 'package:git_touch/screens/login.dart';
import 'package:git_touch/screens/settings.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Home(),
      routes: [
        // common
        GoRoute(
          path: 'choose-code-theme',
          builder: (context, state) => CodeThemeScreen(),
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => SettingsScreen(),
        ),
        // gitlab
        GoRoute(
          path: 'gitlab',
          builder: (context, state) => Home(),
          routes: [
            GoRoute(
              path: 'user/:id',
              builder: (context, state) =>
                  GlUserScreen(int.parse(state.params['id']!)),
            ),
            GoRoute(
              path: 'group/:id',
              builder: (context, state) =>
                  GlGroupScreen(int.parse(state.params['id']!)),
            ),
            GoRoute(
              path: 'groups/:id/members',
              builder: (context, state) =>
                  GlMembersScreen(int.parse(state.params['id']!), 'groups'),
            ),
            GoRoute(
              path: 'projects/:id',
              builder: (context, state) => GlProjectScreen(
                int.parse(state.params['id']!),
                branch: state.queryParams['branch'],
              ),
              routes: [
                GoRoute(
                  path: 'starrers',
                  builder: (context, state) =>
                      GlStarrersScreen(int.parse(state.params['id']!)),
                ),
                GoRoute(
                  path: 'commits',
                  builder: (context, state) => GlCommitsScreen(
                    state.params['id']!,
                    prefix: state.queryParams['prefix'],
                    branch: state.queryParams['branch'],
                  ),
                ),
                GoRoute(
                  path: 'commit/:sha',
                  builder: (context, state) => GlCommitScreen(
                    state.params['id']!,
                    sha: state.params['sha']!,
                  ),
                ),
                GoRoute(
                  path: 'members',
                  builder: (context, state) => GlMembersScreen(
                      int.parse(state.params['id']!), 'projects'),
                ),
                GoRoute(
                  path: 'blob/:ref',
                  builder: (context, state) => GlBlobScreen(
                    int.parse(state.params['id']!),
                    state.params['ref']!,
                    path: state.queryParams['path'],
                  ),
                ),
                GoRoute(
                  path: 'tree/:ref',
                  builder: (context, state) => GlTreeScreen(
                    int.parse(state.params['id']!),
                    state.params['ref']!,
                    path: state.queryParams['path'],
                  ),
                ),
                GoRoute(
                  path: 'issues',
                  builder: (context, state) => GlIssuesScreen(
                    state.params['id']!,
                    prefix: state.queryParams['prefix'],
                  ),
                  routes: [
                    GoRoute(
                      path: 'new',
                      builder: (context, state) => GlIssueFormScreen(
                        int.parse(state.params['id']!),
                      ),
                    ),
                    GoRoute(
                      path: ':iid',
                      builder: (context, state) => GlIssueScreen(
                        int.parse(state.params['id']!),
                        int.parse(state.params['iid']!),
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'merge_requests',
                  builder: (context, state) => GlMergeRequestsScreen(
                    state.params['id']!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
