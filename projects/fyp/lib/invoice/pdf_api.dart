import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
  
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    // final Map<String, String> dir= {
    //   "path": "assets/images"};
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    try {
    final url = file.path;
    print("File Path: $url");
    await OpenFile.open(url);
  } catch (e) {
    print("Error opening file: $e");
  }
  }
}
