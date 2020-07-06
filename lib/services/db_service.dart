import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exhibition_guide/models/exhibiton_model.dart';

abstract class DbService {
  createExhibition(String name);

  getExhibtions(String userID);
}

class EGDbService implements DbService {
  final CollectionReference exhibitionCollection =
      Firestore.instance.collection('exhibitions');

  @override
  Future<bool> createExhibition(String name) async {
    try {
      exhibitionCollection.add({"name": name, "uid": "user"}).then(
        (value) => exhibitionCollection
            .document(value.documentID)
            .updateData({"id": value.documentID}),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<ExhibitionModel>> getExhibtions(String id) {
    try {
      return exhibitionCollection
          .where("uid", isEqualTo: id)
          .snapshots()
          .map((event) {
        return event.documents
            .map((e) => ExhibitionModel.fromJson(e.data))
            .toList();
      });
    } catch (e) {
      print(e.toString());
    }
  }
}