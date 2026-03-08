class Account {
  final String platform;
  final String domain;
  final String token;
  final String login;
  final String avatarUrl;
  final int? gitlabId;

  Account({
    required this.platform,
    required this.domain,
    required this.token,
    required this.login,
    required this.avatarUrl,
    this.gitlabId,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        platform: json['platform'] as String,
        domain: json['domain'] as String,
        token: json['token'] as String,
        login: json['login'] as String,
        avatarUrl: json['avatarUrl'] as String,
        gitlabId: json['gitlabId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'platform': platform,
        'domain': domain,
        'token': token,
        'login': login,
        'avatarUrl': avatarUrl,
        if (gitlabId != null) 'gitlabId': gitlabId,
      };
}
