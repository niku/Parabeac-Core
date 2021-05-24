import 'package:parabeac_core/generation/generators/pb_generator.dart';
import 'package:parabeac_core/generation/prototyping/pb_prototype_node.dart';
import 'package:parabeac_core/generation/prototyping/pb_prototype_storage.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_context.dart';
import 'package:parabeac_core/interpret_and_optimize/services/pb_platform_orientation_linker_service.dart';
import 'package:recase/recase.dart';

class PBPrototypeGenerator extends PBGenerator {
  PrototypeNode prototypeNode;
  PBPrototypeStorage _storage;

  PBPrototypeGenerator(this.prototypeNode) : super() {
    _storage = PBPrototypeStorage();
  }

  @override
  String generate(PBIntermediateNode source, PBContext generatorContext) {
    var node = _storage.getPageNodeById(prototypeNode.destinationUUID);

    var nodeInfo = _determineNode(node);
    var name = nodeInfo[0];

    if (name != null && name.isNotEmpty) {
      return '''GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => $name()),
        );
      },
      child: ${source.child.generator.generate(source.child, generatorContext)},
      )''';
    } else {
      return source.child.generator.generate(source.child, generatorContext);
    }
  }

  List<String> _determineNode(PBIntermediateNode rootNode) {
    var rootName = rootNode.name;
    if (rootName.contains('_')) {
      rootName = rootName.split('_')[0].pascalCase;
    }
    var currentMap = PBPlatformOrientationLinkerService()
        .getPlatformOrientationData(rootName);
    var className = [rootName.pascalCase, ''];
    if (currentMap.length > 1) {
      className[0] += 'PlatformBuilder';
      className[1] =
          rootName.snakeCase + '/${rootName.snakeCase}_platform_builder.dart';
    }
    return className;
  }
}
