class GitlabUser {
  int? id;
  String? username;
  String? name;
  String? avatarUrl;
  String? bio;
  DateTime? createdAt;
  int? accessLevel;

  GitlabUser();

  factory GitlabUser.fromJson(Map<String, dynamic> json) => GitlabUser()
    ..id = json['id'] as int?
    ..username = json['username'] as String?
    ..name = json['name'] as String?
    ..avatarUrl = json['avatar_url'] as String?
    ..bio = json['bio'] as String?
    ..createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String)
    ..accessLevel = json['access_level'] as int?;
}

class GitlabGroup {
  int? id;
  String? path;
  String? name;
  String? avatarUrl;
  String? description;
  List<GitlabProject>? projects;

  GitlabGroup();

  factory GitlabGroup.fromJson(Map<String, dynamic> json) => GitlabGroup()
    ..id = json['id'] as int?
    ..path = json['path'] as String?
    ..name = json['name'] as String?
    ..avatarUrl = json['avatar_url'] as String?
    ..description = json['description'] as String?
    ..projects = (json['projects'] as List?)
        ?.map((e) => GitlabProject.fromJson(e as Map<String, dynamic>))
        .toList();
}

class GitlabTodoProject {
  String? pathWithNamespace;

  GitlabTodoProject();

  factory GitlabTodoProject.fromJson(Map<String, dynamic> json) =>
      GitlabTodoProject()..pathWithNamespace = json['path_with_namespace'] as String?;
}

class GitlabTodo {
  GitlabUser? author;
  GitlabTodoProject? project;
  String? actionName;
  String? targetType;
  GitlabTodoTarget? target;

  GitlabTodo();

  factory GitlabTodo.fromJson(Map<String, dynamic> json) => GitlabTodo()
    ..author = json['author'] == null
        ? null
        : GitlabUser.fromJson(json['author'] as Map<String, dynamic>)
    ..project = json['project'] == null
        ? null
        : GitlabTodoProject.fromJson(json['project'] as Map<String, dynamic>)
    ..actionName = json['action_name'] as String?
    ..targetType = json['target_type'] as String?
    ..target = json['target'] == null
        ? null
        : GitlabTodoTarget.fromJson(json['target'] as Map<String, dynamic>);
}

class GitlabTodoTarget {
  int? iid;
  int? projectId;
  String? title;
  GitlabUser? author;
  String? description;
  DateTime? createdAt;

  GitlabTodoTarget();

  factory GitlabTodoTarget.fromJson(Map<String, dynamic> json) => GitlabTodoTarget()
    ..iid = json['iid'] as int?
    ..projectId = json['project_id'] as int?
    ..title = json['title'] as String?
    ..author = json['author'] == null
        ? null
        : GitlabUser.fromJson(json['author'] as Map<String, dynamic>)
    ..description = json['description'] as String?
    ..createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String);
}

class GitlabIssueNote {
  GitlabUser? author;
  String? body;
  bool? system;
  DateTime? createdAt;

  GitlabIssueNote();

  factory GitlabIssueNote.fromJson(Map<String, dynamic> json) => GitlabIssueNote()
    ..author = json['author'] == null
        ? null
        : GitlabUser.fromJson(json['author'] as Map<String, dynamic>)
    ..body = json['body'] as String?
    ..system = json['system'] as bool?
    ..createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String);
}

class GitlabProject {
  int? id;
  String? name;
  String? avatarUrl;
  String? description;
  int? starCount;
  int? forksCount;
  String? visibility;
  String? readmeUrl;
  String? webUrl;
  GitlabProjectNamespace? namespace;
  GitlabUser? owner;
  bool? issuesEnabled;
  int? openIssuesCount;
  bool? mergeRequestsEnabled;
  GitlabProjectStatistics? statistics;
  DateTime? lastActivityAt;
  DateTime? createdAt;
  String? defaultBranch;

  GitlabProject();

  factory GitlabProject.fromJson(Map<String, dynamic> json) => GitlabProject()
    ..id = json['id'] as int?
    ..name = json['name'] as String?
    ..avatarUrl = json['avatar_url'] as String?
    ..description = json['description'] as String?
    ..starCount = json['star_count'] as int?
    ..forksCount = json['forks_count'] as int?
    ..visibility = json['visibility'] as String?
    ..readmeUrl = json['readme_url'] as String?
    ..webUrl = json['web_url'] as String?
    ..namespace = json['namespace'] == null
        ? null
        : GitlabProjectNamespace.fromJson(json['namespace'] as Map<String, dynamic>)
    ..owner = json['owner'] == null
        ? null
        : GitlabUser.fromJson(json['owner'] as Map<String, dynamic>)
    ..issuesEnabled = json['issues_enabled'] as bool?
    ..openIssuesCount = json['open_issues_count'] as int?
    ..mergeRequestsEnabled = json['merge_requests_enabled'] as bool?
    ..statistics = json['statistics'] == null
        ? null
        : GitlabProjectStatistics.fromJson(json['statistics'] as Map<String, dynamic>)
    ..lastActivityAt = json['last_activity_at'] == null
        ? null
        : DateTime.parse(json['last_activity_at'] as String)
    ..createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String)
    ..defaultBranch = json['default_branch'] as String?;
}

