unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdCookieManager, StdCtrls, JsonDataObjects;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    IdAntiFreeze1: TIdAntiFreeze;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    IdCookieManager1: TIdCookieManager;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Memo2: TMemo;
    Label6: TLabel;
    Button2: TButton;
    Memo3: TMemo;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  list:tstringlist;
implementation

{$R *.dfm}


function parse( tSlist:string; argList:TStringList):TStringList;
     type
        WorkStruct = record
          lat: string;
          lng: string;
          name: string;
          text: string;
          formattedAddress: string;
          formattedPhone: string;
          url:string;
          hours: string;
          crc:integer;
       end;

     var wsItem:WorkStruct;
          i,ii, argliIndex:integer;
          swp:string;
          b:boolean;
          chekd:Double;

    begin
        parse:=TStringList.Create;
        i:=0;
        i:=AnsiPos(argList[0],tSlist);
          if AnsiPos(argList[0],tSlist)>0 then
          begin

         {++++++++++++++++++coordinats parse( coz numeric value)[ lat, lng] +++++++++++++++++++++++++++++++++++}
          for argliIndex := 1 to 2 do
            if AnsiPos(argList[argliIndex],tSlist)>-1 then
             begin
               i:=AnsiPos(argList[argliIndex],tSlist) + Length(argList[argliIndex]);
               ii:=i;
               while Length(tSlist)-1<>ii do
                  begin
                     Application.ProcessMessages;
                     inc(ii);
                     if tSlist[ii]=','  then
                     begin
                       parse.Add(swp);
                       swp:='';
                       break;
                     end;
                     if tSlist[ii]='.' then
                        begin
                          swp:=swp+'.';
                          continue;
                        end;

                     if TryStrToFloat(tSlist[ii],chekd)then
                       begin
                         swp:=swp+tSlist[ii];
                         continue;
                       end
                     else parse.Add(swp);
                     swp:='';
                     break;
                  end;
             end;
             {++++++++++++++++++end coordinats parse+++++++++++++++++++++++++++++++++++}
             {++++++++++++++++++text values [name, text ...]+++++++++++++++++++++}
          i:=1;

          for argliIndex := 3 to argList.Count - 1 do
             if AnsiPos(argList[argliIndex],tSlist)>-1 then
               begin
                 i:=AnsiPos(argList[argliIndex],tSlist) + Length(argList[argliIndex]);
                  ii:=i;
                 b:=False;
                 swp:='';
                 if argliIndex<>5 then  {+++++problem with formattedAddress+++++}
                    while Length(tSlist)-1<>ii do
                      begin
                         Application.ProcessMessages;
                         inc(ii);

                         if (tSlist[ii]='"')and(b=False) then
                            begin
                              b:=True;
                              continue;
                            end;


                         if b then
                          begin
                            swp:=swp+tSlist[ii];
                          end;
                         if (tSlist[ii+1]='"') then break;
                      end
                 else  {++++++++++++ parse only formattedAddress+++++++++++++++}
                   while Length(tSlist)-1<>ii do
                        begin
                           Application.ProcessMessages;
                           inc(ii);

                           if (tSlist[ii]='[')and(b=False) then
                              begin
                                b:=True;
                                continue;
                              end;


                           if b then
                            begin
                              swp:=swp+tSlist[ii];
                            end;
                           if (tSlist[ii+1]=']') then break;
                      end;

                    parse.Add(swp);

               end;
                {++++++++++++++++++end text values [name, text ...]+++++++++++++++++++++}
          end;
    end;

function StrBreak(str, Delimeter: string; fromParts, Cnt : integer) : string;
{
 str : your string
 Delimeter : Delimeter symbol
 fromParts : Initial position
 Cnt : Number of items
}
var
 StrL : TStringList;
 ParseStr : string;
 i : integer;
