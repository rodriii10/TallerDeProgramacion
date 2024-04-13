
program Todo;
const
	dimF=8;
type
	rangoGeneros=1..dimF;
	pelicula = record
		codPeli:integer;
		codGen:rangoGeneros;
		puntaje:real;
	end;
	lista=^nodo;
	nodo=record
		dato:pelicula;
		sig:lista;
	end;
	vlistas = array [rangoGeneros]of lista;
	vpuntaje = array [rangoGeneros]of pelicula;
procedure Leer(var pe:pelicula);
begin
	with pe do begin
		writeln('Ingrese codigo de pelicula: ');
		readln(codPeli);
		if(codPeli<>-1)then begin
			writeln('Ingrese codigo de genero: ');
			readln(codGen);
			writeln('Ingrese puntaje promedio de criticas: ');
			readln(puntaje);
		end;
	end;
end;
procedure AgregarAtras(var L:lista;p:pelicula);
var
	nue,aux:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=nil;
	if(L=nil)then
		L:=nue
	else begin
		aux:=L;
		while(aux^.sig<>nil)do
			aux:=aux^.sig;
		aux^.sig:=nue;
	end;
end;
procedure InicializarVector(var v:vlistas);
var
	i:integer;
begin
	for i:=1 to dimF do 
		v[i]:=nil;
end;
procedure CargarVector(var v:vlistas);
var
	p:pelicula;
begin
	Leer(p);
	while(p.codPeli<>-1)do begin
		AgregarAtras(v[p.codGen],p);
		Leer(p);
	end;
end;
procedure CargarVP(var v2:vpuntaje;v:vlistas);
var
	i:integer;
	max:real;
begin
	for i:=1 to dimF do begin
		max:=-1;
		while(v[i]<>nil)do begin
			if(v[i]^.dato.puntaje>max)then begin
				max:= v[i]^.dato.puntaje;
				v2[i]:=v[i]^.dato;
			end;
			v[i]:=v[i]^.sig;
		end;
	end;
end;
procedure Insercion(var v2:vpuntaje);
var
	i,j:integer;
	act:pelicula;
begin
	for i:=2 to dimF do begin
		act:=v2[i];
		j:=i-1;
		while(j>0) and (v2[j].puntaje > act.puntaje) do begin
			v2[j+1]:=v2[j];
			j:=j-1;
		end;
		v2[j+1]:=act;
	end;
end;
var
	v:vlistas;
	v2:vpuntaje;
begin
	InicializarVector(v);
	CargarVector(v);
	CargarVP(v2,v);
	Insercion(v2);
	writeln('El codigo de pelicula con menor puntaje es: ',v2[1].codPeli);
	writeln('El codigo de pelicula con mayor puntaje es: ',v2[8].codPeli);
end.
		
