import 'package:flutter/material.dart';
import 'package:mute_help/model_menu/menu_item.dart';

class MenuItems {
  static const List<Menu_Item> itemsFirst = [ itemShare];

  
  static const itemShare = Menu_Item(
    'Back',
    Icons.stop,
  );
}
class FormMenuItems {
  static const List<Menu_Item> itemsFirst = [itemUpdate];
  static const itemUpdate = Menu_Item(
    'Update',
    Icons.update,
  );
}
