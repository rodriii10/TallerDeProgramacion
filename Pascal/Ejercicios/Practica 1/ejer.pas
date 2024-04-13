program TumbandoElClub;
type
	ranZ=1..5;
	propiedades=record
		zona:ranZ;
		cod:integer;
		tipo:string;
		Met:real;
		PreMet:real;
		PreTotal:real;
	end;
	Lista=^nodo;
	nodo=record
		dato:propiedades;
		sig:Lista;
	end;
	vector=array[ranZ]of Lista;
Procedure Leer(var pr:propiedades);
begin
	with pr do begin
		writeln('Ingrese Precio de Metros');
		readln(PreMet);
		if(PreMet<>-1)then begin
			writeln('Ingrese zona');
			readln(zona);
			writeln('Ingrese codigo');
			readln(cod);
			writeln('Ingrese tipo');
			readln(tipo);
			writeln('Ingrese Metros');
			readln(Met);
			PreTotal:=Met*PreMet;
		end;
	end;
end;
procedure AgregarAdelante(v:vector;L:lista);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=L^.dato;
	nue^.sig:=v[L^.dato.zona];
	v[L^.dato.zona]:=L;
end;
procedure InsertarOrdenado(var L:lista;p:propiedades);
var
	nue,ant,act:Lista;
begin
	new(nue);
	nue^.dato:=p;
	act:=L;
	ant:=L;
	while(act<>nil) and (p.tipo<>act^.dato.tipo)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant)then
		L:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
procedure CargarLista(var L:lista);
var
	p:propiedades;
begin
	Leer(p);
	while(p.PreMet<>-1)do begin
		InsertarOrdenado(L,p);
		Leer(p);
	end;
end;
Procedure CargarVector(var v:vector;L:lista);
begin
	while(L<>nil)do begin
		AgregarAdelante(v,L);
		L:=L^.sig;
	end;
end;
procedure Retornar(v:vector);
var
	zona:ranZ;
	tip:string;
begin
	writeln('INGRESE UN NUMERO DE ZONA');
	readln(zona);
	writeln('INGRESE UN TIPO');
	readln(tip);
	while(v[zona]<>nil)and(v[zona]^.dato.tipo=tip)do begin
		writeln(v[zona]^.dato.cod);
		v[zona]:=v[zona]^.sig;
	end;
end;
var
	L:lista;
	v:vector;
begin
	L:=nil;
	CargarLista(L);
	CargarVector(v,L);
	Retornar(v);
end.
