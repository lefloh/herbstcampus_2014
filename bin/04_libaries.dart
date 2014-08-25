library libraries;

import 'dart:math' as m show PI;
import '02_objects.dart';
import 'package:bootjack/bootjack.dart' hide Alert;

part '04_libraries_parts.dart';

const int FOO = 42;

main() {
  print(m.PI);
  Alert alert = new Alert(null);
  Button button = new Button(null);
}