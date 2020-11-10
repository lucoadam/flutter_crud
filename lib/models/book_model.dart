class BookModel {
  Map<String,dynamic> bookData;
  bool isEdit;
  bool shouldUpdateList;
  BookModel({
    this.bookData,
    this.isEdit = false,
    this.shouldUpdateList = true,
});
}