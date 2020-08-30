import 'package:flutter/cupertino.dart';
import 'package:tutorial_flutter_bloc_restaurant_finder/bloc/bloc.dart';

class BloCProvider<T extends BloC> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BloCProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  static T of<T extends BloC>(BuildContext context) {
    final type = _providerType<BloCProvider<T>>();
    final BloCProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _providerType<T>() => T;

  @override
  State<StatefulWidget> createState() => _BloCProviderState();
}

class _BloCProviderState extends State<BloCProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
