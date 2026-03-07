import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  @JsonSerializable(includeIfNull: false)
  factory Account({
    required String platform,
    required String domain,
    required String token,
    required String login,
    required String avatarUrl,
    int? gitlabId, // For GitLab
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
