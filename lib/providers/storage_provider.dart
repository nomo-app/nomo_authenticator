import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:nomo_authenticator/model/storage_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'storage_provider.g.dart';

@riverpod
class Storage extends _$Storage {
  @override
  Future<List<StorageItem>> build() async {
    return await _readStorageItem();
  }

  Future<List<StorageItem>> _readStorageItem() async {
    final storage = window.localStorage;

    final result = storage["nomo_authenticator"];

    if (result == null) {
      return [];
    }
    final decodedJson = jsonDecode(result);

    List<Map<String, dynamic>> storageItems =
        List<Map<String, dynamic>>.from(decodedJson);

    final items = storageItems.map((e) => StorageItem.fromJson(e)).toList();

    return items;
  }

  void addStorageItem(StorageItem item) async {
    final storage = window.localStorage;

    var items = AsyncData(
      await _readStorageItem(),
    );

    items.value.add(item);

    final itemJson = jsonEncode(items.value).toString();
    storage["nomo_authenticator"] = itemJson;

    state = AsyncData(items.value);
  }

  void removeStorageItem(StorageItem item) async {
    final storage = window.localStorage;

    var items = AsyncData(
      await _readStorageItem(),
    );

    items.value.removeWhere((element) =>
        element.hostname == item.hostname && element.code == item.code);

    final itemJson = jsonEncode(items.value).toString();
    storage["nomo_authenticator"] = itemJson;

    state = AsyncData(items.value);
  }
}
