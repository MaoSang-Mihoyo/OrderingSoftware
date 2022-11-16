VERSION 5.00
Begin VB.Form frmTip 
   Caption         =   "���������"
   ClientHeight    =   3285
   ClientLeft      =   2370
   ClientTop       =   2400
   ClientWidth     =   5685
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3285
   ScaleWidth      =   5685
   WhatsThisButton =   -1  'True
   WhatsThisHelp   =   -1  'True
   Begin VB.CheckBox chkLoadTipsAtStartup 
      Caption         =   "������ʱ��ʾ��ʾ(&S)"
      Height          =   315
      Left            =   120
      TabIndex        =   3
      Top             =   2940
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.CommandButton cmdNextTip 
      Caption         =   "��һ����ʾ(&N)"
      Height          =   375
      Left            =   4080
      TabIndex        =   2
      Top             =   600
      Width           =   1455
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00FFFFFF&
      Height          =   2715
      Left            =   120
      Picture         =   "frmTip.frx":0000
      ScaleHeight     =   2655
      ScaleWidth      =   3675
      TabIndex        =   1
      Top             =   120
      Width           =   3735
      Begin VB.Label Label1 
         BackColor       =   &H00FFFFFF&
         Caption         =   "��֪����..."
         Height          =   255
         Left            =   540
         TabIndex        =   5
         Top             =   180
         Width           =   2655
      End
      Begin VB.Label lblTipText 
         BackColor       =   &H00FFFFFF&
         Height          =   1635
         Left            =   180
         TabIndex        =   4
         Top             =   840
         Width           =   3255
      End
   End
   Begin VB.CommandButton cmdOK 
      Cancel          =   -1  'True
      Caption         =   "ȷ��"
      Default         =   -1  'True
      Height          =   375
      Left            =   4080
      TabIndex        =   0
      Top             =   120
      Width           =   1455
   End
End
Attribute VB_Name = "frmTip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' �ڴ��е���ʾ���ݿ⡣
Dim Tips As New Collection

' ��ʾ�ļ�����
Const TIP_FILE = "RandList.TXT"

' ��ǰ������ʾ����ʾ���ϵ�������
Dim CurrentTip As Long


Private Sub DoNextTip()

    ' ���ѡ��һ����ʾ��
    CurrentTip = Int((Tips.Count * Rnd) + 1)
    
    ' ���ߣ������԰�˳�������ʾ

'    CurrentTip = CurrentTip + 1
'    If Tips.Count < CurrentTip Then
'        CurrentTip = 1
'    End If
    
    ' ��ʾ����
    frmTip.DisplayCurrentTip
    
End Sub

Function LoadTips(sFile As String) As Boolean
    Dim NextTip As String   ' ���ļ��ж�����ÿ����ʾ��
    Dim InFile As Integer   ' �ļ�����������
    
    ' ������һ�������ļ���������
    InFile = FreeFile
    
    ' ȷ��Ϊָ���ļ���
    If sFile = "" Then
        LoadTips = False
        Exit Function
    End If
    
    ' �ڴ�ǰȷ���ļ����ڡ�
    If Dir(sFile) = "" Then
        LoadTips = False
        Exit Function
    End If
    
    ' ���ı��ļ��ж�ȡ���ϡ�
    Open sFile For Input As InFile
    While Not EOF(InFile)
        Line Input #InFile, NextTip
        Tips.Add NextTip
    Wend
    Close InFile

    ' �����ʾһ����ʾ��
    DoNextTip
    
    LoadTips = True
    
End Function

Private Sub chkLoadTipsAtStartup_Click()
    ' �������´�����ʱ�Ƿ���ʾ�˴���
    SaveSetting App.EXEName, "Options", "������ʱ��ʾ��ʾ", chkLoadTipsAtStartup.Value
End Sub

Private Sub cmdNextTip_Click()
    DoNextTip
End Sub

Private Sub cmdOK_Click()
    'Unload Me
End Sub

Private Sub Form_Load()
    Dim ShowAtStartup As Long
    
    ' �쿴������ʱ�Ƿ񽫱���ʾ
    ShowAtStartup = GetSetting(App.EXEName, "Options", "������ʱ��ʾ��ʾ", 1)
    If ShowAtStartup = 0 Then
        Unload Me
        Exit Sub
    End If
        
    ' ���ø�ѡ��ǿ�н�ֵд�ص�ע���
    Me.chkLoadTipsAtStartup.Value = vbChecked
    
    ' ���Ѱ��
    Randomize
    
    ' ��ȡ��ʾ�ļ����������ʾһ����ʾ��
    If LoadTips(App.Path & "\" & TIP_FILE) = False Then
        lblTipText.Caption = "�ļ� " & TIP_FILE & " û�б��ҵ���? " & vbCrLf & vbCrLf & _
           "�����ı��ļ���Ϊ " & TIP_FILE & " ʹ�ü��±�ÿ��дһ����ʾ�� " & _
           "Ȼ���������Ӧ�ó������ڵ�Ŀ¼ "
    End If

    
End Sub

Public Sub DisplayCurrentTip()
    If Tips.Count > 0 Then
        lblTipText.Caption = Tips.Item(CurrentTip)
    End If
End Sub