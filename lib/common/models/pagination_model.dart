class PaginationModel {
  final List items;
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final int prevPage;
  final int nextPage;

  PaginationModel({
    required this.items,
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        items: json["docs"] ?? [],
        totalDocs: json["totalDocs"] ?? 0,
        limit: json["limit"] ?? 0,
        totalPages: json["totalPages"] ?? 0,
        page: json["page"] ?? 0,
        pagingCounter: json["pagingCounter"] ?? 0,
        hasPrevPage: json["hasPrevPage"] ?? false,
        hasNextPage: json["hasNextPage"] ?? false,
        prevPage: json["prevPage"] ?? 0,
        nextPage: json["nextPage"] ?? 0,
      );
}
