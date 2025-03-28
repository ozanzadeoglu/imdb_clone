import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imdb_app/local_database_managers/hive_manager.dart';
import 'package:imdb_app/local_database_managers/list_tile_media_manager.dart';
import 'package:imdb_app/models/simple_list_tile_media.dart';
import 'package:imdb_app/models/simple_list_tile_media_history.dart';
import 'package:imdb_app/network_manager/search_service.dart';

class SearchViewController with ChangeNotifier {
  late FocusNode textFieldFocusNode;
  late TextEditingController textController;
  Timer? _typingTimer;
  bool isFocused = false;
  late IHiveManager<SimpleListTileMediaHistory> manager;
  List<SimpleListTileMedia>? listTileMediaList = [];
  List<SimpleListTileMedia>? researchesList = [];

  final _service = SearchService();

  SearchViewController() {
    manager = ListTileMediaManager();
    fetchRecentSearches();
    textFieldFocusNode = FocusNode();
    textFieldFocusNode.addListener((changeTextFieldFocus));
    textController = TextEditingController();
    textController.addListener((restartTimer));
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  void changeTextFieldFocus() {
    if (textFieldFocusNode.hasFocus == true ||
        textController.text.isNotEmpty == true) {
      isFocused = true;
    } else {
      fetchRecentSearches();
      isFocused = false;
    }
    notifyListeners();
  }

  void startTimer() async {
    _typingTimer = Timer(const Duration(milliseconds: 600), () async {
      listTileMediaList = await _service.fetchMultiSearch(textController.text);
      notifyListeners();
    });
  }

  void restartTimer() {
    _typingTimer?.cancel();
    startTimer();
  }

  void fetchRecentSearches() {
    final entries = manager.fetchValues();
    entries?.sort((a, b) => b.accessedAt.compareTo(a.accessedAt));
    researchesList = entries?.map((entry) => entry.item).toList() ?? [];
    notifyListeners();
  }

  void clearRecentSearches() {
    researchesList = [];
    manager.clearBox();
    notifyListeners();
  }

  void clearTextFieldText() {
    textController.clear();
    textFieldFocusNode.unfocus();
  }

  void addToHistory(SimpleListTileMedia item) async {
    final key = '${item.mediaType}_${item.id}';
   await  manager.putItem(
      key,
      SimpleListTileMediaHistory(item: item, accessedAt: DateTime.now()),
    );
  }
}
