import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imdb_app/models/simple_list_tile_media.dart';
import 'package:imdb_app/network_manager/hive_service.dart';
import 'package:imdb_app/network_manager/search_service.dart';

class SearchViewController with ChangeNotifier {
  late FocusNode textFieldFocusNode;
  late TextEditingController textController;
  Timer? _typingTimer;
  bool isFocused = false;
  List<SimpleListTileMedia>? listTileMediaList = [];
  List<SimpleListTileMedia>? researchesList = [];

  final _service = SearchService();
  final _hiveService = HiveService();

  SearchViewController() {
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
    // print(_hiveService.getEverythingFromBox(BoxNames.resentSearchBox));
    researchesList =
        (_hiveService.getHistory());
    notifyListeners();
  }

  void clearRecentSearches() {
    researchesList = [];
    _hiveService.clearBox();
    notifyListeners();
  }

  void clearTextFieldText() {
    textController.clear();
    textFieldFocusNode.unfocus();
  }
}
