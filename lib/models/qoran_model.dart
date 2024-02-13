class QoranModel {
  int? id;
  int? chapterId;
  double? fileSize;
  String? format;
  String? audioUrl;

  QoranModel(
      {this.id, this.chapterId, this.fileSize, this.format, this.audioUrl});

  QoranModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chapterId = json['chapter_id'];
    fileSize = json['file_size'];
    format = json['format'];
    audioUrl = json['audio_url'];
  }
  static List<QoranModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => QoranModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chapter_id'] = this.chapterId;
    data['file_size'] = this.fileSize;
    data['format'] = this.format;
    data['audio_url'] = this.audioUrl;
    return data;
  }
}