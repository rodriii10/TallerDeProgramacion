program Salud;
const
	dimF=10;
type
	vector=array[1..10]of char;
	lista=^nodo;
	nodo=record
		dato:char;
		sig:lista;
	end;
	
procedure CargarVectorR(var v:vector;var dimL:integer);
var
	c:char;
begin
	readln(c);
	if(dimL < dimF)and(c <> '.')then begin
		dimL:=dimL+1;
		v[dimL]:=c;
		CargarVectorR(v,dimL);
	end;
end;
procedure Imprimir(v:vector;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		writeln(v[i]);
end;
procedure ImprRec(v:vector;dimL:integer);
begin
	if(dimL > 0)then begin
		writeln(v[dimL]);
		dimL:=dimL-1;
		ImprRec(v,dimL);
	end;
end;
procedure ContarChar(var cant:integer);
var
	c:char;
begin
	readln(c);
	if(c<>'.')then begin
		cant:=cant+1;
		ContarChar(cant);
	end;
end;
procedure AgregarAdelante(var l:lista;c:char);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=c;
	nue^.sig:=l;
	l:=nue;
end;
procedure CargarLista(var l:lista);
var
	c:char;
begin
	writeln('Ingrese un char');
	readln(c);
	if(c<>'.')then begin
		AgregarAdelante(l,c);
		CargarLista(l);
	end;
end;
procedure ImprListaRec(l:lista);
begin
	if(l<>nil)then begin
		writeln(l^.dato);
		ImprListaRec(l^.sig);
	end;
end;
procedure ImprAlrevez(l:lista);
begin
	if(l<>nil)then begin
		ImprListaRec(l^.sig);
		writeln(l^.dato);
	end;
end;
{procedure ImprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln(l^.dato);
		l:=l^.sig;
	end;
end;}

var
	l:lista;
begin
	l:=nil;
	CargarLista(l);
	ImprAlrevez(l);
	
end.




{var
	v:vector;
	dimL,cant:integer;
begin
	dimL:=0;
	cant:=0;
	ContarChar(cant);
	writeln(cant);
end.}


