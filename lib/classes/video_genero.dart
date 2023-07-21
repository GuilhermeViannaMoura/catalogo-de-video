class VideoGenero{
  final int? id;
  final int videoId;
  final int genreId;

  const VideoGenero({required this.videoId, required this.genreId, this.id});

  factory VideoGenero.fromJson(Map<String,dynamic> json) => VideoGenero(
    id: json['id'],
    videoId: json['videoId'],
    genreId: json['genreId']
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'videoId': videoId,
    'genreId': genreId
  };
}