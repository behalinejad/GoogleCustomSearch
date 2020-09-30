
//The model for search response of google custom search
class SearchResponse {
  SearchResponse({this.kind, this.title, this.snippet, this.pagemap,this.link});
  dynamic kind, title, link, snippet, pagemap;

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      kind: json['id'],
      link: json['link'],
      title: json['title'],
      snippet: json['snippet'],
      pagemap: json['pagemap'],
    );
  }
}
