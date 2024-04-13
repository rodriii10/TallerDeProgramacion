{
Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
se lee código, DNI de la persona, año y tipo de reclamo. La lectura finaliza con el código de
igual a -1. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
reclamos efectuados por ese DNI.
c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
los reclamos realizados en el año recibido.
}

program delivery_babyjey;
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
	
	//INCISO D
	listaCod=^nodoB;
	nodoB=record
		dato:integer;
		sig:listaCod;
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
begin
	leerReclamo(r);
	while(r.cod<>-1)do begin
		agregar(a,r);
		leerReclamo(r);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln('CODIGO: ',l^.dato.cod);
		l:=l^.sig;
	end;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.hi);
		writeln('dni: ',a^.dato.dni);
		writeln('cantidad de reclamos: ',a^.dato.cantReclamos);
		writeln('----------RECLAMOS-------');
		imprimirLista(a^.dato.reclamos);
		imprimirArbol(a^.hd);
	end;
end;

//INCISO B

function cantidadReclamos(a:arbol;dni:integer):integer;
begin
	if(a=nil)then
		cantidadReclamos:=0
	else begin
		if(a^.dato.dni=dni)then
			cantidadReclamos:=a^.dato.cantReclamos
		else begin
			if(dni<a^.dato.dni)then
				cantidadReclamos:=cantidadReclamos(a^.hi,dni)
			else
				cantidadReclamos:=cantidadReclamos(a^.hd,dni);
		end;
	end;
end;

//INCISO C
function cantidadReclamosEntre(a:arbol;dniinf:integer;dnisup:integer):integer;
begin
	if(a=nil)then
		cantidadReclamosEntre:=0
	else begin
		if(a^.dato.dni>dniinf)then begin
			if(a^.dato.dni<dnisup)then
				cantidadReclamosEntre:=cantidadReclamosEntre(a^.hi,dniinf,dnisup)+cantidadReclamosEntre(a^.hd,dniinf,dnisup)+a^.dato.cantReclamos
			else
				cantidadReclamosEntre:=cantidadReclamosEntre(a^.hi,dniinf,dnisup);
		end
		else
			cantidadReclamosEntre:=cantidadReclamosEntre(a^.hd,dniinf,dnisup);
	end;
end;

//INCISO D
procedure agregarAdelante2(var l:listaCod;num:integer);
var
	nue:listaCod;
begin	
	new(nue);
	nue^.dato:=num;
	nue^.sig:=l;
	l:=nue;
end;

procedure recorrerLista(lR:lista;var lC:listaCod;anio:integer);
begin
	while(lR<>nil)do begin
		if(lR^.dato.anio=anio)then
			agregarAdelante2(lC,lR^.dato.cod);
		lR:=lR^.sig;
	end;
end;

procedure reclamosRealizadosEnXAnio(a:arbol;anio:integer;var l:listaCod);
begin
	if(a<>nil)then begin
		recorrerLista(a^.dato.reclamos,l,anio);
		reclamosRealizadosEnXAnio(a^.hi,anio,l);
		reclamosRealizadosEnXAnio(a^.hd,anio,l);
	end;
end;

procedure imprimirCodigos(l:listaCod);
begin
	while(l<>nil)do begin
		writeln('CODIGO: ',l^.dato);
		l:=l^.sig;
	end;
end;

var
	a:arbol;
	l:listaCod;
begin
	a:=nil;
	cargarArbol(a);
	imprimirArbol(a);
	writeln('Cantidad de reclamos del dni 235: ',cantidadReclamos(a,235));
	writeln('La cantidad de reclamos entre 200 y 300 es de: ',cantidadReclamosEntre(a,200,300));
	l:=nil;
	writeln('---------------');
	reclamosRealizadosEnXAnio(a,2000,l);
	imprimirCodigos(l);
end.


