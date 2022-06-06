
const baseUrl = 'http://runninus-api.befined.com:8000';

enum API {
  TEST,

  CREATE_MEETING,
  SEARCH_MEETING,

  JOIN_MEETING,
  QUIT_MEETING,
  START_MEETING,

  LOGIN,
  LOGOUT,

  GET_MEMBERS_MEETING,

  CHECK_USER,
  GET_USER_NICK,
  GET_USER_INFO,
  UPDATE_USER_INFO
}

Map<API, String> apiMap = {
  API.TEST: '/v1/meet/test',

  API.CREATE_MEETING: '/v1/meet/create',
  API.SEARCH_MEETING: '/v1/meet/search',

  API.JOIN_MEETING: '/v1/meet/join',
  API.QUIT_MEETING: '/v1/meet/quit',
  API.START_MEETING: '/v1/meet/start',

  API.LOGIN: '/login/kakao',
  API.LOGOUT: '/logout',

  API.GET_MEMBERS_MEETING: '/v1/meet/user',

  API.CHECK_USER: '/v1/user/check',
  API.GET_USER_NICK: '/v1/user/nick',
  API.GET_USER_INFO: '/v1/user/inquire',
  API.UPDATE_USER_INFO: '/v1/user/update'
};

String getApi(API apiType, {String? suffix}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (suffix != null){
    api += '$suffix';
  }
  return api;
}