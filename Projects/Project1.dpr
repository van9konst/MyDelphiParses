program Project1;
{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  workStruct = record
    lat: string;
    lng: string;
    name: string;
    text: string;
    formattedAddress: string;
    formattedPhone: string;
    url:string;
    hours: string;
  end;

var
  s: string;
  i: integer;
  b: array [1 .. 2] of boolean;
  swp: AnsiString;
  sList: array [1 .. 1000000] of string;
  sListIndex: byte;

begin
  writeln('Hello, world!');
  s := '"venue":{"id":"4bb4c25bbc82a593e2c43e72","name":"Ginza","contact":{"phone":"+78126401616","formattedPhone":"+7 812 640-16-16","twitter":"ginzaprojectspb","facebook":"181301848563488","facebookUsername":"Ginzaprojectspb","facebookName":"Ginza Project Saint-Petersburg"},"location":{"address":"Аптекарский пр., 16","crossStreet":"Медиков пр.","lat":59.97321752473798,"lng":30.319198082548976,"postalCode":"197022","cc":"RU","city":"Санкт-Петербург","country":"Россия","formattedAddress":["Аптекарский пр., 16 (Медиков пр.)","197022, Санкт-Петербург","Россия"]},"categories":[{"id":"4bf58dd8d48988d111941735","name":"Japanese Restaurant","pluralName":"Japanese Restaurants","shortName":"Japanese","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/japanese_","suffix":".png"},"primary":true}],"verified":true,"stats":{"checkinsCount":22427,"usersCount":6820,"tipCount":122},"url":"http:\/\/ginzaproject.ru","price":{"tier":3,"message":"Expensive","currency":"$"},"rating":8.8,"ratingSignals":660,"allowMenuUrlEdit":true,"hours":{"status":"Open until 1:00 AM","isOpen":true},"specials":{"count":0,"items":[]},"photos":{"count":4569,"groups":[]},"hereNow":{"count":4,"summary":"4 people are here","groups":[{"type":"others","name":"Other people here","count":4,"items":[]}]},"storeId":""},"tips":[{"id":"5026810de4b0e4d95ff84c80","createdAt":1344700685,"text":"Камчатских крабов в ресторане Ginza содержат в специальном аквариуме, где поддерживается необходимая температура и соленость воды. Шеф-повар владеет всеми способами приготовления \u2013 можно выбрать любой","type":"user","canonicalUrl":"https:\/\/foursquare.com\/item\/5026810de4b0e4d95ff84c80","photo":{"id":"5026810ef31c5511feaefe5d","createdAt":1344700686,"source":{"name":"Foursquare Web","url":"https:\/\/foursquare.com"},"prefix":"https:\/\/irs3.4sqi.net\/img\/general\/","suffix":"\/xge_J3_d7-FAvF-34j0Z3w0-kqG3g5VvrLNne40bK8k.jpg","width":720,"height":480},"photourl":"https:\/\/irs3.4sqi.net\/img\/general\/original\/xge_J3_d7-FAvF-34j0Z3w0-kqG3g5VvrLNne40bK8k.jpg","likes":{"count":68,"groups":[],"summary":"68 likes"},"logView":true,"todo":{"count":10},"user":{"id":"32965181","firstName":"Ginza Project","gender":"none","photo":{"prefix":"https:\/\/irs3.4sqi.net\/img\/user\/","suffix":"\/FZKE1Q2TZZRJFJEI.png"},"type":"chain"}}],"referralId":"e-0-4bb4c25bbc82a593e2c43e72-0"},{"reasons":{"count":0,"items":[{"summary":"This spot is popular","type":"general","reasonName":"globalInteractionReason"}]},';
  writeln(s);

  b[1] := false;
  b[2] := false;
  
  swp := '';
  sListIndex := 1;

  for i := 1 to length(s) + 1 do
  begin
    if s[i] = '{' then
    begin
      b[1] := false;
      b[2] := false;
      swp := '';
      continue;
    end;
    if (s[i] = '}') or (s[i] = ']') then
    begin
      if swp <> '' then
        continue;
      sList[sListIndex] := swp;
      inc(sListIndex);
      swp := '';
      continue;
    end;

    if s[i] = '"' then
      if b[1] then
        b[1] := false
      else
        b[1] := true;

    if s[i] = ':' then
    begin
      b[2] := true;
      continue;
    end;
    if s[i] = ',' then
      b[2] := false;

    if b[1] or b[2] then
    begin
      if (s[i] = '"') then
        continue;
      swp := swp + s[i];
    end
    else
    begin
      if swp <> '' then
        sList[sListIndex] := swp;
      inc(sListIndex);
      swp := '';
    end;

  end;
  for i := 1 to sListIndex do
    writeln(sList[i]);
  writeln(#13);

end.
