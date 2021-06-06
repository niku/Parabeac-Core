import 'package:parabeac_core/generation/generators/pb_generator.dart';
import 'package:parabeac_core/generation/generators/value_objects/template_strategy/stateless_template_strategy.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_master_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_context.dart';
import 'package:quick_log/quick_log.dart';

class PBMasterSymbolGenerator extends PBGenerator {
  PBMasterSymbolGenerator() : super(strategy: StatelessTemplateStrategy());

  var log = Logger('Symbol Master Generator');
  @override
  String generate(PBIntermediateNode source, PBContext generatorContext) {
    generatorContext.sizingContext = SizingValueContext.LayoutBuilderValue;
    var buffer = StringBuffer();
    if (source is PBSharedMasterNode) {
      if (source.child == null) {
        return '';
      }
      // override styles if need be.
      generatorContext.masterNode = source;

      source.child.currentContext = source.currentContext;
      // see if widget itself is overridden, need to pass
      var generatedWidget =
          source.child.generator.generate(source.child, generatorContext);

      generatorContext.masterNode = null;
      if (generatedWidget == null || generatedWidget.isEmpty) {
        return '';
      }
      buffer.write(generatedWidget);
      return buffer.toString();
    } else {
      return '';
    }
  }
}
