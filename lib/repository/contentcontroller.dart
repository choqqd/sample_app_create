import 'package:sample_app_create/repository/local_repository.dart';

class ContentController extends LocalRepository {
  final String MY_FAVOIRTE_STORE_KEY = "My_FAVOIRTE_STORE_KEY";

  Future<dynamic> loadContent() async {
    String? getlist = await this.getStoredValue(MY_FAVOIRTE_STORE_KEY);
    if (getlist != null) {
      return getlist;
    } else {
      return null;
    }
  }

  void insertinput(String items) async {
    print(items);
    await this.inserValue(MY_FAVOIRTE_STORE_KEY, items);
  }
}
