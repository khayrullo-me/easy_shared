import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  List<Fields> fields = [];

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType.replaceFirst("*", "");
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields.add(Fields(
        name: element.name,
        typeData: element.type.toString().replaceFirst("*", ""),
        init: element.computeConstantValue()?.toString()));
  }
}

class Fields {
  final String name;
  final String typeData;
  final String? init;

  Fields({required this.name, required this.typeData, required this.init});
}
