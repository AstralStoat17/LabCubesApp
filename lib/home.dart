import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/notification.dart';
import 'package:git_touch/models/theme.dart';
import 'package:git_touch/screens/gl_explore.dart';
import 'package:git_touch/screens/gl_groups.dart';
import 'package:git_touch/screens/gl_search.dart';
import 'package:git_touch/screens/gl_user.dart';
import 'package:git_touch/screens/login.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:universal_io/io.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Created 5 different variables instead of a list as list doesn't work
  final GlobalKey<NavigatorState> tab1 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tab2 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tab3 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tab4 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> tab5 = GlobalKey<NavigatorState>();

  @override
  initState() {
    super.initState();
  }

  _buildScreen(int index) {
    // return GlProjectScreen(32221);  
    // return Image.asset('images/spinner.webp', width: 32, height: 32);
    
    final auth = Provider.of<AuthModel>(context);
    switch (auth.activeAccount!.platform) {
      case PlatformType.gitlab:
        switch (index) {
          case 0:
            return GlExploreScreen();
          case 1:
            return GlGroupsScreenn();
          case 2:
            return GlSearchScreen();
          case 3:
            return const GlUserScreen(null);
        }
        break;
    }
  }

  Widget _buildNotificationIcon(BuildContext context, IconData iconData) {
    final count = Provider.of<NotificationModel>(context).count;
    if (count == 0) {
      return Icon(iconData);
    }

    // String text = count > 99 ? '99+' : count.toString();
    return Stack(
      children: <Widget>[
        Icon(iconData),
        Positioned(
          right: -2,
          top: -2,
          child: Icon(Octicons.dot_fill,
              color: AntTheme.of(context).colorPrimary, size: 14),
        )
      ],
    );
  }

  GlobalKey<NavigatorState> getNavigatorKey(int index) {
    switch (index) {
      case 0:
        return tab1;
      case 1:
        return tab2;
      case 2:
        return tab3;
      case 3:
        return tab4;
      case 4:
        return tab5;
    }
    return tab1;
  }

  List<BottomNavigationBarItem> _buildNavigationItems(String platform) {
    final search = BottomNavigationBarItem(
      icon: const Icon(Ionicons.search_outline),
      activeIcon: const Icon(Ionicons.search),
      label: 'Search',
    );
    final group = BottomNavigationBarItem(
      icon: const Icon(Ionicons.people_outline),
      activeIcon: const Icon(Ionicons.people),
      label: 'Organizations',
    );
    final me = BottomNavigationBarItem(
      icon: const Icon(Ionicons.person_outline),
      activeIcon: const Icon(Ionicons.person),
      label: 'Me',
    );
    final explore = BottomNavigationBarItem(
      icon: const Icon(Ionicons.compass_outline),
      activeIcon: const Icon(Ionicons.compass),
      label: 'Explore',
    );

    switch (platform) {
      case PlatformType.gitlab:
        return [explore, group, search, me];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context);

    if (auth.activeAccount == null) {
      return LoginScreen();
    }

    final navigationItems = _buildNavigationItems(auth.activeAccount!.platform);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        final NavigatorState? navigator = getNavigatorKey(auth.activeTab).currentState;
        if (navigator != null && await navigator.maybePop()) {
          return;
        }
      },
      child: CupertinoTabScaffold(
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: getNavigatorKey(index),
            builder: (context) {
              return _buildScreen(index);
            },
          );
        },
        tabBar: CupertinoTabBar(
          items: navigationItems,
          currentIndex: auth.activeTab,
          onTap: (index) {
            if (auth.activeTab == index) {
              getNavigatorKey(index).currentState?.popUntil((route) => route.isFirst);
            } else {
              auth.setActiveTab(index);
            }
          },
        ),
      ),
    );
  }
}
