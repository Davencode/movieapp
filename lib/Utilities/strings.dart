class MovieAPI {

  final String domain = 'https://api.themoviedb.org';
  final String endpointAuth = "/3/authentication";
  final String bearerToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZTliNWY2Yzg5ZTNmZjA1MDZmMWRlYTc4ZTU1OTVlNCIsIm5iZiI6MTYwODY2OTYwMy43MTEsInN1YiI6IjVmZTI1OWEzMTk0MTg2MDAzZjNjMzc2OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b5dE6b_GrJPnpl6PUJ0cVNWfHY-p4WsZvRlPkImqFLk';

  final String endPointDiscoverMovie = '/3/discover/movie?';

  //In both filters don't forget '&' to connect each query filters (ex: $endPointDiscoverMovie&$include_adult)
  final String includeAdult = 'include_adult=true';
  final String notIncludeAdult = 'include_adult=false';
  final String includeVideo = 'include_video=true';
  final String notIncludeVideo = 'include_video=false';
  final String language = 'language=en-US';
  final String page = 'page=1';
  final String sortBy = 'sort_by=popularity.desc';

}