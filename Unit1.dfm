object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'FRSQR'
  ClientHeight = 338
  ClientWidth = 995
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 83
    Width = 52
    Height = 13
    Caption = 'CLIENT_ID'
  end
  object Label2: TLabel
    Left = 15
    Top = 123
    Width = 79
    Height = 13
    Caption = 'CLIENT_SECRET'
  end
  object Label3: TLabel
    Left = 15
    Top = 43
    Width = 76
    Height = 13
    Caption = 'Search Request'
  end
  object Label4: TLabel
    Left = 15
    Top = 160
    Width = 40
    Height = 13
    Caption = 'Location'
  end
  object Label5: TLabel
    Left = 21
    Top = 208
    Width = 40
    Height = 13
    Caption = 'Lines : 0'
  end
  object Label6: TLabel
    Left = 93
    Top = 208
    Width = 40
    Height = 13
    Caption = 'Lines : 0'
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 209
    Height = 225
    ScrollBars = ssBoth
    TabOrder = 0
    Visible = False
    OnChange = Memo1Change
  end
  object Button1: TButton
    Left = 8
    Top = 240
    Width = 393
    Height = 25
    Caption = 'Search'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 112
    Top = 40
    Width = 300
    Height = 21
    TabOrder = 2
    Text = 'Sushi'
  end
  object Edit2: TEdit
    Left = 112
    Top = 80
    Width = 300
    Height = 21
    TabOrder = 3
    Text = 'BGQ52JWQ1NGAMKCP2SLXM0SFQ2NRWSNDP1HCRVXF3VXWBIIS'
  end
  object Edit3: TEdit
    Left = 112
    Top = 120
    Width = 300
    Height = 21
    TabOrder = 4
    Text = 'O2EDPJLYCFGIOHLT0QCWNKJLCJ0YGSHUJIV2WD5N42X1D1W3'
  end
  object Edit4: TEdit
    Left = 112
    Top = 157
    Width = 300
    Height = 21
    TabOrder = 5
    Text = 'Saint-Petersburg,RU'
  end
  object Memo2: TMemo
    Left = 232
    Top = 8
    Width = 201
    Height = 225
    ScrollBars = ssBoth
    TabOrder = 6
    Visible = False
    OnChange = Memo2Change
  end
  object Button2: TButton
    Left = 8
    Top = 271
    Width = 393
    Height = 25
    Caption = 'Parse'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Memo3: TMemo
    Left = 456
    Top = 8
    Width = 529
    Height = 319
    Lines.Strings = (
      '<dict>'
      '<key>id</key>'
      '<integer>0</integer>'
      '<key>cat</key>'
      '<string>1</string>'
      '<key>latitude</key>'
      '<string>*LAT*</string>'
      '<key>longitude</key>'
      '<string>*LON*</string>'
      '<key>name</key>'
      '<string>*NAME*</string>'
      '<key>desc</key>'
      '<string*TEXT*</string>'
      '<key>address</key>'
      '<string>*ADDR*</string>'
      '<key>phone</key>'
      '<string>*PHONE*</string>'
      '<key>site</key>'
      '<string>*LINK*</string>'
      '<key>openhours</key>'
      '<string>*STATUS*</string>'
      '<key>price</key>'
      '<string>2</string>'
      '<key>ticket_adult</key>'
      '<string>300'#8381'</string>'
      '<key>ticket_kids</key>'
      '<string>150'#8381'</string>'
      '<key>subscription</key>'
      '<string>1800'#8381'</string>'
      '</dict>')
    ScrollBars = ssBoth
    TabOrder = 8
  end
  object Button3: TButton
    Left = 8
    Top = 302
    Width = 393
    Height = 25
    Caption = 'Replace'
    TabOrder = 9
    OnClick = Button3Click
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 141
    Top = 144
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 349
    Top = 144
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 277
    Top = 144
  end
  object IdCookieManager1: TIdCookieManager
    Left = 197
    Top = 144
  end
end
