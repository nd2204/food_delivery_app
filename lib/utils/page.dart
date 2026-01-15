typedef FetchNextCallback<T> = Future<Page<T>> Function([int?]);

class Page<T> {
  final List<T> items;
  final bool hasMore;
  final FetchNextCallback<T> next;

  Page({required this.items, required this.hasMore, required this.next});
}