class GitlabProjectBadge {
  String? renderedImageUrl;

  GitlabProjectBadge();

  factory GitlabProjectBadge.fromJson(Map<String, dynamic> json) =>
      GitlabProjectBadge()..renderedImageUrl = json['rendered_image_url'] as String?;
}

class GitlabProjectStatistics {
  int? commitCount;
  int? repositorySize;

  GitlabProjectStatistics();

  factory GitlabProjectStatistics.fromJson(Map<String, dynamic> json) =>
      GitlabProjectStatistics()
        ..commitCount = json['commit_count'] as int?
        ..repositorySize = json['repository_size'] as int?;
}

class GitlabProjectNamespace {
  int? id;
  String? name;
  String? path;
  String? kind;

  GitlabProjectNamespace();

  factory GitlabProjectNamespace.fromJson(Map<String, dynamic> json) =>
      GitlabProjectNamespace()
        ..id = json['id'] as int?
        ..name = json['name'] as String?
        ..path = json['path'] as String?
        ..kind = json['kind'] as String?;
}

class GitlabTreeItem {
  String type;
  String path;
  String name;

  GitlabTreeItem({required this.type, required this.path, required this.name});

  factory GitlabTreeItem.fromJson(Map<String, dynamic> json) => GitlabTreeItem(
        type: json['type'] as String,
        path: json['path'] as String,
        name: json['name'] as String,
      );
}

class GitlabBlob {
  String? content;

  GitlabBlob();

  factory GitlabBlob.fromJson(Map<String, dynamic> json) =>
      GitlabBlob()..content = json['content'] as String?;
}

class GitlabEvent {
  GitlabUser? author;
  String? actionName;
  String? targetType;
  GitlabEventNote? note;

  GitlabEvent();

  factory GitlabEvent.fromJson(Map<String, dynamic> json) => GitlabEvent()
    ..author = json['author'] == null
        ? null
        : GitlabUser.fromJson(json['author'] as Map<String, dynamic>)
    ..actionName = json['action_name'] as String?
    ..targetType = json['target_type'] as String?
    ..note = json['note'] == null
        ? null
        : GitlabEventNote.fromJson(json['note'] as Map<String, dynamic>);
}

class GitlabEventNote {
  String? body;
  String? noteableType;
  int? noteableIid;

  GitlabEventNote();

  factory GitlabEventNote.fromJson(Map<String, dynamic> json) => GitlabEventNote()
    ..body = json['body'] as String?
    ..noteableType = json['noteable_type'] as String?
    ..noteableIid = json['noteable_iid'] as int?;
}

class GitlabCommit {
  String? id;
  String? shortId;
  String? title;
  DateTime? createdAt;
  String? authorName;
  String? message;

  GitlabCommit();

  factory GitlabCommit.fromJson(Map<String, dynamic> json) => GitlabCommit()
    ..id = json['id'] as String?
    ..shortId = json['short_id'] as String?
    ..title = json['title'] as String?
    ..createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String)
    ..authorName = json['author_name'] as String?
    ..message = json['message'] as String?;
}

class GitlabDiff {
  String? diff;
  String? newPath;
  String? oldPath;

  GitlabDiff();

  factory GitlabDiff.fromJson(Map<String, dynamic> json) => GitlabDiff()
    ..diff = json['diff'] as String?
    ..newPath = json['new_path'] as String?
    ..oldPath = json['old_path'] as String?;
}

class GitlabIssue {
  String? title;
  int? iid;
  int? projectId;
  GitlabUser? author;
  int? userNotesCount;
  DateTime? updatedAt;
  List<String>? labels;

  GitlabIssue();

  factory GitlabIssue.fromJson(Map<String, dynamic> json) => GitlabIssue()
    ..title = json['title'] as String?
    ..iid = json['iid'] as int?
    ..projectId = json['project_id'] as int?
    ..author = json['author'] == null
        ? null
        : GitlabUser.fromJson(json['author'] as Map<String, dynamic>)
    ..userNotesCount = json['user_notes_count'] as int?
    ..updatedAt = json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String)
    ..labels = (json['labels'] as List?)?.map((e) => e as String).toList();
}

class GitlabStarrer {
  DateTime? starredSince;
  GitlabUser? user;

  GitlabStarrer();

  factory GitlabStarrer.fromJson(Map<String, dynamic> json) => GitlabStarrer()
    ..starredSince = json['starred_since'] == null
        ? null
        : DateTime.parse(json['starred_since'] as String)
    ..user = json['user'] == null
        ? null
        : GitlabUser.fromJson(json['user'] as Map<String, dynamic>);
}

class GitlabBranch {
  String? name;
  bool? merged;

  GitlabBranch();

  factory GitlabBranch.fromJson(Map<String, dynamic> json) => GitlabBranch()
    ..name = json['name'] as String?
    ..merged = json['merged'] as bool?;
}
