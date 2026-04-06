import 'package:share_plus/share_plus.dart';

class ShareNameService {
  final String name;

  ShareNameService(this.name);

  Future<bool> share(XFile file) async {
    final params = ShareParams(
      text: name,
      files: [file],
    );
    final result = await SharePlus.instance.share(params);
    if (result.status == ShareResultStatus.success) {
      return true;
    } else {
      return false;
    }
  }
}
