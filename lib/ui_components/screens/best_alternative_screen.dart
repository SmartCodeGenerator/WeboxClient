import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/preference_bloc.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/order_item_model.dart';
import 'package:webox/repositories/order_item_repository.dart';

class BestAlternativeScreen extends StatelessWidget {
  const BestAlternativeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var laptopModel = args['model'] as LaptopWithIdModel;
    int pageIndex = args['pageIndex'] as int;
    String sortOrder = args['sortOrder'] as String;
    LaptopQueryParams laptopQueryParams = args['params'] as LaptopQueryParams;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Webox',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Найкраща модель ноутбуку серед порівнюваних за заданими критеріями оцінювання',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Image.network(
                    laptopModel.modelImagePath,
                    height: 100.0,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    laptopModel.modelName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  FutureBuilder(
                    future: OrderItemRepository.isInCart(laptopModel.id),
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error.toString());
                        return ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.add_shopping_cart),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        var isInCart = snapshot.data;
                        return ElevatedButton(
                          onPressed: () async {
                            if (laptopModel.isAvailable) {
                              if (!isInCart) {
                                await OrderItemRepository.insert(
                                    OrderItemModel(1, laptopModel.id));
                                preferenceBloc.fetchPreferences();
                                laptopBloc.refreshCatalog(
                                    pageIndex, sortOrder, laptopQueryParams);
                              }
                              Navigator.pushNamed(
                                context,
                                '/shopping-cart',
                                arguments: {
                                  'pageIndex': pageIndex,
                                  'sortOrder': sortOrder,
                                  'params': laptopQueryParams,
                                },
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Icon(isInCart
                                ? Icons.shopping_cart
                                : Icons.add_shopping_cart),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: laptopModel.isAvailable
                                ? Colors.green
                                : Colors.grey,
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.add_shopping_cart),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                      );
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/home');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Повернутися до каталогу',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
