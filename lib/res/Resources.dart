import 'package:flutter/cupertino.dart';

import 'colors/AppColors.dart';

class Resources {
  BuildContext _context;

  Resources(this._context);

  AppColors get color {
    return AppColors();
  }

  // AppDimension get dimension {
  //   return AppDimension();
  // }

  static Resources of(BuildContext context) {
    return Resources(context);
  }
}
