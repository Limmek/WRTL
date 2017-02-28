object FormSettings: TFormSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Settings'
  ClientHeight = 371
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 160
    Top = 180
    Width = 124
    Height = 14
    Hint = 'Klick to open'
    Caption = 'https://api.telldus.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = Label5Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 314
    Height = 176
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 5
      Width = 308
      Height = 13
      Margins.Top = 5
      Align = alTop
      Alignment = taCenter
      Caption = 'Public key'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 57
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 48
      Width = 308
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Private key'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 65
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 91
      Width = 308
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Token'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 35
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 134
      Width = 308
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Token secret'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 74
    end
    object Edit_PUBLIC_KEY: TEdit
      AlignWithMargins = True
      Left = 20
      Top = 21
      Width = 274
      Height = 21
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 20
      Align = alTop
      Alignment = taCenter
      TabOrder = 0
    end
    object Edit_PRIVATE_KEY: TEdit
      AlignWithMargins = True
      Left = 20
      Top = 64
      Width = 274
      Height = 21
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 20
      Align = alTop
      Alignment = taCenter
      TabOrder = 1
    end
    object Edit_TOKEN_SECRET: TEdit
      AlignWithMargins = True
      Left = 20
      Top = 150
      Width = 274
      Height = 21
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 20
      Align = alTop
      Alignment = taCenter
      TabOrder = 2
    end
    object Edit_TOKEN: TEdit
      AlignWithMargins = True
      Left = 20
      Top = 107
      Width = 274
      Height = 21
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 20
      Align = alTop
      Alignment = taCenter
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 331
    Width = 314
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object ImageLocalFolder: TImage
      AlignWithMargins = True
      Left = 264
      Top = 0
      Width = 40
      Height = 40
      Hint = 'Local folder'
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alRight
      Center = True
      ParentShowHint = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
        00200806000000737A7AF4000000F44944415478DAEDD6C11182301005D0A402
        2D412A503BD00A9412AC404BD012A8404AD00AC40AD40AD40EB402FD0B814972
        703CE85F0EECCC3F30C34C5E02BB608D72D90ED006C0EB8BFB6EC818796801A4
        36C85A132095B8D3500314C85413F0AB35DB0D38FE1930F90478227DF671F880
        3D3247CEC890B0FE3D0648AFE7C8957400590C90161B205B12208D0172BD4366
        2480F501176464AA79DF232C5EBE6F3E2073BB3F9076BF40721F909AAA479724
        40F95DF101893B0146FBD58F3B9803F2BD3F91762F8F7B1503E4E5634D4169F7
        2206B02A18F71A807ADCAB01CAF6D30404BF756C40D37E5A80A6FD7C806A7500
        75C01BCD1E3AE1E3A05F370000000049454E44AE426082}
      ShowHint = True
      OnClick = ImageLocalFolderClick
      OnMouseDown = ImageLocalFolderMouseDown
      OnMouseUp = ImageLocalFolderMouseUp
      ExplicitLeft = 295
    end
    object ImageSave: TImage
      AlignWithMargins = True
      Left = 10
      Top = 0
      Width = 40
      Height = 40
      Hint = 'Save'
      Margins.Left = 10
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alLeft
      Center = True
      ParentShowHint = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
        00200806000000737A7AF40000019A4944415478DAED97E15583400CC7C30475
        049CC03A8175027502EB04BA8138816E206CA0135827B04EE07502E9049AFF23
        81E3DE1D95F6287E68DECB7B8590E4772109AF09553265BD67BDA461C4B03EB0
        E6AE2191E41F1EA7C2E7B0853CB19EC86FC4BB710116AC671EC773B1FD55664E
        9C424E9E51555D951604007E0201FB02B889D4DFBDDF82180BA086181380FE03
        80191B60D41E38006C04B8627DE90110126CC2DB6D004AD66504805997B10B60
        2F720070015654BD333350BE94AABE9A8400DE6943D35872C4FA28015F7B402F
        C8FA6CEF0AF06D5D0300635B50F7F44403D06018D73BF19B4B707CEBF37D0020
        F135EBA95C67D46CBD1044548094F58BF558FC9E1DBB6F9D4705801889917A6C
        A540D83D111D00CFA3F92601BB0B31B72B1503003295938520564E856A885800
        5A8937CFFDB5D8D0B039353D01882C2640EB649EE498164C065E57A9958B0D60
        43F89243B03D31B60617430028C4D2935CAB538F672225B9880C0049A9DA116E
        F24FC9512A80FDE754D7AAD921F19A9A914BA9BDA05AC915800422B32AB1ABD8
        6B5863EBE14AFBC15F9339A55E347A03D40000000049454E44AE426082}
      ShowHint = True
      OnClick = ImageSaveClick
      OnMouseDown = ImageSaveMouseDown
      OnMouseUp = ImageSaveMouseUp
    end
    object ImageRegedit: TImage
      AlignWithMargins = True
      Left = 218
      Top = 0
      Width = 40
      Height = 40
      Hint = 'Autorun registry key'
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alRight
      Center = True
      ParentShowHint = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
        00200806000000737A7AF4000001924944415478DAED57ED51C3300C552668D9
        A01BB44C5098803201EE0494096003CA04A41B940908131026204C40980024A2
        E4DC60C9098E397EE4DDBDF325F2C78B644B7102F1B1455E0AB6320998F804F9
        C80B5C29FD32E45232FE56C014F9CA2D21479E238BBF12E09AB444AE91FBD802
        36C85BC5DE0EC9A00216C8E70EFD8EA10ACBE002D4C9183BA4E9E301FAAA8960
        7F83C38DB542A64AFF17A84E4769BD332D41367212F0A97CCD032F6A6306D546
        9BB7DE7FF0E239F4804FC0134FEAC20DF2DA7A5EB3777A214400B08DBC91393C
        E50285BB002B44A1027CA044B564712B7EA623BA8D2DC020CF04AF1CCC194B00
        B978A2D88FB88F5780EB1474C19E3D20A1D9B0751E980A1D0B7017181F0CF25E
        B137C92AF1B8EB8E5BB19E43E5CE36E883DE1501CDB82E7B80A0A55F299D679E
        71DFF522A60057D5A4549DB2B83CB60766BC082D5627ABC2353896804E1805D0
        60CACB0BC19E726B043BC578338480B960DF717BA108A05C41BBDD95CCE8BC53
        F1293401A1213885EA7EA0D9B351C028E05F0B0829C7F5AFB8765BB26F493FF0
        057E95809A5CEC180F0000000049454E44AE426082}
      ShowHint = True
      OnClick = ImageRegeditClick
      OnMouseDown = ImageRegeditMouseDown
      OnMouseUp = ImageRegeditMouseUp
      ExplicitLeft = 245
    end
    object ImageLogFile: TImage
      AlignWithMargins = True
      Left = 172
      Top = 0
      Width = 40
      Height = 40
      Hint = 'Open logfile'
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alRight
      Center = True
      ParentShowHint = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
        00200806000000737A7AF4000000CB4944415478DAEDD4610DC2301005E09B03
        1C30094800073860489802C00112EA0009200109C5011278CBEE0709CDF6B2DD
        D12CE94BDE9F26BD7D5BBA5692395562AD410F13E73DD1762EE08C9E66BC5440
        8FB900ADEEBFB1086BC00E7DA30F16E101E81EBE61115E0061119E000AE10D18
        455803021A13EB1D622FFD5F72F5048CE5A2F30B6079809F8D44A8392C204AFA
        740FA5D69A00ACB25C007B06B6E8DD0310853B032BE96F3D73805526035EE417
        F84E8DAEAD00D9EF01AB14400114000568B41E09DA41C05FF301E09F552181AD
        6DBD0000000049454E44AE426082}
      ShowHint = True
      OnClick = ImageLogFileClick
      OnMouseDown = ImageLogFileMouseDown
      OnMouseUp = ImageLogFileMouseUp
      ExplicitLeft = 195
    end
  end
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 0
    Top = 176
    Width = 314
    Height = 155
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    ActivePage = TabSheet1
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    TabOrder = 2
    StyleElements = [seFont, seClient]
    object TabSheet1: TTabSheet
      Caption = 'Default Settings'
      object CheckBox_AutoLoadDevices: TCheckBox
        AlignWithMargins = True
        Left = 15
        Top = 0
        Width = 276
        Height = 20
        Margins.Left = 15
        Margins.Top = 0
        Margins.Right = 15
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Auto load devices on application start'
        TabOrder = 0
      end
      object CheckBox_SartWithWindows: TCheckBox
        AlignWithMargins = True
        Left = 15
        Top = 26
        Width = 276
        Height = 20
        Margins.Left = 15
        Margins.Top = 6
        Margins.Right = 15
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Autorun at windows start'
        TabOrder = 1
      end
      object CheckBox_StartMinimized: TCheckBox
        AlignWithMargins = True
        Left = 15
        Top = 52
        Width = 276
        Height = 20
        Margins.Left = 15
        Margins.Top = 6
        Margins.Right = 15
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Start minimized'
        TabOrder = 2
      end
      object CheckBox_WinNotification: TCheckBox
        AlignWithMargins = True
        Left = 15
        Top = 104
        Width = 276
        Height = 20
        Margins.Left = 15
        Margins.Top = 6
        Margins.Right = 15
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Enable windows notifications'
        TabOrder = 3
      end
      object CheckBox_LogToFile: TCheckBox
        AlignWithMargins = True
        Left = 15
        Top = 78
        Width = 276
        Height = 20
        Margins.Left = 15
        Margins.Top = 6
        Margins.Right = 15
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Enable logging'
        TabOrder = 4
      end
    end
    object TabSheet2: TTabSheet
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'About'
      ImageIndex = 2
      OnShow = TabSheet2Show
      object ImageGit: TImage
        AlignWithMargins = True
        Left = 201
        Top = 3
        Width = 100
        Height = 104
        Margins.Right = 5
        Align = alRight
        AutoSize = True
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000640000
          0064080600000070E29554000007404944415478DAED5D8BB1D436143DAF021E
          15C454005410A782900A301524A9204B05900AD857015041940A422A88A92050
          41E2339277BC5ED996ACAB8F8DCF8C985DF68D2CE948BA1FDD2BDFE14051B8CB
          DD8003D7D80A21DF77E5BE2BCF4CB937FF5F9932446B0AF1A52B9F4CE1E73F73
          776409A512F263576A539E09D74D7294291F7377748C5208E18C27092F4C4989
          0FA6909C2FB90722372175575E4293701F56553048068979805E3D59908B1092
          D0401352225457DE22C396969A101271C2AD202E15AD69EF43AA07A6228482F9
          0DCA5D114B505DF9155A21888AD884502EFCD6955F62772411B88DBD4644E11F
          9390BA2BEF915F584BA3EDCA2B4412FCB108E1AA3845AABB14B07FAFA52B9526
          84AB81ABA28E3F1E454075E527086E6192845070FF81FD6D514B20193F4048E0
          4B11F2AD92D1438C1409426865BFC3B74B460F924261FF21A492504248C6FBDC
          235118285356931242C8B7BE4D4D2168FB5A4BC841C63C5693B2861092F00F0E
          3296D076E5393C55E235847065D4B97BBB1128E895E20C5F424ED056F80177D0
          9A3FB9FEB10F2135F4EA38E00FAE12E5F287AE841C72230C2D1CE5892B21743B
          FF1CD8282E5D653EF7912315B42DF328FD1859F115DA8668711DBD52237CABFE
          1D0EC7102E8470F0FE0A6C0C4FDC9A99DFFBE0869781CF5903927036654E4D3D
          0BB4EFF9C2339C0809D5AA3E4393EAA2FE55D00270AAE35F711D67F5C9526F1F
          BF358CE37A3451D75B535CDAC6FA5A84AD668505AD6B899006DA4F15022F2DC3
          808378EECA53E840036E233D116BD013C355C870A3BF4DDF7CEB93D8BA5F99BE
          59B14408057915D800670DC302CE4AE9E3D2903A6B846B9A6D579E4CFD384748
          83F0D5B1F48C2DE23F813A261D9073832565911F84DC426142964C0D560D1923
          9082736FB68B042184752B9F22E40C3915F4582176584D01DB60495BE5072176
          50B178829182611BAC0632C2BCC7631410552E044ED27F05EBBB51816D8450FA
          FF28F8D010B5B734D49075B0D2C6BA4ABF1813223D0308C6C4BE951E994CA02F
          EA8D709D77935F10276861C98FB5259C21EF6FBBB249C68448B806C668316399
          6E0C129E8B31AEBCC06342E8D595CEE963A2652D5C672E28E8045449D09FF6BC
          FF3226444AA51B82ABA38D506F0E481C45D87077F301718E689D0E65368633E4
          E5C845131D121243A0EF6975F4A8213F712F827D48C809B211253C73909647A5
          A0EDCA7782F55DCE8C8684481B846B0EA6B602696DF462200E095190D520F664
          A18F21BDBD5F34D19884ECCDA93884B447C34A88B4D1B36742084913A185319E
          878326F9803D0BF41E2D6405FBDDE51F034942F6649D4F4121C2161F8B9016FB
          F15F4D813244F2783A2A21E3BAF78828E37510B21ED109A1D7F1A9E00316E358
          370C692763123B644F278563489F1C5A0991769DEC59D352909DBC56D7C909F2
          E96A7B8A38E91123EEC0EA5C8C7180BF470723FB233D712FDB7BEC032A6B30D8
          86112BB5CF7A4045C438C2DDD32A613F6264215B8F700969D59710BDBE282362
          DD5E71E5F71B1372469C3CBF162B6E3528082481764715A1EED930A098B7FB50
          AD662CEBD64821198C758E75E3F66CA05C0C956E086E5BDCBEB6420AC783DB54
          CCA3842BD3C0E66F52F0337AFA6C5665BE73263598CE562529AF50BE4C2109EF
          10978C1BE359221DC19655CA9975C27C20007FE7FE59E26AE9EF1A8E9DFDE594
          8EE0BB6DCD0533BC300F9C5A2D2D125FE5BD801A7A3256899E77E3C9987291FB
          F8B566F3AEA197BCC27CC27D0BBDED3D20FD8AE104A466C91551257CEE4D6E08
          2191F4E96267F8D4C7C9A04C83DB48835141CBC91AF95E95E195F409F81DE2BB
          90D2C03F558E6DA09F27E8A6CF012AE8895109D5B7169FA7DA207971808BDFCA
          B74EEBB20E448C1C185F4C6EF34BC7AC2DFC425D5CB2A55E984199ABB7BF2689
          FB7A0C9912C345E48AC9D541C4B87CC635E2BDBFAD6708DBED3E315023DFED78
          4197CF10BEB3692B39210AF2D9504B580C207421A486DF6CE20C7F9CB8A36BE0
          DB2F092C06A0BB86EA9CE1E7055EB24D4A410BD970D0393829283E9760B2F1AE
          B7A92978DE579B09A9342E2A2915042FC1247C5DF34197D22742AA9709388F85
          6F74A1CF8CE26CE0A1549BA0C36B11FBB881F0BA38614DB8A78FD6B505577B8C
          38821ED4AA6A78A8F26B08A9A007D8559EB031276875B844B48823D829376A78
          4EC690D75528F85D994A62CED07B697FDD6B09603F62D823AB629B4322D46309
          C4D451F30AF284AC56FB433BDF40F6B2338936F942419690201B4CA2F30D6449
          D93221C106B154E71B689558E252FDAD1222E29D907EB1243B174ACAD608A182
          D240C80896EE7C651A1672D6B0254256A9B6A93BEF120294BA4D735058470863
          AAA8698A9EDFC4ECFC5208508E36D9A0E04F48B488FE142FB83FC32F55AE6442
          D6BEE6A2B8CED7D0C42CB92866CF9B2341C18D9024792EA96763633A35454C8E
          E49EA554BE07D3A63645637224F7731B6BCC400C89F1F68C0AB647E15633FC68
          DAD8A66C4CEEDB16FA48790E48CE9CF67BF3FCDAB4E5844CE738B9093930C241
          48613808290C072185E120A430FC0F0E0D9B7408B202E20000000049454E44AE
          426082}
        OnClick = LabelGitClick
        ExplicitLeft = 206
        ExplicitTop = 0
        ExplicitHeight = 99
      end
      object LabelGit: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 110
        Width = 296
        Height = 14
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 2
        Align = alBottom
        Alignment = taRightJustify
        Caption = 'https://github.com'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = LabelGitClick
        ExplicitLeft = 196
        ExplicitWidth = 105
      end
      object LabelAuthor: TLabel
        Left = 3
        Top = 90
        Width = 38
        Height = 14
        Caption = 'Author'
      end
      object LabelVersion: TLabel
        Left = 3
        Top = 105
        Width = 40
        Height = 14
        Caption = 'Version'
      end
      object LabelAbout: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 198
        Height = 100
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        Caption = 
          'This application is used to call the TelldusLive API and remotel' +
          'y control your devices from any computer.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitHeight = 52
      end
    end
  end
end
