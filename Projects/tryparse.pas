unit tryparse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    Timer1: TTimer;
    Label1: TLabel;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
   
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public
   { Public declarations }
    end;

var
  Form1: TForm1;


implementation

{$R *.dfm}

{function for threading}
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

{end threading}

  procedure TForm1.Button1Click(Sender: TObject);
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
    Timer1.Enabled:=True;
    Timer1.Interval:=1000;
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
            Memo2.Lines.Add(slForSl.Text);
            Memo2.Lines.Add('++++++++++++++++++++++++++');
            end;
    {===============================================}

     Timer1.Enabled:=False;
  end;




procedure TForm1.Button3Click(Sender: TObject);
  var  s:string;
      i:integer;
      sl:TStringList;
begin
  sl:=TStringList.Create;
  sl.LoadFromFile('arglist.txt');
  Memo2.Lines.Add( sl.Text);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  Label1.Caption:=IntToStr(StrToInt(label1.caption)+1);
end;

end.
