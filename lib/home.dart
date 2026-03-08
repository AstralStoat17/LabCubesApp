import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/notification.dart';
import 'package:git_touch/screens/gl_explore.dart';
import 'package:git_touch/screens/gl_groups.dart';
import 'package:git_touch/screens/gl_search.dart';
import 'package:git_touch/screens/login.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:provider/provider.dart';

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
