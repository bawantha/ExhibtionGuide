import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exhibition_guide/models/exhibiton_model.dart';
import 'package:exhibition_guide/models/message.dart';

abstract class DbService {
  createExhibition(String name);

  getExhibtions(String userID);

  adMac(String mac);

  deleteMac(String mac);

  createMessage(String mac, Message message);

  visitorVisited(String mac);

  visitorLeaved(String mac);

  getMessages(String mac) {}
}

class EGDbService implements DbService {
  final CollectionReference exhibitionCollection =
  Firestore.instance.collection('exhibitions');

  final CollectionReference macCollection =
  Firestore.instance.collection('macs');

  @override
  Future<bool> createExhibition(String name) async {
    try {
      exhibitionCollection.add({"name": name, "uid": "user"}).then(
            (value) =>
            exhibitionCollection
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

  @override
  Future<bool> adMac(String mac) async {
    try {
      await macCollection.document(mac).setData({mac: mac});
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteMac(String mac) async {
    try {
      await macCollection.document(mac).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  createMessage(String mac, Message message) async {
    try {
//      print(mac);
      await macCollection
          .document(mac)
          .collection("message")
          .document()
          .setData(message.toMap());
//      print("done");
    } catch (e) {}
  }

  @override
  visitorLeaved(String mac) async {
    try {
      await macCollection
          .document(mac)
          .updateData({"data": FieldValue.increment(-1)});
    } catch (e) {}
  }

  @override
  visitorVisited(String mac) async {
    try {
      await macCollection
          .document(mac)
          .updateData({"data": FieldValue.increment(1)});
    } catch (e) {}
  }

  @override
  Stream<List<Message>> getMessages(String mac) {
    try {
      return macCollection
          .document(mac)
          .collection("message")
          .orderBy("time", descending: false)
          .snapshots()
          .map((event) {
        return event.documents.map((e) => Message.fromMap(e.data)).toList();
      });
    } catch (e) {}
  }
}
