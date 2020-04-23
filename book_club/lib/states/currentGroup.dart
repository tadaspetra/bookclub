import 'package:book_club/models/book.dart';
import 'package:book_club/models/group.dart';
import 'package:book_club/services/database.dart';
import 'package:flutter/cupertino.dart';

class CurrentGroup extends ChangeNotifier {
  OurGroup _currentGroup = OurGroup();
  OurBook _currentBook = OurBook();
  bool _doneWithCurrentBook = false;

  OurGroup get getCurrentGroup => _currentGroup;
  OurBook get getCurrentBook => _currentBook;
  bool get getDoneWithCurrentBook => _doneWithCurrentBook;

  void updateStateFromDatabase(String groupId, String userUid) async {
    try {
      _currentGroup = await OurDatabase().getGroupInfo(groupId);
      _currentBook = await OurDatabase().getCurrentBook(groupId, _currentGroup.currentBookId);
      _doneWithCurrentBook =
          await OurDatabase().isUserDoneWithBook(groupId, _currentGroup.currentBookId, userUid);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void finishedBook(String userUid, int rating, String review) async {
    try {
      await OurDatabase()
          .finishedBook(_currentGroup.id, _currentGroup.currentBookId, userUid, rating, review);
      _doneWithCurrentBook = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
