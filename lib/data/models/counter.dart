import 'package:scoped_model/scoped_model.dart';

// Start by creating a class that holds some view the app's state. In
// our example, we'll have a simple counter that starts at 0 can be
// incremented.
//
// Note: It must extend from Model.
class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    // First, increment the counter
    _counter++;

    // Then notify all the listeners.
    notifyListeners();
  }

  void decrement() {
    // First, increment the counter
    _counter--;

    // Then notify all the listeners.
    notifyListeners();
  }
}