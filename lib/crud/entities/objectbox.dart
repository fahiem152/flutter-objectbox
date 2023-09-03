// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crud_flutter_objectbox/objectbox.g.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  final Store store;
  ObjectBox._create(
    this.store,
  );

  static Future<ObjectBox> create() async {
    var dir = await getApplicationDocumentsDirectory();
    Store store =
        await openStore(directory: p.join(dir.path, 'objectbox_crud'));

    return ObjectBox._create(store);
  }
}
