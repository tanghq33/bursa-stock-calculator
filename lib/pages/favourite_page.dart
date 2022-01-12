import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockcalculator/enums/favourite_target.dart';
import 'package:stockcalculator/helpers/snack_bar_helper.dart';

import '../entities/favourite.dart';
import '../helpers/controller_helper.dart';
import '../helpers/favourite_helper.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildListView(),
    );
  }

  Widget _buildListView() {
    return WatchBoxBuilder(
      box: Hive.box('favouriteBox'),
      builder: (context, favouriteBox) {
        // final favouriteMap = favouriteBox.toMap();

        return ListView.separated(
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: Color(0xFF999999),
          ),
          itemBuilder: (context, index) {
            final favourite = favouriteBox.getAt(index) as Favourite;
            return Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    icon: Icons.delete,
                    label: 'Delete',
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    onPressed: (BuildContext context) {
                      SnackBarHelper.showSnackBar(context, "${(favouriteBox.getAt(index) as Favourite).name} deleted.");
                      favouriteBox.deleteAt(index);
                    },
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 25, top: 5, bottom: 5, right: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favourite.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Purchase: ${favourite.purchasePrice}  Selling: ${favourite.sellingPrice == null ? '-' : favourite.sellingPrice}  Quantity: ${favourite.shareQuantity}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(CommunityMaterialIcons.trending_up),
                      onPressed: () {
                        FavouriteHelper().setFavourite(favourite).setTarget(FavouriteTarget.Profit);
                        ControllerHelper().getController().animateTo(1);
                      },
                    ),
                    IconButton(
                      icon: Icon(CommunityMaterialIcons.calculator_variant),
                      onPressed: () {
                        FavouriteHelper().setFavourite(favourite).setTarget(FavouriteTarget.Price);
                        ControllerHelper().getController().animateTo(2);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: favouriteBox.length,
        );
      },
    );
  }
}
