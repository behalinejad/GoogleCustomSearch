
//The model for search response of google custom search
class SearchResponse {
  SearchResponse({this.kind, this.title, this.snippet, this.pagemap});
  dynamic kind, title, link, snippet, pagemap;

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      kind: json['id'],
      title: json['title'],
      snippet: json['snippet'],
      pagemap: json['pagemap'],
    );
  }
}
