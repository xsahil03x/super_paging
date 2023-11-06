import 'package:cancellation_token/cancellation_token.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final token = CancellationToken();

  Future<T> withCancellationScope<T>(
    Future<T> Function() callback, {
    required CancellationToken token,
    void Function(Object, StackTrace)? onError,
  }) async {
    // Store the current state to revert to if the callback throws an exception.
    // final currentState = value;

    try {
      return await CancellableFuture.from(callback, token);
    } on CancelledException catch (_) {
      // If the callback threw an exception, revert to the previous state.
      // value = currentState;

      print('Cancelled Clause');

      // Don't rethrow the exception, since we've already reverted to the
      // previous state.

      return Future.value();
    } catch (e, stk) {
      // If the callback threw an exception, revert to the previous state.
      // value = currentState;

      print('Catch Clause');

      // Don't rethrow the exception, since we've already reverted to the
      // previous state.
      return Future.value();
    }
  }

  Future<String> testString() {
    return Future.delayed(const Duration(seconds: 1), () {
      token.cancelWithReason('cancellationReason');
      return 'test';
    });
  }

  test('description', () async {

    const int maxValue = (1 << 63) - 1;

    print(maxValue);

    // Future<String> getData() async {
    //   await Future.delayed(const Duration(seconds: 3));
    //   return 'Data';
    // }
    //
    // Future.delayed(const Duration(seconds: 1), () {
    //   token.cancel();
    // });
    //
    // final data = await withCancellationScope(
    //   getData,
    //   token: token,
    // );
    //
    // print(data);
  });

  test('adds one to input values', () async {
    final a = A();

    a.addListener(() {
      print('a changed: ${a.value}');
    });

    a.updateValue(12);
    a.updateValue(13);
    a.updateValue(14);

    a.reset();

    a.updateValue(15);
    a.updateValue(16);
    a.updateValue(17);

    a.reset();

    a.updateValue(18);
    a.updateValue(19);
    a.updateValue(20);
  });
}

typedef BFactory = B Function();

class A implements ValueListenable<int> {
  A([int initialValue = 1])
      : _notifier = ValueNotifier(initialValue),
        _bFactory = (() => B(initialValue++)) {
    _b.addListener(onValueChanged);
  }

  final ValueNotifier<int> _notifier;

  final BFactory _bFactory;

  late B _b = _bFactory();

  void updateValue(int value) {
    _b.updateValue(value);
  }

  void onValueChanged() {
    _notifier.value = _b.value;
  }

  @override
  int get value => _notifier.value;

  @override
  void addListener(VoidCallback listener) => _notifier.addListener(listener);

  @override
  void removeListener(VoidCallback listener) {
    _notifier.removeListener(listener);
  }

  void reset() {
    final current = _b;
    current.removeListener(onValueChanged);
    current.dispose();

    _b = _bFactory();
    _b.addListener(onValueChanged);
  }
}

class B extends ValueNotifier<int> {
  B(this._initialValue) : super(_initialValue);

  final int _initialValue;

  void updateValue(int value) {
    super.value = value;
  }

  @override
  void dispose() {
    print('$this : Initial: $_initialValue disposed');
    super.dispose();
  }
}
