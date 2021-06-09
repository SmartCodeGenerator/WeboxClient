import 'package:rxdart/rxdart.dart';
import 'package:webox/models/order_info_model.dart';
import 'package:webox/models/order_model.dart';
import 'package:webox/services/network_provider.dart';

class OrderBloc {
  final _service = NetworkProvider.orderService;
  final _ordersFetcher = PublishSubject<List<OrderInfoModel>>();
  final _orderFetcher = PublishSubject<OrderInfoModel>();

  Stream<List<OrderInfoModel>> get orders => _ordersFetcher.stream;
  Stream<OrderInfoModel> get order => _orderFetcher.stream;

  Future fetchOrders() async {
    try {
      var event = await _service.getOrders();
      _ordersFetcher.sink.add(event);
    } catch (ex) {
      print(ex);
    }
  }

  Future fetchOrder(String id) async {
    try {
      var event = await _service.getOrder(id);
      _orderFetcher.sink.add(event);
    } catch (ex) {
      print(ex);
    }
  }

  Future<int> makeOrder(OrderModel model) async {
    return await _service.makeOrder(model);
  }

  Future<int> cancelOrder(String id) async {
    return await _service.cancelOrder(id);
  }

  void dispose() {
    _ordersFetcher.close();
    _orderFetcher.close();
  }
}

final orderBloc = OrderBloc();
