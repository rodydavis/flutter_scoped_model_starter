class CompanyCategory {
  String name;
  int order;

  CompanyCategory({this.name, this.order});

  CompanyCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['order'] = this.order;
    return data;
  }
}