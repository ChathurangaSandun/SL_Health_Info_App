class StatResult {
  List<Records> records;

  StatResult({this.records});

  StatResult.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = new List<Records>();
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  int id;
  String recordDate;
  int casesCount;
  int deathCount;
  int recoverCount;
  int suspectCount;

  Records(
      {this.id,
      this.recordDate,
      this.casesCount,
      this.deathCount,
      this.recoverCount,
      this.suspectCount});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recordDate = json['recordDate'];
    casesCount = json['casesCount'];
    deathCount = json['deathCount'];
    recoverCount = json['recoverCount'];
    suspectCount = json['suspectCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recordDate'] = this.recordDate;
    data['casesCount'] = this.casesCount;
    data['deathCount'] = this.deathCount;
    data['recoverCount'] = this.recoverCount;
    data['suspectCount'] = this.suspectCount;
    return data;
  }
}