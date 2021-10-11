unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListBox1: TListBox;
    SpeedButton3: TSpeedButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton4: TSpeedButton;
    Edit1: TEdit;
    SpeedButton5: TSpeedButton;
    Edit2: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButton6: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  const
  maxcount=900;
  var
  Form1: TForm1;
  put,d,dv:array[1..maxcount] of integer;
  rnd_max,n:integer;

  implementation

{$R *.dfm}

function yarus(n:integer):integer; // ������ ����� n-��� ��������
var
delta:integer;
begin
delta:=0;
repeat
inc(delta);
n:=n-delta;
until n<=0;
yarus:=delta;
end;

function TopLeft(n:integer):integer;
begin
TopLeft:=n-yarus(n);
end;

function TopRight(n:integer):integer;
begin
TopRight:=n-(yarus(n)-1);
end;


procedure TForm1.SpeedButton1Click(Sender: TObject); // ������ �� �����
var
f:textfile;
i,item:integer;
begin
assignfile(f,extractfilepath(application.exename)+'\inn.krs');
reset(f);
i:=1;
while not eof(f)do
begin
while not eoln(f) do
begin
read(f,item);
d[i]:=item;
i:=i+1;
end;
readln(f);
end;
closefile(f);
n:=i-1;
label2.Caption:=inttostr(n);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject); {!!! ���������� !!!}
var
 i,tl,tr,ves,min,imin,ya,a:integer;
begin
 for i:= 1 to n do
  dv[i]:=0;

 dv[1]:=d[1];
 for a:= 1 to n-yarus(n) do     {�� ���������� �� ������������� �����}
begin
ya:=yarus(a);                   {���� ����� � ������ ������ ���� ��� = 0 }
if (dv[a+ya]>d[a+ya]+dv[a]) or (dv[a+ya]=0) then
dv[a+ya]:=d[a+ya]+dv[a];        {������� �� �� �����}

                                {���� ������ � ������ ������ ���� ��� = 0 }
if (dv[a+ya+1]>d[a+ya+1]+dv[a]) or (dv[a+ya+1]=0) then
dv[a+ya+1]:=d[a+ya+1]+dv[a];    {������� �� �� �����}
end;

{������ ��������, ������ ��������� ��� i-��� ������� ����������� ������
� i-��� �������� . ����� �������� ������.}

min:=30000; imin:=1;        {������� �� ���� ������� ������ ������� �����}
ya:=yarus(n);             {�����������. ��� ����� ������� �������� �����������}
for a:=n-ya+1 to n  do    {���� � �������� �� ������ ����}
if min>dv[a] then
begin
min:=dv[a];
imin:=a;
end;

{showmessage(inttostr(imin)+'  -  '+inttostr(min));}

listbox1.Clear;
ves:=min;
i:=1;
listbox1.items.Add(inttostr(imin));
put[i]:=imin;

{������ ���������� �����������. �� �� ����� ����� ��� ��������.
������ �� ������ ��� ����. ������� ��� � ������ PUT. }

repeat                      {�������� ��� �������}
tl:=topleft(imin);          {������ ������� ����� �������, �� ������� �� �����
                             ���� ����� ������� �������� ����. � ���������
                             �� ����� �� ���� �������� ������� � ������� �� ������
                             ���� �������� ������� ����� �������}
if (ves=d[imin]+dv[tl]) and (yarus(imin)-yarus(tl)=1) then
begin
listbox1.items.Add(inttostr(tl));
imin:=tl; ves:=dv[tl];   {�������� �� ���� ����, ������� ������� = �� �������}
inc(i);put[i]:=imin;     {������� ���� � ������ PUT}
end;
                             {���������� ������� ������.}
tr:=topright(imin);
if (ves=d[imin]+dv[tr]) and (yarus(imin)-yarus(tr)=1) then
begin
listbox1.items.Add(inttostr(tr));
imin:=tr; ves:=dv[tr];
inc(i);put[i]:=imin;
end;
until ves=d[1];

