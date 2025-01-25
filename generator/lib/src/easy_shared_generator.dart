import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:annotations_easy_shared/src/xshared_generator.dart';

import 'model_visitor.dart';

class EasySharedGenerator extends GeneratorForAnnotation<EasySharedAnnotation> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final buffer = StringBuffer();
    final className = "${visitor.className}Gen";
    buffer.write("\n");
    buffer.write("\n");
    buffer.write("\n");
    buffer.write("class $className{\n");
    buffer
        .write("static final $className _instance = $className._internal();\n");
    buffer.write("$className._internal();\n");
    buffer.write("static $className get instance => _instance;\n");
    buffer.write("SharedPreferences? _prefs;\n");
    buffer.write("Future<void> init() async {\n");
    buffer.write("_prefs = await SharedPreferences.getInstance();\n");
    buffer.write("}\n");

    for (int i = 0; i < visitor.fields.length; i++) {
      final val = visitor.fields.elementAt(i).typeData;
      final key = visitor.fields.elementAt(i).name;
      final init = visitor.fields.elementAt(i).init;
      //getting
      if (val.toString() == "bool") {
        buffer.write("$val get $key => _prefs?.getBool('$key') ?? false;\n");
      } else if (val.toString() == "int") {
        buffer.write("$val get $key => _prefs?.getInt('$key') ?? 0;\n");
      } else if (val.toString() == "String") {
        buffer.write("$val get $key => _prefs?.getString('$key') ?? '';\n");
      } else if (val.toString().contains("List")) {
        buffer.write(
            "$val<String> get $key => _prefs?.getStringList('$key') ?? [];\n");
      } else if (val.toString() == "double") {
        buffer.write("$val get $key => _prefs?.getDouble('$key') ?? [];\n");
      } else {
        buffer.write("Object? get $key => _prefs?.get('$key');\n");
      }
      //setting
      if (val.toString() == "bool") {
        buffer.write("set $key($val value){_prefs?.setBool('$key',value);\n}");
      } else if (val.toString() == "int") {
        buffer.write("set $key($val value){_prefs?.setInt('$key',value);}");
      } else if (val.toString() == "String") {
        buffer
            .write("set $key($val value){_prefs?.setString('$key',value);\n}");
      } else if (val.toString().contains("List")) {
        buffer.write(
            "set $key($val value){_prefs?.setStringList('$key',value);\n}");
      } else if (val.toString() == "double") {
        buffer.write(
            "set $key($val value){\n_prefs?.setDouble('$key',value);\n}");
      }
    }
    buffer.write("\n}");
    print("");
    print("");
    print("${buffer.toString()}");
    print("");
    print("");
    return buffer.toString();
  }
}
