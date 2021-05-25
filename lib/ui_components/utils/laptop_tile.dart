import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/config/screen_args/laptop_info_arguments.dart';
import 'package:webox/models/laptop_model.dart';

class LaptopTile extends StatelessWidget {
  final LaptopWithIdModel model;
  final bool isEmployee;
  final int pageIndex;
  final String sortOrder;
  final LaptopQueryParams laptopQueryParams;

  LaptopTile(this.model, this.isEmployee, this.pageIndex, this.sortOrder,
      this.laptopQueryParams);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/laptops/info',
          arguments: LaptopInfoArguments(
            model.id,
            isEmployee,
            pageIndex,
            sortOrder,
            laptopQueryParams,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200],
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            model.isAvailable
                ? Image.network(
                    model.modelImagePath,
                    height: 100.0,
                  )
                : Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          model.modelImagePath,
                        ),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.3),
                          BlendMode.dstATop,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Немає в наявності',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 7,
            ),
            SizedBox(
              height: 40.0,
              child: Text(
                model.modelName,
                style: TextStyle(
                  fontSize: 16.33,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            RatingBarIndicator(
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              rating: model.rating,
              itemSize: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.price.toInt().toString() + ' \u{20b4}',
                  style: TextStyle(
                    color: model.isAvailable ? Colors.blue : Colors.blueGrey,
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    size: 30.0,
                    color: model.isAvailable ? Colors.green : Colors.grey,
                  ),
                  onPressed: model.isAvailable
                      ? () {
                          //TODO: implement add to cart
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
