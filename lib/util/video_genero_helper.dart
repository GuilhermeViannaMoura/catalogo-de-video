import 'package:videos/classes/genero.dart';
import 'package:videos/classes/video_genero.dart';



Map<int,List<Genero>>? getMapGenerosByVideoId(List<Genero> generos, List<VideoGenero> videoGenero){
  Map<int,List<Genero>> map = Map();
  for(int i = 0; i < videoGenero.length;i ++){
    int generoId = videoGenero[i].genreId;
    int videoId = videoGenero[i].videoId;
    Genero? genero;
    for(int j = 0; j < generos.length;j ++){
      if(generos[j].id == generoId){
        genero = generos[j];
      }
    }
    if(map.containsKey(videoId)){
      List<Genero> updateGeneros = map[videoId]!;
      updateGeneros.add(genero!);
      map.update(videoId, (value) => updateGeneros);
    }else{
      map.addAll({videoId:[genero!]});
    }
  }
  if(map.isEmpty){
    return null;
  }
  return map;
}