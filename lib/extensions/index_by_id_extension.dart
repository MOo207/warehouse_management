extension IndexById on List<dynamic> {
  int getIndexById(int id) {
    return indexWhere((item) {
      return item.id == id;
    });
  }
}
