program Frazadas;
const
	dimF=300;
type
	oficina=record
		cod:integer;
		dni:integer;
		valor:real;
	end;
	vector=array[1..dimF]of oficina;
procedure Leer(var o:oficina);
begin
	with o do begin
		writeln('Ingrese un codigo: ');
		readln(cod);
		if(cod<>-1)then begin
			writeln('Ingrese un dni: ');
			readln(dni);
			writeln('Ingrese un valor: ');
			readln(valor);
		end;
	end;
end;
procedure CargarVector(var v:vector;var dimL:integer);
var
	o:oficina;
begin
	Leer(o);
	while(dimL<dimF) and (o.cod<>-1)do begin
		dimL:=dimL+1;
		v[dimL]:=o;
		Leer(o);
	end;
end;
procedure ImprInf(o:oficina);
begin
	writeln('El codigo es : ', o.cod);
	writeln('El dni es : ', o.dni);
	writeln('El valor es : ',o.valor:0:2);
end;
procedure Imprimir(v:vector;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		ImprInf(v[i]);
end;
procedure Insercion(var v:vector;dimL:integer);
var
	i,j:integer;
	act:oficina;
begin
	for i:=2 to dimL do begin
		act:=v[i];
		j:=i-1;
		while(j>0)and(v[j].cod > act.cod)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=act;
	end;
end;
procedure Seleccion(var v:vector;dimL:integer);
var
	i,j,pos:integer;
	item:oficina;
begin
	for i:=1 to dimL do begin
		pos:=i;
		for j:=i+1 to dimL do begin
			if(v[j].cod<v[pos].cod)then
				pos:=j;
		end;
		item:=v[pos];
		v[pos]:=v[i];
		v[i]:=item;
	end;
end;

var
	v:vector;
	dimL:integer;
begin
	dimL:=0;
	CargarVector(v,dimL);
	Seleccion(v,dimL);
	Imprimir(v,dimL);
end.
