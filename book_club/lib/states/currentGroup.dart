import 'package:book_club/models/book.dart';
import 'package:book_club/models/group.dart';
import 'package:book_club/services/database.dart';
import 'package:flutter/cupertino.dart';

class CurrentGroup extends ChangeNotifier {
  OurGroup _currentGroup = OurGroup();
  OurBook _currentBook = OurBook();

  OurGroup get getCurrentGroup => _currentGroup;

  OurBook get getCurrentBook => _currentBook;

  void updateStateFromDatabase(String groupId) async {
    try {
      _currentGroup = await OurDatabase().getGroupInfo(groupId);
      _currentBook = await OurDatabase().getCurrentBook(groupId, _currentGroup.currentBookId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
