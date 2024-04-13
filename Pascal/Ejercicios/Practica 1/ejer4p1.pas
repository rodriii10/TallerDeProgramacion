Program Perfume;
const
	dimF=30;
type
	rubros=1..8;
	producto = record
		codprod:integer;
		codrubro:integer;
		precio:real;
	end;
	lista=^nodo;
	nodo=record
		dato:producto;
		sig:lista;
	end;
	vlistas=array[rubros]of lista;
	vtres=array[1..dimF]of producto;
procedure Leer(var pr:producto);
begin
	with pr do begin
		writeln('Ingrese un precio: ');
		readln(precio);
		if(precio <> 0)then begin
			writeln('Ingrese codigo de producto : ');
			readln(codprod);
			writeln('Ingrese codigo de rubro: ');
			readln(codrubro);
		end;
	end;
end;
procedure InsertarOrdenado(var l:lista;p:producto);
var
	nue,act,ant:lista;
begin
	new(nue);
	nue^.dato:=p;
	act:=l;
	ant:=l;
	while(act<>nil) and (p.codprod > act^.dato.codprod)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant)then
		l:=nue
	else
		ant^.sig:= nue;
	nue^.sig:=act;
end;
procedure InicializarVector(var v:vlistas);
var
	i:integer;
begin
	for i:=1 to 8 do
		v[i]:=nil;
end;
procedure CargarVector(var v:vlistas);
var
	p:producto;
begin
	Leer(p);
	while(p.precio<>0)do begin
		AgregarAdelante(v[p.codrubro],p);
		Leer(p);
	end;
end;
procedure ImprimirListas(v:vlistas);
var
	i:integer;
begin
	for i:=1 to 8 do begin
		while(v[i]<>nil)do begin
			writeln(v[i]^.dato.codprod);
			v[i]:=v[i]^.sig;
		end;
	writeln('Fin del rubro :',i);
	end;
end;
procedure VectorRubro3(var v2:vtres;v:vlistas;var dimL:integer);
begin
	while(v[3]<>nil) and (dimL<dimF) do begin
		dimL:=dimL+1;
		v2[dimL]:=v[3]^.dato;
		v[3]:=v[3]^.sig;
	end;
end;
procedure Insercion(var v:vtres;dimL:integer);
var
	i,j:integer;
	act:producto;
begin
	for i:= 2 to dimL do begin
		act:=v[i];
		j:=i-1;
		while(j>0) and (v[j].precio > act.precio)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=act;
	end;
end;
procedure Precios (v:vtres;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		writeln('Precio del codigo: ',v[i].codprod, 'es : ',v[i].precio:0:2);
end;
function Promedio(v:vtres;dimL:integer):real;
var
	i:integer;
	preciosTotal:real;
begin
	preciosTotal:=0;
	for i:= 1 to dimL do
		preciosTotal:=preciosTotal + v[i].precio;
	promedio:=(preciosTotal/dimL);
end;
var
	v2:vtres;
	v:vlistas;
	dimL:integer;
begin
	InicializarVector(v);
	CargarVector(v);
	dimL:=0;
	ImprimirListas(v);
	VectorRubro3(v2,v,dimL);
	Insercion(v2,dimL);
	Precios(v2,dimL);
	writeln('El promedio de precios del rubro 3 es : ',Promedio(v2,dimL):0:2);
end.
