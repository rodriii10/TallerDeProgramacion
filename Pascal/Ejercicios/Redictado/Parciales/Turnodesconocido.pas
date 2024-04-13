program myfavoritepart_macmiller;
type
	rangoDia=1..31;
	rangoMes=1..12;
	
	compra=record
		codJuego:integer;
		codCliente:integer;
		dia:rangoDia;
		mes:rangoMes;
	end;
	
	//ESTRUCTURA ii
	meses=array[rangoMes]of integer;
	
	compraB=record
		codJuego:integer;
		dia:rangoDia;
		mes:rangoMes;
	end;
	
	lista=^nodoL;
	nodoL=record
		dato:compraB;
		sig:lista;
	end;
	
	cliente=record
		codCliente:integer;
		compras:lista;
	end;
	
	//ESTRUCTURA i
	arbol=^nodo;
	nodo=record
		dato:cliente;
		hi:arbol;
		hd:arbol;
	end;

procedure leerCompra(var c:compra);
begin
	with c do begin
		writeln('Ingrese codigo de cliente');
		readln(codCliente);
		if(codCliente<>0)then begin
			writeln('Ingrese codigo de juego');
			readln(codJuego);
			writeln('Ingrese dia de la compra');
			readln(dia);
			writeln('Y mes');
			readln(mes);
		end;
	end;
end;

procedure agregarAdelante(var l:lista;c:compraB);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=c;
	nue^.sig:=l;
	l:=nue;
end;

procedure inicializarMeses(var m:meses);
var
	i:integer;
begin
	for i:=1 to 12 do
		m[i]:=0;
end;

procedure pasarDatos(var cb:compraB;c:compra);
begin
	cb.codJuego:=c.codJuego;
	cb.dia:=c.dia;
	cb.mes:=c.mes;
end;

procedure agregar(var a:arbol;c:compra);
var
	cb:compraB;
begin
	if(a=nil)then begin
		new(a);
		a^.dato.codCliente:=c.codCliente;
		a^.dato.compras:=nil;
		pasarDatos(cb,c);
		agregarAdelante(a^.dato.compras,cb);
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(a^.dato.codCliente=c.codCliente)then begin
			pasarDatos(cb,c);
			agregarAdelante(a^.dato.compras,cb);
		end
		else begin
			if(c.codCliente<a^.dato.codCliente)then
				agregar(a^.hi,c)
			else
				agregar(a^.hd,c);
		end;
	end;
end;

procedure cargarEstructuras(var a:arbol;var m:meses);
var
	c:compra;
begin
	leerCompra(c);
	while(c.codCliente<>0)do begin
		agregar(a,c);
		m[c.mes]:=m[c.mes]+1;
		leerCompra(c);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln('Codigo de juego: ',l^.dato.codJuego);
		l:=l^.sig;
	end;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.hi);
		writeln('CODIGO DE CLIENTE: ',a^.dato.codCliente);
		writeln('----------COMPRAS------------');
		imprimirLista(a^.dato.compras);
		imprimirArbol(a^.hd);
	end;
end;

procedure imprimirVector(var m:meses);
var
	i:integer;
begin
	for i:=1 to 12 do
		writeln('Cantidad de compras hechas en el mes ',i,' es de: ',m[i]);
end;

//INCISO B

function cantidadCompras(l:lista):integer;
begin
	if(l<>nil)then
		cantidadCompras:=cantidadCompras(l^.sig)+1
	else
		cantidadCompras:=0;
end;

function comprasDeXCliente(a:arbol;cod:integer):integer;
begin
	if(a=nil)then
		comprasDeXCliente:=0
	else begin
		if(a^.dato.codCliente=cod)then
			comprasDeXCliente:=cantidadCompras(a^.dato.compras)
		else begin
			if(cod<a^.dato.codCliente)then
				comprasDeXCliente:=comprasDeXCliente(a^.hi,cod)
			else
				comprasDeXCliente:=comprasDeXCliente(a^.hd,cod);
		end;
	end;
end;

//INCISO C

procedure insercion(var v:meses);
var
	i,j:integer;
	act:integer;
begin
	for i:=2 to 12 do begin
		act:=v[i];
		j:=i-1;
		while(j>0)and(v[j]>act)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=act;
	end;
end;

var
	a:arbol;
	m:meses;
begin
	a:=niL;
	inicializarMeses(m);
	cargarEstructuras(a,m);
	imprimirArbol(a);
	imprimirVector(m);
	writeln('Las compras que hizo el cliente 240 son de: ',comprasDeXCliente(a,240));
	insercion(m);
	imprimirVector(m);
end.
