object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'WinRemoteTelldusLive'
  ClientHeight = 271
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 219
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clBtnHighlight
    ParentBackground = False
    TabOrder = 0
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 167
      Height = 219
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Panel3'
      Color = clBtnHighlight
      DoubleBuffered = False
      ParentBackground = False
      ParentDoubleBuffered = False
      ShowCaption = False
      TabOrder = 0
      object Panel4: TPanel
        Left = 0
        Top = 192
        Width = 167
        Height = 27
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object Button2: TButton
          AlignWithMargins = True
          Left = 4
          Top = 0
          Width = 70
          Height = 27
          Margins.Left = 4
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Add'
          Enabled = False
          TabOrder = 0
          OnClick = Button2Click
        end
        object Button3: TButton
          AlignWithMargins = True
          Left = 97
          Top = 0
          Width = 70
          Height = 27
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alRight
          Caption = 'Remove'
          Enabled = False
          TabOrder = 1
          OnClick = Button3Click
        end
      end
      object PageControl1: TPageControl
        AlignWithMargins = True
        Left = 0
        Top = 1
        Width = 167
        Height = 191
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 0
        ActivePage = TabSheetTaskbarList
        Align = alClient
        Style = tsButtons
        TabOrder = 1
        TabWidth = 80
        object TabSheetDeviceList: TTabSheet
          Caption = 'Device List'
          OnShow = TabSheetDeviceListShow
          object ListBox1: TListBox
            Left = 0
            Top = 0
            Width = 159
            Height = 160
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            BorderStyle = bsNone
            ItemHeight = 13
            TabOrder = 0
            OnClick = ListBox1Click
            OnDblClick = ListBox1DblClick
          end
        end
        object TabSheetTaskbarList: TTabSheet
          Caption = 'Taskbar List'
          ImageIndex = 1
          OnShow = TabSheetTaskbarListShow
          object ListBox2: TListBox
            Left = 0
            Top = 0
            Width = 159
            Height = 160
            Align = alClient
            BorderStyle = bsNone
            ItemHeight = 13
            TabOrder = 0
            OnClick = ListBox2Click
            OnDblClick = ListBox2DblClick
          end
        end
      end
    end
    object PageControl2: TPageControl
      AlignWithMargins = True
      Left = 167
      Top = 1
      Width = 387
      Height = 218
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = TabSheetConsole
      Align = alClient
      MultiLine = True
      Style = tsButtons
      TabOrder = 1
      OnChange = PageControl2Change
      object TabSheetConsole: TTabSheet
        Caption = 'Console'
        object Memo1: TMemo
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 369
          Height = 177
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object TabSheetSchedule: TTabSheet
        Caption = 'Schedule'
        ImageIndex = 1
        object Panel5: TPanel
          Left = 0
          Top = 162
          Width = 379
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          ShowCaption = False
          TabOrder = 0
          object Label1: TLabel
            Left = 207
            Top = 10
            Width = 12
            Height = 14
            Caption = ':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ComboBox1: TComboBox
            Left = 1
            Top = 3
            Width = 164
            Height = 21
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            TabOrder = 0
          end
          object Button1: TButton
            Left = 330
            Top = 3
            Width = 50
            Height = 21
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 2
            Caption = 'Add'
            TabOrder = 6
            OnClick = Button1Click
          end
          object ComboBox4: TComboBox
            Left = 280
            Top = 3
            Width = 50
            Height = 21
            Margins.Left = 16
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            TabOrder = 5
            Text = 'ON'
            Items.Strings = (
              'ON'
              'OFF')
          end
          object ComboBox2: TComboBox
            Left = 182
            Top = 3
            Width = 40
            Height = 21
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            AutoDropDown = True
            TabOrder = 1
            Text = '12'
          end
          object UpDown1: TUpDown
            Left = 166
            Top = 3
            Width = 16
            Height = 21
            Margins.Left = 5
            Margins.Right = 15
            AlignButton = udLeft
            Associate = ComboBox2
            Position = 12
            TabOrder = 2
          end
          object UpDown2: TUpDown
            Left = 262
            Top = 3
            Width = 16
            Height = 21
            Margins.Left = 0
            Margins.Right = 0
            Associate = ComboBox3
            DoubleBuffered = False
            ParentDoubleBuffered = False
            TabOrder = 4
          end
          object ComboBox3: TComboBox
            Left = 222
            Top = 3
            Width = 40
            Height = 21
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 0
            AutoDropDown = True
            TabOrder = 3
            Text = '0'
          end
        end
        object GroupBox_Schedule: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 376
          Height = 162
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Caption = ' Schedule list '
          TabOrder = 1
          ExplicitLeft = 16
          ExplicitTop = 32
          ExplicitWidth = 185
          ExplicitHeight = 105
          DesignSize = (
            376
            162)
          object StringGrid1: TStringGrid
            AlignWithMargins = True
            Left = 4
            Top = 17
            Width = 370
            Height = 143
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            TabStop = False
            Anchors = [akLeft, akTop, akRight, akBottom]
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            ColCount = 3
            DefaultColWidth = 40
            FixedCols = 0
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goTabs]
            TabOrder = 0
            OnDblClick = StringGrid1DblClick
            ExplicitWidth = 372
            ExplicitHeight = 145
            ColWidths = (
              224
              81
              62)
            RowHeights = (
              24
              24)
          end
        end
      end
      object TabSheetHotKey: TTabSheet
        Caption = 'HotKeys'
        ImageIndex = 2
        object Panel6: TPanel
          Left = 0
          Top = 162
          Width = 379
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          ShowCaption = False
          TabOrder = 0
          object ButtonAddHotkey: TButton
            Left = 330
            Top = 3
            Width = 50
            Height = 21
            Caption = 'Add'
            TabOrder = 0
            OnClick = ButtonAddHotkeyClick
          end
          object ComboBox7: TComboBox
            Left = 200
            Top = 3
            Width = 70
            Height = 21
            TabOrder = 1
            Text = 'Enable'
            Items.Strings = (
              'Enable'
              'Disable')
          end
          object ComboBox8: TComboBox
            Left = 1
            Top = 3
            Width = 195
            Height = 21
            TabOrder = 2
            Text = 'ComboBox8'
          end
        end
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 185
          Height = 162
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = ' Enable  -  CTRL+ALT+F1-12 '
          TabOrder = 1
          ExplicitTop = 3
          ExplicitHeight = 156
          object ListBox3: TListBox
            AlignWithMargins = True
            Left = 5
            Top = 15
            Width = 175
            Height = 145
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            ItemHeight = 13
            TabOrder = 0
            OnDblClick = ListBox3DblClick
            ExplicitHeight = 139
          end
        end
        object GroupBox2: TGroupBox
          AlignWithMargins = True
          Left = 194
          Top = 0
          Width = 185
          Height = 162
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = ' Disable  -  SHIFT+ALT+F1-12 '
          TabOrder = 2
          ExplicitTop = 3
          ExplicitHeight = 156
          object ListBox4: TListBox
            AlignWithMargins = True
            Left = 5
            Top = 15
            Width = 175
            Height = 145
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            ItemHeight = 13
            TabOrder = 0
            OnDblClick = ListBox4DblClick
            ExplicitHeight = 139
          end
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 219
    Width = 554
    Height = 52
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    Color = clBtnHighlight
    ParentBackground = False
    TabOrder = 1
    object ImageDevices: TImage
      AlignWithMargins = True
      Left = 61
      Top = 0
      Width = 50
      Height = 51
      Margins.Top = 0
      Margins.Bottom = 1
      Align = alLeft
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
        003008060000005702F9870000056E4944415478DAED996D4C1C4518C79FD997
        831E47800FD5A4463950ABF18E00314DDBA8F52E513F98A86DE98726A5011263
        52153DA24621160F6DA85113B0D84862B410A92F496969357E5093BB6A4C314D
        0A7A47A38870D5B426ADA687DC0177FB32CEEEB1CBEEBD2C77722F34E1490A33
        B333B3CFEF99FFCC3C5B10DCE0860AEDC03A40A11D580728B4037907C01E6B39
        47599A10060706544726B0CAED000104781C213C428BE1D3C81908AE2900C971
        9EB23C0F18B948B57C85EE4140B8971143EFE61A242D0039EAC8E24124E2994C
        8EC98AB038E4CC25C48A0072E451E90CAC1CF5541664F05C55AE200C01FE6FE4
        13E6C9E14A1802701EBB1B107A2D2B6FC2B88B75FADD7903C88274E22D27524A
        0910F5D85C08513D090FCC1B81A97A582EF233DF00CC5F336ED7BE0C430BE3F4
        0DE40580F3D48C90A74F68DBA85BB601B5699BAE9F78F9DCD2B3ED09EDE2951F
        F5936238CD3A7D3BF30210F5D80308A14AA5CED8F7016CD81873EECA68CCE978
        98F8F6F9ABC04F7CA2F11F8F9B1CFEFABC0070DE1AACAD2B00F8FA1408535FC6
        1A25D9543F2217F9E9AF55D9D0773E06A8FC7680856BC0FB8FEBE6651DBEACA6
        2F6903C8CEDEDD40BC2B96232D5E1E4D3A4E9599B0188B7EE4DFC200C44B48EE
        5C510DF41D8FCB6561EA0C598D69C8E439C6F82793D3BFAA3B256D80649B5817
        619E44F8D761FD2974175921C66085F2BB89531CA3A0D1B86693AA7B24F83B08
        BF7D91FC65F93C46E58B0C4A03A44759C243A60898FA0372913FDF1B6BDAE28A
        D5C7DE273F224926845906E6AC79BBC824334A255487E30196EA8900794E25E4
        774AC91C58BC6433D7AE0640DABC2C841C794FE6148864524A1B2047D2491B40
        818842C91885286B26005814275914DE5AD00F1AD5996F373FC033A6EF9461C6
        00B13B90E1A33BD04393DF1BCDBBA7B5DD4BF6D983B197E0B327FA0E3B720220
        59D45333403EDA9BD201C0180D9A9CBEE695E6DCF35C877AE3934270F8487745
        CE00C8A9E420D1F2243A9C582767FE2E72E68F68C7EF74B9CB477ADDAA9C0EF5
        0FBE8D28FAC512B359AE87E7E7411484CE83079ADE581EF38A75A4F7CD405600
        6488A51C692500F2F15211AFFD86D60EF9306069F6AB7B6B6DDB5986A94AF68E
        28C7FD71E167BF8F1384FB8883811347BA5366B019031CFB6C12A7D3AF65EF66
        DDDCBB5B3B9A2904C7A4729DED1EB094980DC74BAB31E6BF28974572839FECEB
        1EC83A00CF8B3017E261212240649187B93047DA305C9F8DC0D051876E6E29FA
        0841E5A69B6F82EACADBD476B25BDA80A66252E3C566A4B93827A767E0EADFFF
        186EEE8C015C0747B120C49C4C65961206FADFBA5F37B7A47F5A8878EBEDB65A
        25FA92F36D8D0DBA8BA3E7E361B70221AF826FE22C4F17EDD4EE9D5501343EE3
        9557A0BCCC040C4D41A98585E2621A36907FC545D26F46EE172F21C57A874E2E
        9F3A1CAA686BD9A573ACE7D3535624E01935608DBB0D7DCC18E083A15F30C350
        499F2D10192D2E8A102252EA7CA17E6D02F47D3831CA71786B48D6BB48A41405
        8E8F39AD98C944711FF5EC3069C749126284C8A93ABBCDA14A8824786DFB1BDC
        3A008D8442E179189FB838CE532667D624D47EE8BCEBCFBFC2BAEF049A46B294
        144951207EDEF5F296BDDA3E0DADEDE3525218BF89499B5BA460502A53223411
        281548D9C418C3A5E1BE6E6B560014889212E649B399B1559415A9ED441BB364
        C201A27F57FC984C8FD1A5E8CBE5AC1EA35ADBF7B42748225816731E5F3A7ED4
        6935EA2FAF02809565991FEAEDF61A9389BD3559BF28C7072EF8FCE7788E7B54
        FABBC370DFE194DFD1AB02687CD6E320CB2B47869CF1CD43EF39BD46FDE3D382
        D7FB073A29C47429AB21459DE4202FBDFAD4FE7796C7E8D38FAC0264C3B4C91C
        11FB2CB9B032FABFD8C203E4339D5E8BB60E50685B0728B4DDF000FF016354B6
        4FD5C9A60D0000000049454E44AE426082}
      Transparent = True
      OnClick = ImageDevicesClick
      OnMouseDown = ImageDevicesMouseDown
      OnMouseUp = ImageDevicesMouseUp
    end
    object ImageSettings: TImage
      AlignWithMargins = True
      Left = 5
      Top = 0
      Width = 50
      Height = 51
      Margins.Left = 5
      Margins.Top = 0
      Margins.Bottom = 1
      Align = alLeft
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
        003008060000005702F987000004814944415478DAED59CD531349147F939920
        5F0AF801EC5AABA0078FE05F6052A567F16671D989C59D7090ADDD82722C292D
        C381781675B8A037E319AA0C7F8178DCC3AE51CB5DC8AE4B5C308A99A47D3D43
        3419BA7BBA2365922AFA904A329DD7EFF7FAFDDE573468F2A5D55B817D00F556
        A0610098D65C373885A7A069C3E29D24037A316A5BBF661A0BC0D46C04A53D95
        DA4CE0BA3D73D5DA07B0C7002C94764D12C00202309B17009015FBC664A4C100
        249248E0F18603604ECFC6F1C0218C1CD77991C3B46E0D405147FFD70624CFCD
        A11B5D42374AB3E5D188E68CA376DDF68DAB133503D84D4C6203D116CA07BB07
        150B7328C6ACC97C04D26038B1B261760C71CD276F0241246B0580711D22CC83
        81A4D0652CFCD45D93F25F17BD0D743F32C031440E7463D0B626724A00CCE904
        0AD31EA868E2143EC1C7F75BB0FD210F45C781C2A76DF7FB70CB01D4C180036D
        EDD0DAD10946B8450DA2206A310178AEE1BC90B56EA95884776FB390DFFC5F4A
        9FF68387A0EB482F84745D1E44919CB56F4EAECA015008891FB63661E39F3520
        A5929251B550087A8EF5435BE741B91FA0DBE22D4403017844325EC8C8CC6FE6
        6023BBAEA4B87FF5F4F6E18DC8D288C430FCDA62005389C748CE912051D4F2FF
        ADFFF54DCA97D7E1BE1F656F6217A1AB0098BF258641D79E0549A13EBFF6EA4F
        65B7E12DEA4EFD274EC972A22AAC5603F0C89BC6B74322091BEB7F437E4B8EB0
        B2ABBDF310F4F4FD20DE44C83B2841A492CCCA24A6A172FD95982204E0091E94
        5C7E344F8D01E72F8F452004713CECA2E8777D2706052196AC801E1EF1E7037E
        1EA05918C0C61D272BBFDFCA6DB82193BF4AB1A5C5FB36EBC985D12B2640889B
        5B0484E666637126F65C8A2AF3C5726FD7DEB8C98A67F9E5C5796100383F3A96
        E2DD044D7247FA8F577EF51CE3BFC98AFF52005C106E310773E5CFD9D7992F19
        7617801244CB6EC30580EEA485D88D0FCDD8BD3F0D544A0CAC5A8301F8F8F0E6
        8FDFB97B9716E7A5CAF30BA36384F7ECF8E933FB00AA0134B30BED8C4A1E5466
        66218909492D3FBC7749084085C484AC62388ED5446273EAF608A6481AF2AAE2
        5A1DC228C67D32E1AF81B80082BA2CA9448637A14128B9F4F0EE8A6B759AC834
        32AE05D4580189CC4610312100D9DEB68EA5C42A228CF28B39C92ECC2DE65E62
        3147F6A8984356F79F942CE67C8D0DA39C9ECDF8CB07D6AA5339FD044B8A2A37
        640070C9FB5846DA776F687467D03FDA6157A3D389343E3A2723D36D29B36BCA
        EE44DDA6A757A9A564CE53394DBD7C5B4997DBD4FF9B952636256CD75185A69E
        C04B308C61D668459007544685DEF2C62AEF61FB631E2371A17AAC120E435B47
        07B4B4B6AB8F5518BD7030002F0B23A1B52E864516F035836FE2CCE74ABA6197
        E50EC8C808DB6DC5E584B894A8AC83E841A0A5C0702CDF28D096E50BD3108611
        2FBBC64E1365A2563F57EC89F266A881003CA1E84AA0E5F0A0246FBCE71DEC8E
        1AE56EC3F56927221C163B8685EC4AD933BFA444A2F66EBCAE10B9F036EFD833
        93F1BD38B74E001AF32F26BBCA779B1080CA7F644262EE03A809801739D21285
        E073D08D082FA2D50D40BD56D303F80C18A5614F33A77D1C0000000049454E44
        AE426082}
      Transparent = True
      OnClick = ImageSettingsClick
      OnMouseDown = ImageSettingsMouseDown
      OnMouseUp = ImageSettingsMouseUp
      ExplicitHeight = 52
    end
    object ImageEnable: TImage
      AlignWithMargins = True
      Left = 451
      Top = 0
      Width = 50
      Height = 51
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Center = True
      Enabled = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000320000
        003208060000001E3F88B1000002FE4944415478DAED998D55DB3010C78F09CA
        06B813102668320130016102E8047527289D0033013041CC0484096236A01350
        FD9FEE6AE126B64E9604E1E5DEBB9717B025FDA4FB54F6E893C85E86391EF9F3
        68DB415E73CCB503D9816C31C8923F271F01A434FACDE8A9D1970CF0907DA3B7
        461F78FE282077468FC9EEEE2C030C2016644F1120D3582018B8367AE8013361
        E829BF2726B5E47730CE3DB526D707F1C4E30C6E9CC647BA30DD047746D6040A
        CFF11AA3DFC99EB62B8F5A082D880B43D4EE34167E4DEDF13FF3E26A5EACEBEC
        053F7762F480FF8EE7CEF959017CD140848074058B5B3020004AA395E7BB737E
        FE80173CA3CDE6961404105247DDF3C2B441609FC18FF9FB51284C2848C11058
        C80D438C11C09CF14600A6C90502739A923D899391102212E26BB266961C644E
        D6B9E11330AF583905A70BB382CF9CD2FFD12C3AC88AAC6921D2549120BA9BD4
        18FD9A12441CFC99FCF385560081535139BE16A434FAC3E86FA3978940AE8C5E
        18FD491E355628484D6DF1A8B26185207848B1384D0522E54370BCF71031DF75
        6590378838B22BEE80599AA435F30CADEBCD8210FE1AA35F3A2F3C515B57BD07
        88CFBAD40BC22E1C521ED34AEA233559679F515B05C7162C7E911AA4225B13A1
        8FB84A0482B0FE8B94355C6842544514A54864549D7A88D33664336F0AF30AAE
        1C42404AB2D9BDA6802A7540A4AA5665F55010B74A8DE92B92D183AAEAD07C20
        938E6E5159DC9639A8FC1993D82AB2116CEC5D977BFD13DC6D8ECDD092204361
        82EEB06280C8C46252EE5D5745B6D9D2089AA839BDF58B95337E92EBA04DD798
        1386412DA48936780ED1EF0F8F257E1674CA9A2BD33E1370AF86D0A23603E315
        64771ED2ADDB34D7B36A1089EF7D762C3BECE3B015D940B1E9045D989A3CF295
        E636BEA07E67C4FF577EC3FD93BED31398A5C7C644EF2B5E95CF479B3F15C8D0
        B8D11BB41DC8C002A5CC5FD76B27993F1588F4D30DB5BF836C1508221A12635F
        4F9FE4B6323648493697F888BAE7C809223073DA6C5238892A26442A1057D074
        C9EF27D1179F13249B7C1A90BFE977D73315C40EC00000000049454E44AE4260
        82}
      Transparent = True
      OnClick = ImageEnableClick
      OnMouseDown = ImageEnableMouseDown
      OnMouseUp = ImageEnableMouseUp
      ExplicitLeft = 387
      ExplicitTop = 2
      ExplicitHeight = 50
    end
    object ImageTemp: TImage
      AlignWithMargins = True
      Left = 117
      Top = 0
      Width = 50
      Height = 51
      Margins.Top = 0
      Margins.Bottom = 1
      Align = alLeft
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
        003008060000005702F987000003C14944415478DAED98CD4F134114C0676621
        F2516C09462FC64F54C018A81125C68402176F968F180D1ACB5DB410A3C841EA
        05483CF065BC5203F1221FFD0780EDC18316A5A2C1C6105B41C08644CA37053A
        E30C65A1D4B6B6D0EDD2A4EFB23B93F776DF6FE6BD376F1782281728B5033100
        A91D880148ED40440086AC560570AED75175B5DB0AEA95E74E3F97DAF9E0012C
        A3CDF4F2D06BBA459991AE8D0A804F96510755947B4DDB28C0C9A800A03B407C
        CD5300C973286400E3E0F0D6BCF64E490C20E2009E12952114F500E10AA1D2CA
        A7660861B630C60454F4B4D5EBA306A0EC41ED8E5DA58396EED6FA90CF154942
        A8EC7E8D4A2E970FC80FA66C8C579C4E303FBFF0BEE3455DDEBE0328A9ACD570
        1C30BF6DAE37B3715347B78E10F2182194E8439D2710565595179BD5DA9A131C
        86F92E448C86E646DB9E00168A2E6F010C4FCC6DCD5FB55802DA3327E230B2B2
        7B8EE3C6B2B332505262E2D1403618E365EBF8F8F4947DFA181B13405E77B736
        682401A0716EA0971BEC3EF34C3A484B5504F3BA0D19FA3A02169796DC4E22A0
        147670CF009E22EBFBE0D79EC539406880DD1F3E9406CE9EDA6E9BE8AACED28B
        8E7AC6B37069EAE855D1591D84205FD0617931F8F9CBA601E1BBDA1A0A220AA0
        D6EA149CCBC9B35299733E0BC89293B601205432C7BD6D9A3A7B0C7073C7988C
        7C1F057F66666631805A7F2556E41CD02912107E957731E7F696F304B454DD2D
        F1592E9BDA7B15309ECC08E3C9DFF655EBAFF12BFEC24774800DA76878404806
        B6579F54549597EAFDEA7776DB2080C7D93D769177D5F74AAF057ABE6821140E
        80F5F5F58F8F34372F490A70ABFAD99B5D8790DDEEFC61FD79BDEB65231F3680
        604388C57F9CCBD94BBF9F557B4A628723609F241A40C0324AC82C02A80E2360
        04ABC0C61D20D918D3B20A804AD0F12AA3465A4655BEDE236A0845F541C6C4B3
        95884368EE4256E6727252E29140362EEC5A199B98FC36316557B271D85B8950
        0098B0660E116C131291357398E0271CE212BC7569821B01825A7733A75320D7
        AA1A7398DF75334754398A452EBE97AAA9FC68F0C9AEB562C89B1DC12C842011
        6BA7E70B73592B901FF8118497F5990A408822FA07CD4261AE8696C0F6A09E42
        4885ACDFA40FE5C5A27F5206B7FA82FFC498D26F5285FAF270887F80A25C073D
        D2377F27927F5569C6D11D12001C142075FF02F8F0DF738EF5F7297DA6E08B7C
        4400BC4388909D661E96FB3284C44E62D101980493C852AEFE7F01D841B680E2
        0DFE2098F332BCA60EF5208B1880202C9C6806D09002396ECF81991AEAA50A9B
        9001F6B3C400A4961880D412F5007F0104E22B4FB40CB52F0000000049454E44
        AE426082}
      Transparent = True
      OnClick = ImageTempClick
      OnMouseDown = ImageTempMouseDown
      OnMouseUp = ImageTempMouseUp
    end
    object ImageDisable: TImage
      AlignWithMargins = True
      Left = 501
      Top = 0
      Width = 50
      Height = 51
      Margins.Left = 0
      Margins.Top = 0
      Margins.Bottom = 1
      Align = alRight
      Center = True
      Enabled = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000320000
        003208060000001E3F88B1000002D34944415478DAED99816DDB3010457F2648
        36A83B419C096A6F904E5067823813549DA0EE045527683A819509DC4E106503
        6782941F3CC28441CA2445CA42AB0F10B19D9375EFC8BB23E50BFC23BA38B703
        13C80432724D2063D3043236950099ABF149FE5EC95FEAB71A7B351A357EC9FB
        5182D0F94A8D59A07D2BF63FC60242C7BFABB190F72F6A3C42479ECE9AC8CFC5
        9676B76ABC93CF697727B66703A1533FA19710012A35EAC06B57624F202EB98F
        0235380821B6F29ACB632D0EC58801D8402F4BEA0689B9930A325363278E1062
        D52320542D307B81698702E14C2C32411CC3346A2C8700A1E34C6EE604133876
        39F9C4D9E5B262CEDC213CD792419EA19796EB66FC9C51FDD6014887EF3D3626
        48AD1AEF4B827006981B2F70F78B4A8DCFD0915D3A1C25C456BEE78BD81F8B10
        9C95A8C48F05D958D15C3BFE4F471B35AE1D3036C41FE81CDB77DCC3079A0584
        4E7E80AEF98F1E1B170C022128364BF6A6271C9A6C76909D38736ADA8F611008
        61EC7672DD4D2990B788EB6C180442A4DC671010B39C285F01380B089D618443
        96969D1380BB00B8649656D11C69A0937D09FF06CF559DCCB521300BB9BE2848
        0DDDF01EA0CB6408845D7E436058D6BF2272FB93DA105BB83B6F05DD107D896D
        C3F8FA84A98C5DB3DE1B0438745ED78DE82823BA41F716C567736AE79015A482
        8E7A83845DEA09995D7554574F05B177A9BE5C4991E9E849BBEAD4F388B9296F
        B644FF2722747C2B41EADAFE6407A16AE80A16D3E85CB22B5DF241ADEFC307D3
        2053614277C4C541EC725A431FB662C443D40A194E9B399E6BCD05E61271D586
        76AC7EAFD033D12BCF723D6934F59F62A36C4FD8CFA08FCC5454E32B0D4255D0
        110E49D81A87B3FD1A199413648643944315327B8383506F91F6D9EE3F81FC2F
        20FC5E53C95CA7C9E8A3EC04922876E6CB405B36C2ABB18298A78421CAD6434A
        8030C2157443F4CD0C67A216BB5C4FF28BFF3CCD19BA95D7C6F9229A7E671F9B
        FE02C0ABCD33D456966E0000000049454E44AE426082}
      Transparent = True
      OnClick = ImageDisableClick
      OnMouseDown = ImageDisableMouseDown
      OnMouseUp = ImageDisableMouseUp
      ExplicitLeft = 427
      ExplicitTop = 1
      ExplicitHeight = 50
    end
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 40
    Top = 82
  end
  object PopupMenu1: TPopupMenu
    Left = 112
    Top = 138
  end
  object RESTClient1: TRESTClient
    Authenticator = OAuth1Authenticator1
    Params = <>
    HandleRedirects = True
    Left = 176
    Top = 224
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    Timeout = 3000
    SynchronizedEvents = False
    Left = 400
    Top = 224
  end
  object RESTResponse1: TRESTResponse
    Left = 328
    Top = 224
  end
  object OAuth1Authenticator1: TOAuth1Authenticator
    OnAuthenticate = OAuth1Authenticator1Authenticate
    Left = 248
    Top = 224
  end
  object NotificationCenter1: TNotificationCenter
    Left = 40
    Top = 136
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 116
    Top = 84
  end
end
