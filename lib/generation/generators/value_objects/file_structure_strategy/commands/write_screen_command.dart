import 'package:parabeac_core/generation/generators/value_objects/file_structure_strategy/commands/node_file_structure_command.dart';
import 'package:parabeac_core/generation/generators/value_objects/file_structure_strategy/pb_file_structure_strategy.dart';

/// Command that writes a `screen` to the project.
class WriteScreenCommand extends NodeFileStructureCommand {
  String name;
  String relativePath;

  final SCREEN_PATH = 'lib/screens';

  WriteScreenCommand(this.name, this.relativePath, String code) : super(code);

  /// Writes a screen file containing [code] to [path] with [name] as its filename.
  ///
  /// Returns path to the file that was created.
  @override
  Future<String> write(FileStructureStrategy strategy) {
    var absPath =
        '${strategy.GENERATED_PROJECT_PATH}$SCREEN_PATH/$relativePath/$name';
    writeDataToFile(code, absPath);
    return Future.value(absPath);
  }
}