program bastardo_pablochille;
type
	compra=record
		cod:integer;
		numFactura:integer;
		cantProductos:integer;
		monto:real;
	end;
	
	compraSinCod=record
		numFactura:integer;
		cantProductos:integer;
		monto:real;
	end;
	
	lista=^nodoL;
	nodoL=record
		dato:compraSinCod;
		sig:lista;
	end;
	
	cliente=record
		cod:integer;
		compras:lista;
	end;

	arbol=^nodo;
	nodo=record
		dato:cliente;
		hi:arbol;
		hd:arbol;
	end;
	
procedure leerCompra(var c:compra);
begin
	with c do begin
		writeln('Ingrese un codigo de cliente');
		readln(cod);
		if(cod<>0)then begin
			writeln('Ingrese numero de factura');
			readln(numFactura);
			writeln('Ingrese cantidad de productos');
			readln(cantProductos);
			writeln('Ingrese monto de la compra');
			readln(monto);
		end;
	end;
end;

procedure agregarAdelante(var l:lista;c:compraSinCod);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=c;
	nue^.sig:=l;
	l:=nue;
end;

procedure pasarDatos(var c:compraSinCod;c2:compra);
begin
	c.numFactura:=c2.numFactura;
	c.cantProductos:=c2.cantProductos;
	c.monto:=c2.monto;
end;

procedure agregar(var a:arbol;c:compra);
var
	cS:compraSinCod;
begin
	if(a=nil)then begin
		new(a);
		a^.dato.cod:=c.cod;
		pasarDatos(cS,c);
		agregarAdelante(a^.dato.compras,cS);
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(a^.dato.cod=c.cod)then begin
			pasarDatos(cS,c);
			agregarAdelante(a^.dato.compras,cS);
		end
		else begin
			if(c.cod<a^.dato.cod)then
				agregar(a^.hi,c)
			else
				agregar(a^.hd,c)
		end;
	end;
end;

procedure cargarArbol(var a:arbol);
var
	c:compra;
begin
	leerCompra(c);
	while(c.cod<>0)do begin
		agregar(a,c);
		leerCompra(c);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln('Numero de factura: ',l^.dato.numFactura);
		l:=l^.sig;
	end;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.hi);
		writeln('CODIGO DE CLIENTE :',a^.dato.cod);
		imprimirLista(a^.dato.compras);
		imprimirArbol(a^.hd);
	end;
end;

//INCISO B

procedure recorrerLista(l:lista;var cantCompras:integer;var montoTotal:real);
begin
	while(l<>nil)do begin
		cantCompras:=cantCompras+1;
		montoTotal:=montoTotal+l^.dato.monto;
		l:=l^.sig;
	end;
end;

procedure comprasYMontoDeXCliente(a:arbol;cod:integer;var cantCompras:integer;var montoTotal:real);
begin
	if(a<>nil)then begin
		if(a^.dato.cod=cod)then
			recorrerLista(a^.dato.compras,cantCompras,montoTotal)
		else begin
			if(cod<a^.dato.cod)then
				comprasYMontoDeXCliente(a^.hi,cod,cantCompras,montoTotal)
			else
				comprasYMontoDeXCliente(a^.hd,cod,cantCompras,montoTotal);
		end;
	end;
end;

//INCISO C

procedure recorroLista(l:lista;facinf,facsup:integer;var l2:lista);
begin
	while(l<>nil)do begin
		if(l^.dato.numFactura>=facinf)and(l^.dato.numFactura<=facsup)then
			agregarAdelante(l2,l^.dato);
		l:=l^.sig;
	end;
end;

procedure ventasEntreFacturaXeY(a:arbol;facinf,facsup:integer;var l:lista);
begin
	if(a<>nil)then begin
		recorroLista(a^.dato.compras,facinf,facsup,l);
		ventasEntreFacturaXeY(a^.hi,facinf,facsup,l);
		ventasEntreFacturaXeY(a^.hd,facinf,facsup,l);
	end;
end;	

var
	a:arbol;
	cod:integer;
	montoTotal:real;
	cantCompras:integer;
	l:lista;
begin
	a:=nil;
	cargarArbol(a);
	imprimirArbol(a);
	montoTotal:=0;
	cantCompras:=0;
	writeln('Ingrese un codigo para saber su monto total y su cantidad de productos comprados');
	readln(cod);
	comprasYMontoDeXCliente(a,cod,cantCompras,montoTotal);
	writeln('El codigo ',cod,' tiene ',cantCompras,' y un monto total gastado de: ',montoTotal);
	l:=nil;
	ventasEntreFacturaXeY(a,200,300,l);
	imprimirLista(l);
end.
