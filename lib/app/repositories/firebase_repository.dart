import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseRepository {
  final storage = FirebaseStorage.instance;

  Future<void> deleteImageToFirebase(String path) async {
    final Reference fileRef = storage.ref(path);
    try {
      await fileRef.delete();
    } catch (e) {
      throw Exception('Erro ao excluir imagem $e');
    }
  }

  Future<List<String?>> uploadImageToFirebase(File? imageFile) async {
    List<String?> imageReference = []; // Inicialize a lista aqui

    try {
      final imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageReference =
          storage.ref().child('FotosUsuarios/$imageName.jpg');
      final UploadTask uploadTask = storageReference.putFile(imageFile!);
      await uploadTask.whenComplete(() => null);

      imageReference.add(await storageReference.getDownloadURL());
      imageReference.add(storageReference.fullPath);

      return imageReference;
    } catch (e) {
      throw Exception('Não foi possível cadastrar imagem no Firebase: $e');
    }
  }
}
