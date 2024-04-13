program dllm220;
const
	dimF=20;
type 
	vector=array[1..dimF]of integer;
procedure CargarVector(var v:vector;var dimL:integer);
var
	n:integer;
begin
	n:=abs(random(100));
	if(dimL<dimF)then begin
		dimL:=dimL+1;
		v[dimL]:=n;
		CargarVector(v,dimL);
	end;
end;
procedure Maximo(v:vector;dimF:integer;var max:integer);
begin
	if(dimF > 0)then begin
		if(v[dimF]>max)then
			max:=v[dimF];
		Maximo(v,dimF-1,max);
	end;
end;

procedure Imprimir(v:vector);
var
	i:integer;
begin
	for i:=1 to dimF do
		writeln('Numero : ',v[i]);
end;
procedure Insercion(var v:vector;dimL:integer);
var
	i,j:integer;
	act:integer;
begin
	for i:= 2 to dimL do begin
		act:=v[i];
		j:=i-1;
		while(j>0) and (v[j]>act)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=act;
	end;
end;
procedure BusquedaDictomica(v:vector;ini,fin:integer;num:integer;var pos:integer);
var
	medio:integer;
begin
	pos:=-1;
	medio:=(ini+fin)div 2;
	while(ini<=fin)and(num <> v[medio])do begin
		if(num < v[medio])then
			fin:=medio-1
		else
			ini:=medio+1;
		medio:=(ini+fin)div 2;
		end;
	if(ini<=fin)and(num=v[medio])then
		pos:=medio;
end;
			
function Suma(v:vector;dimF:integer):integer;
begin
	if(dimF > 0)then
		Suma:=v[dimF]+Suma(v,dimF-1)
	else
		Suma:=0;
end;
var
	v:vector;
	dimL:integer;
	num:integer;
	pos:integer;
begin
	pos:=-1;
	dimL:=0;
	CargarVector(v,dimL);
	Insercion(v,dimF);
	Imprimir(v);
	writeln('Ingrese un numero a buscar');
	readln(num);
	BusquedaDictomica(v,1,dimL,num,pos);
	if(pos<>-1)then
		writeln('El numero esta en la posicion: ',pos)
	else
		writeln('El numero no se escontro en el vector');
end.