begin
  Result := '';
  try
    StrL := TStringList.Create;
    ParseStr:= StringReplace(str, Delimeter, #13, [rfReplaceAll]);
    StrL.Text := ParseStr;
    if StrL.Count > 0 then
    begin
      for i := 0 to Cnt-1 do
        if (StrL.Count > i) and (StrL.Count > fromParts) then
            if i>0 then Result := Result + Delimeter + StrL.Strings[fromParts+i]
                    else Result := Result + StrL.Strings[fromParts+i];
    end;
  finally
    StrL.Free;
  end;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
i:integer;
begin
list:=tstringlist.Create;
Memo1.Lines.text:=idHTTP1.Get('https://api.foursquare.com/v2/venues/explore?client_id='+edit2.text+'&client_secret='+edit3.text+'&v=20130815&near='+edit4.text+'&query='+edit1.text+'&limit=400');
list.Text:=memo1.lines.Text;

//list.text:=StringReplace(list.text, '},"','},"'+#10+#13,[rfReplaceAll, rfIgnoreCase]);
  {
for I := 0 to List.Count - 1 do

  if list[i]='' then
  list.Delete(i);
   }
{
for I := 0 to List.Count - 1 do
if pos(',"name":"',list[i])<>0 then
 begin
  memo2.Lines.Add(copy(list[i],pos(',"name":"',list[i])+9,pos('","',list[i])));
 end;
 }
 list.SaveToFile('file.txt');
memo1.Text:=list.Text;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
    s: string;
    i, ij,ii: LongInt;
    b: array [1 .. 2] of boolean;
    swp: string;
    sList: array [1 .. 3000] of string;
    sListIndex: integer;
    venueflag:boolean;
    slFromMemo, slForSl, argList:TStringList;

    chekd:double;
    chekPossError:integer;
begin
    Memo2.Clear;
    i:=0;
         {=============================================}
    slFromMemo:=TStringList.Create;
    slForSl:=TStringList.Create;

    argList:=TStringList.Create;
    argList.LoadFromFile('arglist.txt');

      slFromMemo.loadfromfile('file.txt');
      slFromMemo.Text := StringReplace(slFromMemo.Text, 'venue', #10+#13+'"venue',[rfReplaceAll, rfIgnoreCase]);
      Memo1.Clear;
      Memo1.Text:=slFromMemo.Text;

      for i := 0 to slFromMemo.Count- 1 do
           if slFromMemo[i]<>'' then
            begin
            slForSl:=parse(slFromMemo[i],argList);
            if slForSl.Text='' then continue;
            Memo2.Lines.Add(slForSl.Text);
            Memo2.Lines.Add('++++++++++++++++++++++++++');
            end;
            slForSl.Free;
            arglist.Free;
    {===============================================}

end;

procedure TForm1.Button3Click(Sender: TObject);
var
ii:integer;
alist:tstringlist;
dstr:string;
FinishList:tstringlist;
begin
 alist:=tstringlist.Create;
 FinishList:=tstringlist.Create;
 alist.text:=memo2.Text;
 for ii := 0 to alist.Count -1 do
  begin
   try
  if ii>200 then
   dstr:='true';
   if alist[ii]='#10+#13' then continue;
    if pos('++++++++++++++++++++++++++',alist[ii])<>0 then
     if alist[ii+1][3]='.' then
      begin
       Memo3.text:=(StringReplace(Memo3.Text, '*LAT*',alist[ii+1],[rfReplaceAll, rfIgnoreCase]));
       Memo3.text:=(StringReplace(Memo3.Text, '*LON*',alist[ii+2],[rfReplaceAll, rfIgnoreCase]));
       Memo3.text:=(StringReplace(Memo3.Text, '*NAME*',alist[ii+3],[rfReplaceAll, rfIgnoreCase]));
       Memo3.text:=(StringReplace(Memo3.Text, '*TEXT*',alist[ii+4],[rfReplaceAll, rfIgnoreCase]));
       Memo3.text:=(StringReplace(Memo3.Text, '*ADDR*',alist[ii+5],[rfReplaceAll, rfIgnoreCase]));
       Memo3.text:=(StringReplace(Memo3.Text, '*PHONE*',alist[ii+6],[rfReplaceAll, rfIgnoreCase]));
       Memo3.text:=(StringReplace(Memo3.Text, '*LINK*',alist[ii+7],[rfReplaceAll, rfIgnoreCase]));
       Memo3.text:=(StringReplace(Memo3.Text, '*STATUS*',alist[ii+8],[rfReplaceAll, rfIgnoreCase]));
       FinishList.Add(#10+#13+memo3.Text);
       Memo3.clear;
       Memo3.Lines.LoadFromFile('shablon.txt');
       end
     except
      end;
  end;
    FinishList.SaveToFile('DONE.txt');
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
label5.Caption:='Lines : ' + IntToStr(Memo1.Lines.Count)
end;

procedure TForm1.Memo2Change(Sender: TObject);
begin
label6.Caption:='Lines : ' + IntToStr(Memo2.Lines.Count)
end;

end.