label4.Caption:=inttostr(min);
label6.Caption:=inttostr(yarus(n));
end;

procedure TForm1.SpeedButton3Click(Sender: TObject); {!!! ����� !!!}
var
vy,vx:array[1..maxcount] of integer;
redi,nd,i,j,ya,dx,dy:integer;
pdx:real;
begin
with image1.Canvas do
begin
brush.color:= clwhite;    {������� Image1, � ������� �� ���� ����� ���}
pen.Color:=clwhite;
Rectangle(0,0,image1.Width,image1.Height);
ya:=yarus(n);
nd:=1;
dy:=round(image1.height/(ya+1));    {��������� ������� ���������}
for i:= 1 to ya do
begin
dx:= round(image1.Width/(i+1));
font.Name:='MS Serif';
              {   !!!!   �����   ����������   �������   !!!!   }
{��� ���������� , �������� 0.4 , ����� ����� �� ������� 0.4 �� 20 , �� �������
8 �������� ����������� �� ������� ! ���� ������ ������ , ������� �����������
���������� ...}
pdx:=(image1.Width/(i+1))-round(image1.Width/(i+1));
for j:= 1 to  i do
begin                       { .... �������� �� �� ����� ������� �� X , }
vx[nd]:=dx*j+round(pdx*j)-10;  {� ���������� �� � X-���� ���������� ������� :)) }
vy[nd]:=dy*i-10;               {� Y - �� ���� �� ���� ���, � ����������� �����}
inc(nd);                    {�������� ���� ���, ��� ��� �� �� ����� �����}
end;
end;

brush.color:= cllime;        {������� - ����������...}
pen.Color:=clblue;           {� ����� - ���������...}
font.Size:=9;
for i:= 1 to n-yarus(n) do          {������ ��� ��������� ����}
begin
moveto(vx[i]+10,vy[i]+7);
lineto(vx[i+yarus(i)]+10,vy[i+yarus(i)]+7);
moveto(vx[i]+10,vy[i]+7);
lineto(vx[i+yarus(i)+1]+10,vy[i+yarus(i)+1]+7);
end;

pen.Width:=2;          {������ ������� ����}
pen.Color:=clred;      {�����������....}
rectangle(vx[1]+1,vy[1],vx[1]+20,vy[1]+14);
for i:= 1 to yarus(n)-1 do
begin
rectangle(vx[put[i]]+1,vy[put[i]],vx[put[i]]+20,vy[put[i]]+14);
moveto(vx[put[i]]+10,vy[put[i]]+7);
lineto(vx[put[i+1]]+10,vy[put[i+1]]+7);
end;

pen.Width:=1;             {������ �������}
pen.Color:=clblue;        {���������....}
for i:=1 to n do
begin
pen.Color:=clblue;
rectangle(vx[i]+1,vy[i],vx[i]+19,vy[i]+13);
if d[i]<10 then
textout(vx[i]+7,vy[i]+1,inttostr(d[i]));
if (d[i]>=10) and (d[i]<=99) then
textout(vx[i]+5,vy[i]+1,inttostr(d[i]));
if d[i]>99 then
textout(vx[i]+2,vy[i]+1,inttostr(d[i]));
end;


end;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);  {!!! ������ � ��������� � ���� !!!}
var
i,j:integer;
f:textfile;
begin
randomize;
assignfile(f,extractfilepath(application.exename)+'\inn.krs');
rewrite(f);
rnd_max:=strtoint(edit2.Text);
for i:= 1 to strtoint(edit1.text) do
begin
for j:= 1 to i do
begin
if j<> i then
write(f,inttostr(random(rnd_max)+1)+' ')
else
write(f,inttostr(random(rnd_max)+1))
end;
if i<> strtoint(edit1.Text) then
writeln(f);
end;
closefile(f);
 SpeedButton5.Click;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
 Speedbutton1.Click;
 Speedbutton2.Click;
 Speedbutton3.Click;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
close;
end;

end.

