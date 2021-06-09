import 'package:flutter/material.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/storage_lot_info_model.dart';
import 'package:webox/services/network_provider.dart';
import 'package:webox/ui_components/utils/utility.dart';

class LaptopStorageLot extends StatelessWidget {
  final StorageLotInfoModel model;
  final bool isCovered;
  final Map<String, dynamic> laptopPageParams;
  const LaptopStorageLot(this.model, this.isCovered, this.laptopPageParams,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/storage-lots/info', arguments: {
          'id': model.id,
          'laptopId': model.laptopId,
          'laptopPageArgs': laptopPageParams,
        });
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              isCovered
                  ? Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Ідентифікатор комірки:',
                            style: TextStyle(
                              fontSize: 16.33,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            model.id,
                            style: TextStyle(
                              fontSize: 16.33,
                            ),
                          ),
                        ),
                      ],
                    )
                  : FutureBuilder(
                      future: NetworkProvider.laptopService
                          .getLaptop(model.laptopId),
                      builder:
                          (context, AsyncSnapshot<LaptopWithIdModel> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Text(
                            'Виникла помилка при завантаженні моделі ноутбука',
                            style: TextStyle(
                              fontSize: 16.33,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          var laptopModel = snapshot.data;
                          return Row(
                            children: [
                              Image.network(
                                laptopModel.modelImagePath,
                                height: 50.0,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: Text(
                                  laptopModel.modelName,
                                  style: TextStyle(
                                    fontSize: 16.33,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Дата поставки:',
                      style: TextStyle(
                        fontSize: 16.33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      Utility.getFormattedDateString(model.supplyDateTime) ==
                              '1 січня 1'
                          ? 'Не визначено'
                          : Utility.getFormattedDateString(
                              model.supplyDateTime),
                      style: TextStyle(
                        fontSize: 16.33,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Кількість одиниць:',
                      style: TextStyle(
                        fontSize: 16.33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      model.laptopsAmount.toString(),
                      style: TextStyle(
                        fontSize: 16.33,
                      ),
                    ),
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
