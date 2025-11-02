import 'package:flutter/foundation.dart'; // ← debugPrint を使うために追加

// Memoエンティティクラス
class MemoModel {
  final String title;
  final String username;
  final String summary;
  final String content;

  MemoModel({
    required this.title,
    required this.username,
    required this.summary,
    required this.content,
  });

  factory MemoModel.fromJson(Map<String, dynamic> json) {
    try {
      // null安全に各フィールドを取得
      final title = json['title']?.toString() ?? '';
      final username = json['username']?.toString() ?? '';
      final summary = json['summary']?.toString() ?? '';
      final content = json['content']?.toString() ?? '';

      // Nullのエラー処理
      final List<String> missing = [];
      if (json['title'] == null) missing.add('title');
      if (json['username'] == null) missing.add('username');
      if (json['summary'] == null) missing.add('summary');
      if (json['content'] == null) missing.add('content');

      if (missing.isNotEmpty) {
        debugPrint(
          'MemoModel.fromJson: missing/null fields: ${missing.join(', ')}',
        );
        debugPrint('  json: $json');
      }

      return MemoModel(
        title: title,
        username: username,
        summary: summary,
        content: content,
      );
    } catch (e, st) {
      debugPrint('MemoModel.fromJson failed: $e');
      debugPrint('json: $json');
      debugPrint('$st');
      rethrow; // 呼び出し元で詳細を扱えるよう再送出
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'username': username,
      'summary': summary,
      'content': content,
    };
  }
}
