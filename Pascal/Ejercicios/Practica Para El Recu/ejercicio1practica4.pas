program TuPrincipe;
type
	producto=record
		codigo:integer;
		cantTotal:integer;
		montoTotal:real;
	end;
	venta=record
		codVen:integer;
		codProd:integer;
		cantUni:integer;
		preUni:real;
	end;
	arbol=^nodo;
	nodo=record
		dato:producto;
		hi:arbol;
		hd:arbol;
	end;
procedure leerVen(var v:venta);
begin
	with v do begin
		writeln('Ingrese codigo de venta');
		readln(codVen);
		if(codVen<>-1)then begin
			writeln('Ingrese codigo de producto');
			readln(codProd);
			writeln('Ingrese cantidad de unidades');
			readln(cantUni);
			writeln('Ingrese el precio unitario');
			readln(preUni);
			writeln('-------------------------------------');
		end;
	end;
end;
procedure armarProducto(var p:producto;v:venta);
begin
	p.codigo:=v.codProd;
	p.cantTotal:=v.cantUni;
	p.montoTotal:=v.cantUni*v.preUni;
end;
procedure agregar(var a:arbol;v:venta);
var
	p:producto;
begin
	if(a=nil)then begin
		new(a);
		armarProducto(p,v);
		a^.dato:=p;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(v.codProd = a^.dato.codigo)then begin
			a^.dato.cantTotal:=a^.dato.cantTotal + v.cantUni;
			a^.dato.montoTotal:= a^.dato.montoTotal+(v.cantUni * v.preUni);
		end
		else begin
			if(v.codProd<a^.dato.codigo)then
				agregar(a^.hi,v)
			else
				agregar(a^.hd,v);
		end;
    end;
end;
procedure cargarArbol(var a:arbol);
var
	v:venta;
begin
	leerVen(v);
	while(v.codVen<>-1)do begin
		agregar(a,v);
		leerVen(v);
	end;
end;
procedure imprimirNodo(a:arbol);
begin
	writeln('------------------------');
	writeln('Codigo de producto: ',a^.dato.codigo);
	writeln('cantidad de unidades totales: ',a^.dato.cantTotal);
	writeln('Monto total: ',a^.dato.montoTotal:1:2);
end;
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.hi);
		imprimirNodo(a);
		imprimirArbol(a^.hd);
	end;
end;
procedure codigoConMayorUnidadesVendidas(a:arbol;var maxUni,maxCodProd:integer);
begin
	if(a<>nil)then begin
		codigoConMayorUnidadesVendidas(a^.HI,maxUni,maxCodProd);
		if(a^.dato.cantTotal>maxUni)then begin
			maxUni:=a^.dato.cantTotal;
			maxCodProd:=a^.dato.codigo;
		end;
		codigoConMayorUnidadesVendidas(a^.HD,maxUni,maxCodProd);
	end;
end;
function cantidadCodigosMenores(a:arbol;codigo:integer):integer;
begin
	if(a=nil)then
		cantidadCodigosMenores:=0
	else begin
		if(codigo>a^.dato.codigo)then
			cantidadCodigosMenores:=1+cantidadCodigosMenores(a^.HD,codigo)+cantidadCodigosMenores(a^.HI,codigo)
		else
			cantidadCodigosMenores:=0+cantidadCodigosMenores(a^.HI,codigo);
	end;
end;
function montoTotalEntreCodigos(a:arbol;codigo1,codigo2:integer):real;
begin
	if(a=nil)then
		montoTotalEntreCodigos:=0
	else begin
		if(a^.dato.codigo > codigo1) and (a^.dato.codigo < codigo2)then
			montoTotalEntreCodigos:=a^.dato.montoTotal+montoTotalEntreCodigos(a^.hi,codigo1,codigo2)
			+montoTotalEntreCodigos(a^.hd,codigo1,codigo2)
		else begin
			if(a^.dato.codigo <= codigo1)then
				montoTotalEntreCodigos:=montoTotalEntreCodigos(a^.HD,codigo1,codigo2)
			else
				montoTotalEntreCodigos:=montoTotalEntreCodigos(a^.HI,codigo1,codigo2);
		end;
	end;
end;
var
	a:arbol;
	maxUni,maxCodProd:integer;
begin
	maxUni:=-1;
	maxCodProd:=-1;
	a:=nil;
	cargarArbol(a);
	imprimirArbol(a);
	codigoConMayorUnidadesVendidas(a,maxUni,maxCodProd);
	if(maxUni<>-1)then
		writeln('Codigo con mayor unidades vendidas es: ',maxCodProd);
	writeln(cantidadCodigosMenores(a,13));
	writeln('El monto total entre los dos codigos es: ',montoTotalEntreCodigos(a,11,41):1:2);
end.
	
