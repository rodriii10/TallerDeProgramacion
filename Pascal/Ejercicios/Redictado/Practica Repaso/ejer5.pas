program ellasedesacata;
type
	reclamo=record
		cod:integer;
		dni:integer;
		anio:integer;
		tipo:string;
	end;
	
	reclamosindni=record
		cod:integer;
		anio:integer;
		tipo:string;
	end;
	
	lista=^nodo;
	nodo=record
		dato:reclamosindni;
		sig:lista;
	end;
	
	persona=record
		dni:integer;
		reclamos:lista;
		cantReclamos:integer;
	end;

	arbol=^nodoA;
	nodoA=record
		dato:persona;
		hi:arbol;
		hd:arbol;
	end;

procedure leerReclamo(var r:reclamo);
begin
	with r do begin
		writeln('Ingrese codigo de reclamo');
		readln(cod);
		if(cod<>-1)then begin
			writeln('Ingrese dni');
			readln(dni);
			writeln('Ingrese anio');
			readln(anio);
			writeln('Ingrese tipo de reclamo');
			readln(tipo);
		end;
	end;
end;

procedure agregarAdelante(var l:lista;r:reclamosindni);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=r;
	nue^.sig:=l;
	l:=nue;
end;

procedure pasarDatos(var r:reclamosindni;r2:reclamo);
begin
	r.cod:=r2.cod;
	r.anio:=r2.anio;
	r.tipo:=r2.tipo;
end;

procedure agregar(var a:arbol;r:reclamo);
var
	rs:reclamosindni;
begin
	if(a=nil)then begin
		new(a);
		a^.dato.dni:=r.dni;
		a^.dato.reclamos:=nil;
		pasarDatos(rs,r);
		agregarAdelante(a^.dato.reclamos,rs);
		a^.dato.cantReclamos:=1;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(a^.dato.dni=r.dni)then begin
			pasarDatos(rs,r);
			agregarAdelante(a^.dato.reclamos,rs);
			a^.dato.cantReclamos:=a^.dato.cantReclamos+1;
		end
		else begin
			if(r.dni<a^.dato.dni)then
				agregar(a^.hi,r)
			else
				agregar(a^.hd,r);
		end;
	end;
end;

procedure cargarArbol(var a:arbol);
var
	r:reclamo;
	act:integer;
begin
	leerReclamo(r);
	while(r.cod<>-1)do begin
		act:=r.dni;
		while(r.cod<>-1)and(r.dni=act)do begin
			agregar(a,r);
			leerReclamo(r);
		end;
	end;
end;

var
	a:arbol;
begin
	a:=nil;
	cargarArbol(a);
end.
	
