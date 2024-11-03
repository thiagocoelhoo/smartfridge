import 'dart:io';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleDriveController {
  final _scopes = [drive.DriveApi.driveFileScope];
  final _clientId = ClientId(
    '921375603300-6ck7hqvnp9efo40q5kgceh4uvuc9n7s6.apps.googleusercontent.com',
    null,
  );

  Future<void> uploadDatabaseToDrive() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not authenticated');
      return;
    }

    final authHeaders = await user.getIdToken();
    final authClient = authenticatedClient(
      http.Client(),
      AccessCredentials(
        AccessToken('Bearer', authHeaders!,
            DateTime.now().toUtc().add(Duration(hours: 1))),
        null,
        _scopes,
      ),
    );

    final driveApi = drive.DriveApi(authClient);

    final directory = await getApplicationDocumentsDirectory();
    final dbFile = File('${directory.path}/your_database.db');

    if (!await dbFile.exists()) {
      print('Database file not found at ${dbFile.path}');
      return;
    }

    final media = drive.Media(dbFile.openRead(), dbFile.lengthSync());
    final driveFile = drive.File()..name = 'your_database.db';

    await driveApi.files.create(driveFile, uploadMedia: media);
    print('Database uploaded to Google Drive');
  }
}
