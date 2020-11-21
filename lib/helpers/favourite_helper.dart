import 'package:stockcalculator/entities/favourite.dart';
import 'package:stockcalculator/enums/favourite_target.dart';

class FavouriteHelper {
  static final FavouriteHelper _instance = FavouriteHelper._ctor();
  factory FavouriteHelper() {
    return _instance;
  }
  FavouriteHelper._ctor();

  Favourite _favourite;
  FavouriteTarget _target;

  Favourite getFavourite() {
    return _favourite;
  }

  FavouriteHelper setFavourite(Favourite favourite) {
    _favourite = favourite;

    return this;
  }

  FavouriteHelper clearFavourite() {
    _favourite = null;

    return this;
  }

  FavouriteHelper setTarget(FavouriteTarget target) {
    _target = target;

    return this;
  }

  FavouriteTarget getTarget() {
    return _target;
  }

  FavouriteHelper resetTarget() {
    _target = FavouriteTarget.None;

    return this;
  }
}
