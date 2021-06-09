import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/preference_bloc.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/config/screen_args/laptop_info_arguments.dart';
import 'package:webox/models/order_item_model.dart';
import 'package:webox/models/preference_model.dart';
import 'package:webox/repositories/order_item_repository.dart';

class PreferenceTile extends StatelessWidget {
  final PreferenceModel model;
  final bool isEmployee;
  final int pageIndex;
  final String sortOrder;
  final LaptopQueryParams laptopQueryParams;

  const PreferenceTile(this.model, this.isEmployee, this.pageIndex,
      this.sortOrder, this.laptopQueryParams,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/laptops/info',
          arguments: LaptopInfoArguments(
            model.laptopModel.id,
            isEmployee,
            pageIndex,
            sortOrder,
            laptopQueryParams,
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      model.laptopModel.isAvailable
                          ? Image.network(
                              model.laptopModel.modelImagePath,
                              height: 50.0,
                            )
                          : Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    model.laptopModel.modelImagePath,
                                  ),
                                  fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.3),
                                    BlendMode.dstATop,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 75,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: 7.0,
                      ),
                      SizedBox(
                        width: 120.0,
                        child: Text(
                          model.laptopModel.modelName,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 36.0,
                    ),
                    onPressed: () async {
                      var statusCode =
                          await preferenceBloc.removePreference(model.id);
                      if (statusCode == 200) {
                        preferenceBloc.fetchPreferences();
                      } else if (statusCode == 401) {
                        Navigator.pushNamed(context, '/login');
                      } else {
                        var snackBar = SnackBar(
                          content: Text('Помилка при видаленні об\'єкта'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              RatingBarIndicator(
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                rating: model.laptopModel.rating,
                itemSize: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.laptopModel.price.toInt().toString() + ' \u{20b4}',
                    style: TextStyle(
                      color: model.laptopModel.isAvailable
                          ? Colors.blue
                          : Colors.blueGrey,
                      fontSize: 16.33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder(
                    future: OrderItemRepository.isInCart(model.laptopModel.id),
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
                            if (model.laptopModel.isAvailable) {
                              if (!isInCart) {
                                await OrderItemRepository.insert(
                                    OrderItemModel(1, model.laptopModel.id));
                                preferenceBloc.fetchPreferences();
                                laptopBloc.refreshCatalog(
                                    pageIndex, sortOrder, laptopQueryParams);
                              } else {
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
                            primary: model.laptopModel.isAvailable
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
            ],
          ),
        ),
      ),
    );
  }
}
