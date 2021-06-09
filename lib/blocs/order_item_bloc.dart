import 'package:rxdart/rxdart.dart';
import 'package:webox/models/order_item_model.dart';
import 'package:webox/repositories/order_item_repository.dart';
import 'package:webox/services/network_provider.dart';

class OrderItemBloc {
  final _fetcher = PublishSubject<List<OrderItemModel>>();
  double _totalPrice;

  Stream<List<OrderItemModel>> get orderItems => _fetcher.stream;
  double get totalPrice => _totalPrice;

  Future fetchOrderItems() async {
    var orderItems = await OrderItemRepository.getAll();
    List<OrderItemModel> event = [];
    for (var item in orderItems) {
      var laptop = await NetworkProvider.laptopService.getLaptop(item.laptopId);
      if (laptop.isAvailable) {
        event.add(item);
      } else {
        await OrderItemRepository.delete(item.laptopId);
      }
    }
    _totalPrice = 0;
    for (var item in event) {
      var laptop = await NetworkProvider.laptopService.getLaptop(item.laptopId);
      _totalPrice += item.amount * laptop.price;
    }
    _fetcher.sink.add(event);
  }

  Future removeOrderItem(String laptopId) async {
    await OrderItemRepository.delete(laptopId);
    var event = await OrderItemRepository.getAll();
    _totalPrice = 0;
    for (var item in event) {
      var laptop = await NetworkProvider.laptopService.getLaptop(item.laptopId);
      _totalPrice += item.amount * laptop.price;
    }
    _fetcher.sink.add(event);
  }

  void dispose() {
    _fetcher.close();
  }
}

final orderItemBloc = OrderItemBloc();
