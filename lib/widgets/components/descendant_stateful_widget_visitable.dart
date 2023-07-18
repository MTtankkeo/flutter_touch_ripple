import 'package:flutter/material.dart';





/// Provides the ability to reference and initialise the specified child [StatefulWidget],
/// The given generic [DescendantWidgetType] defines which [StatefulWidget] to initialise.
@protected
mixin DescendantStatefulWidgetVisitableMixin<WidgetType extends StatefulWidget, DescendantWidgetType extends StatefulWidget> on State<WidgetType> {
  (DescendantWidgetType, State<DescendantWidgetType>)? visitedDescendant;

  (DescendantWidgetType, State<DescendantWidgetType>)? _findByContext(BuildContext context) {
    (DescendantWidgetType, State<DescendantWidgetType>)? instance;

    void visit(Element element) {
      final widget = element.widget;

      if (widget is DescendantWidgetType) {
        instance = (
          widget,
          (element as StatefulElement).state as State<DescendantWidgetType>
        );
        return;
      }
      element.visitChildElements(visit);
    }
    context.visitChildElements(visit);
    
    return instance;
  }

  void afterInitialDescendantVisited(
    (DescendantWidgetType, State<DescendantWidgetType>)? visitedDescendant
  );

  @mustCallSuper
  void afterInitialBuilded(Duration _) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      visitedDescendant = _findByContext(context);

      afterInitialDescendantVisited(visitedDescendant);
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(afterInitialBuilded);
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      visitedDescendant = _findByContext(context);
    });
  }
}