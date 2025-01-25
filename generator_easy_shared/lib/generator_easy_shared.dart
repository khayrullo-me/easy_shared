import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/easy_shared_generator.dart';

Builder easySharedBuilder(BuilderOptions options) =>
    SharedPartBuilder([EasySharedGenerator()], "Easy");
