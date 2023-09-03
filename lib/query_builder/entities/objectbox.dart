// ignore: depend_on_referenced_packages

import 'package:crud_flutter_objectbox/objectbox.g.dart';
import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class MotorCycleObjectBox {
  final Store objetBoxStore;

  MotorCycleObjectBox._create(this.objetBoxStore);

  static Future<MotorCycleObjectBox> createMotorCycle() async {
    var dir = await getApplicationDocumentsDirectory();
    Store objetBoxStore =
        await openStore(directory: p.join(dir.path, 'objectbox_quey_builder'));

    return MotorCycleObjectBox._create(objetBoxStore);
  }
}
