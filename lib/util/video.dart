class Video{
  final int? id;
  final String title;
  final String description;
  final int type;// 0 ou 1
  final String ageRestriction;
  final int durationMinutes;
  final String thumbnailImageId;
  final String releaseDate;
  final int idUsuario;

  const Video({required this.title, required this.description, required this.type, 
  required this.ageRestriction, required this.durationMinutes, required this.thumbnailImageId, 
  required this.releaseDate, required this.idUsuario, this.id});

  factory Video.fromJson(Map<String,dynamic> json) => Video(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    type: json['type'],
    ageRestriction: json['ageRestriction'],
    durationMinutes: json['durationMinutes'],
    thumbnailImageId: json['thumbnailImageId'],
    releaseDate: json['releaseDate'],
    idUsuario: json['idUsuario']
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'type': type,
    'ageRestriction':ageRestriction,
    'durationMinutes': durationMinutes,
    'thumbnailImageId': thumbnailImageId,
    'releaseDate': releaseDate,
    'idUsuario': idUsuario 
  };
}