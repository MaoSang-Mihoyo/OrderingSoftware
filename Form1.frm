VERSION 5.00
Begin VB.Form FormOrder 
   Caption         =   "Form1"
   ClientHeight    =   3015
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   3015
   ScaleWidth      =   4560
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   375
      Left            =   2760
      TabIndex        =   2
      Top             =   1080
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   375
      Left            =   2760
      TabIndex        =   1
      Top             =   480
      Width           =   1335
   End
   Begin VB.Timer Timer1 
      Left            =   960
      Top             =   1920
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   2175
   End
End
Attribute VB_Name = "FormOrder"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

    Dim Temp As String
    Dim NameTxt(5000) As String     '�洢�ӡ�DefList.txt�������ж�ȡ������,�������5000����¼�����Ϊ��������֡�
    Dim i As Long
    Dim Lc As Long      'DefList.txt�еļ�¼����(�ı�����)
    Dim x As Long       ' �洢�����
    
Private Sub Command1_Click()
    i = 0
    Lc = 0
    x = 999999
    Open App.Path & "\DefList.txt " For Input As #1    '��һ����Deflist.txt�����м�����¼��"
    Do While Not EOF(1)
        Line Input #1, Temp
        Lc = Lc + 1
        NameTxt(Lc) = Temp      '�Ѽ�¼д�����顣
    Loop
    Close #1
    If Timer1.Enabled = False Then      '���ƶ�ʱ����
        Timer1.Enabled = True
    Else
        Timer1.Enabled = False
    End If
    Command2.Enabled = True
    Command1.Enabled = False
End Sub

Private Sub Command2_Click()
    Randomize       '������¼�������ڵ������x
    x = Int((Lc - 1 + 1) * Rnd + 1)
    Command2.Enabled = False
End Sub

Private Sub Form_Load()
    Timer1.Interval = 100    '�ı�����100���Ե��������ٶȡ�
    Timer1.Enabled = False
    Command2.Enabled = False
    Me.Caption = "�������"
    Command1.Caption = "��ʼ����"
    Command2.Caption = "ͣ"
    Label1.Caption = "������׼����"
End Sub

Private Sub Timer1_Timer()
    i = i + 1
    Label1.Caption = i & "  " & NameTxt(i)  '��ʾ��¼
    If i = x Then       '�����������x������¼ʱֹͣ
        i = 0
        Command1.Enabled = True
        Timer1.Enabled = False
    Else
        If i = Lc Then i = 0
    End If
End Sub

