import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'S_ca.dart';
import 'S_de.dart';
import 'S_en.dart';
import 'S_es.dart';
import 'S_fr.dart';
import 'S_hi.dart';
import 'S_hu.dart';
import 'S_id.dart';
import 'S_ja.dart';
import 'S_nb.dart';
import 'S_nl.dart';
import 'S_pt.dart';
import 'S_ru.dart';
import 'S_si.dart';
import 'S_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/S.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('hu'),
    Locale('id'),
    Locale('ja'),
    Locale('nb'),
    Locale('nl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('si'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
  ];

  /// The News tab
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// The Notification tab
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// Trending
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// The Search tab
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// The Me tab
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get me;

  /// The participating Tab
  ///
  /// In en, this message translates to:
  /// **'Participating'**
  String get participating;

  /// repository text
  ///
  /// In en, this message translates to:
  /// **'Repositories'**
  String get repositories;

  /// unfollow someone
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get unfollow;

  /// follow someone
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// stars on a repo
  ///
  /// In en, this message translates to:
  /// **'Stars'**
  String get stars;

  /// followers for a person
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// people followed by a person
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// events for a user
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// gists for a user
  ///
  /// In en, this message translates to:
  /// **'Gists'**
  String get gists;

  /// organizations for a user
  ///
  /// In en, this message translates to:
  /// **'Organizations'**
  String get organizations;

  /// members of an organization
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members;

  /// popular repositories
  ///
  /// In en, this message translates to:
  /// **'popular repositories'**
  String get popularRepositories;

  /// pinned repositories
  ///
  /// In en, this message translates to:
  /// **'pinned repositories'**
  String get pinnedRepositories;

  /// settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// system
  ///
  /// In en, this message translates to:
  /// **'system'**
  String get system;

  /// github status
  ///
  /// In en, this message translates to:
  /// **'GitHub status'**
  String get githubStatus;

  /// review Permissions
  ///
  /// In en, this message translates to:
  /// **'Review Permissions'**
  String get reviewPermissions;

  /// GitLab status
  ///
  /// In en, this message translates to:
  /// **'GitLab status'**
  String get gitlabStatus;

  /// Gitea status
  ///
  /// In en, this message translates to:
  /// **'Gitea status'**
  String get giteaStatus;

  /// Switch accounts
  ///
  /// In en, this message translates to:
  /// **'Switch accounts'**
  String get switchAccounts;

  /// brightness
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get brightness;

  /// follow systems setting
  ///
  /// In en, this message translates to:
  /// **'Follow System'**
  String get followSystem;

  /// light mode
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Kind of theme - cupertino or material
  ///
  /// In en, this message translates to:
  /// **'Scaffold Theme'**
  String get scaffoldTheme;

  /// Cupertino scaffold theme
  ///
  /// In en, this message translates to:
  /// **'Cupertino'**
  String get cupertino;

  /// Material scaffold theme
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// code theme
  ///
  /// In en, this message translates to:
  /// **'Code Theme'**
  String get codeTheme;

  /// flutter or webview rendering for markdown
  ///
  /// In en, this message translates to:
  /// **'Markdown Render Engine'**
  String get markdownRenderEngine;

  /// render flutter for markdown
  ///
  /// In en, this message translates to:
  /// **'Flutter'**
  String get flutter;

  /// render webview for markdown
  ///
  /// In en, this message translates to:
  /// **'WebView'**
  String get webview;

  /// provide feedback
  ///
  /// In en, this message translates to:
  /// **'feedback'**
  String get feedback;

  /// submit issue for app
  ///
  /// In en, this message translates to:
  /// **'Submit an issue'**
  String get submitAnIssue;

  /// rate the app
  ///
  /// In en, this message translates to:
  /// **'Rate This App'**
  String get rateThisApp;

  /// Email to report issues
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// about section
  ///
  /// In en, this message translates to:
  /// **'about'**
  String get about;

  /// app version
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// source code for app
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// Repository screen title
  ///
  /// In en, this message translates to:
  /// **'Repository'**
  String get repository;

  /// Repository Actions
  ///
  /// In en, this message translates to:
  /// **'Repository Actions'**
  String get repositoryActions;

  /// projects
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// releases
  ///
  /// In en, this message translates to:
  /// **'Releases'**
  String get releases;

  /// watchers
  ///
  /// In en, this message translates to:
  /// **'Watchers'**
  String get watchers;

  /// forks
  ///
  /// In en, this message translates to:
  /// **'Forks'**
  String get forks;

  /// issues
  ///
  /// In en, this message translates to:
  /// **'Issues'**
  String get issues;

  /// Pull Requests
  ///
  /// In en, this message translates to:
  /// **'Pull requests'**
  String get pullRequests;

  /// Commits
  ///
  /// In en, this message translates to:
  /// **'Commits'**
  String get commits;

  /// branches
  ///
  /// In en, this message translates to:
  /// **'Branches'**
  String get branches;

  /// contributors
  ///
  /// In en, this message translates to:
  /// **'Contributors'**
  String get contributors;

  /// unread
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// all
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// developers
  ///
  /// In en, this message translates to:
  /// **'Developers'**
  String get developers;

  /// explore
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// teams
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teams;

  /// file
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// file plural
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// actions
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// groups
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groups;

  /// Merge request
  ///
  /// In en, this message translates to:
  /// **'Merge Requests'**
  String get mergeRequests;

  /// activity
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// project
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// select account message
  ///
  /// In en, this message translates to:
  /// **'Select account'**
  String get selectAccount;

  /// remove account
  ///
  /// In en, this message translates to:
  /// **'Remove account'**
  String get removeAccount;

  /// error message
  ///
  /// In en, this message translates to:
  /// **'Something bad happens:'**
  String get somethingBadHappens;

  /// Gitea Account
  ///
  /// In en, this message translates to:
  /// **'GitHub Account'**
  String get githubAccount;

  /// Permission Required Message
  ///
  /// In en, this message translates to:
  /// **'GitTouch needs these permissions'**
  String get permissionRequiredMessage;

  /// Not found page header
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFoundMessage;

  /// Not found error message
  ///
  /// In en, this message translates to:
  /// **'Oops, this page is not implemented yet.'**
  String get notFoundTextDisplay;

  /// Gitlab Account
  ///
  /// In en, this message translates to:
  /// **'GitLab Account'**
  String get gitlabAccount;

  /// Bitbucket Account
  ///
  /// In en, this message translates to:
  /// **'Bitbucket Account'**
  String get bitbucketAccount;

  /// Long Press to remove account
  ///
  /// In en, this message translates to:
  /// **'Long Press to remove account'**
  String get longPressToRemoveAccount;

  /// Gitea Account
  ///
  /// In en, this message translates to:
  /// **'Gitea Account'**
  String get giteaAccount;

  /// Gitee Account
  ///
  /// In en, this message translates to:
  /// **'Gitee Account'**
  String get giteeAccount;

  /// user
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// group
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group;

  /// issue
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get issue;

  /// Code
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// Project Actions
  ///
  /// In en, this message translates to:
  /// **'Project Actions'**
  String get projectActions;

  /// Syntax Highlighting
  ///
  /// In en, this message translates to:
  /// **'SYNTAX HIGHLIGHTING'**
  String get syntaxHighlighting;

  /// Font Family
  ///
  /// In en, this message translates to:
  /// **'Font Family'**
  String get fontFamily;

  /// font size
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// font style
  ///
  /// In en, this message translates to:
  /// **'FONT STYLE'**
  String get fontStyle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ca',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'hu',
        'id',
        'ja',
        'nb',
        'nl',
        'pt',
        'ru',
        'si',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return AppLocalizationsCa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'hu':
      return AppLocalizationsHu();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'si':
      return AppLocalizationsSi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
