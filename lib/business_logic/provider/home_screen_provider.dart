import 'package:plant_app/exports/exports.dart';

class HomeScreenProvider extends ChangeNotifier {
  String plantsCategory = 'Recommended';

  bool loading = false;

  bool isRecordingVoice = false;

  SpeechToText speechToText = SpeechToText();

  TextEditingController searchController = TextEditingController();

  List<String> plantsCategoryList = [
    'Recommended',
    'Indoor',
    'Outdoor',
    'Garden',
    'Supplement',
  ];

  addOrRemovePlantFromFavorite(collection, snapshot, index) async {
    var data = snapshot.data!.docs[index];

    List favoriteList = snapshot.data!.docs[index]['is_favorite'];

    if (favoriteList.contains(FirebaseAuth.instance.currentUser!.uid)) {
      favoriteList.remove(FirebaseAuth.instance.currentUser!.uid);

      await FirebaseFirestore.instance
          .collection(collection)
          .doc(data['doc_id'])
          .update(
        {
          'is_favorite': favoriteList,
        },
      );
    } else {
      favoriteList.add(FirebaseAuth.instance.currentUser!.uid);

      await FirebaseFirestore.instance
          .collection(collection)
          .doc(data['doc_id'])
          .update(
        {
          'is_favorite': favoriteList,
        },
      );
    }

    if (data['is_favorite'].contains(FirebaseAuth.instance.currentUser!.uid)) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorite')
          .doc(data['doc_id'])
          .delete();
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorite')
          .doc(data['doc_id'])
          .set(
        {
          'collection': collection,
          'doc_id': data['doc_id'],
          'size': data['size'],
          'image': data['image'],
          'description': data['description'],
          'name': data['name'],
          'category': data['category'],
          'temperature': data['temperature'],
          'price': data['price'],
          'rating': data['rating'],
          'humidity': data['humidity'],
          'is_favorite': data['is_favorite'],
          'is_added_to_cart': data['is_added_to_cart'],
        },
      );
    }
  }

  addOrRemovePlantFromCart(collection, snapshot) async {
    var data = snapshot.data!.docs[0];

    List cartList = snapshot.data!.docs[0]['is_added_to_cart'];

    if (cartList.contains(FirebaseAuth.instance.currentUser!.uid)) {
      cartList.remove(FirebaseAuth.instance.currentUser!.uid);

      await FirebaseFirestore.instance
          .collection(collection)
          .doc(data['doc_id'])
          .update(
        {
          'is_added_to_cart': cartList,
        },
      );
    } else {
      cartList.add(FirebaseAuth.instance.currentUser!.uid);

      await FirebaseFirestore.instance
          .collection(collection)
          .doc(data['doc_id'])
          .update(
        {
          'is_added_to_cart': cartList,
        },
      );
    }

    if (data['is_added_to_cart']
        .contains(FirebaseAuth.instance.currentUser!.uid)) {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(data['doc_id'])
          .delete();
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(data['doc_id'])
          .set(
        {
          'collection': collection,
          'doc_id': data['doc_id'],
          'size': data['size'],
          'image': data['image'],
          'description': data['description'],
          'name': data['name'],
          'category': data['category'],
          'temperature': data['temperature'],
          'price': data['price'],
          'rating': data['rating'],
          'humidity': data['humidity'],
          'is_favorite': data['is_favorite'],
          'is_added_to_cart': data['is_added_to_cart'],
        },
      );
    }
  }
}
