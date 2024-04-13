program SiTeSentisSola;
type
	compra=record
		cod:integer;
		num:integer;
		cant:integer;
		monto:real;
	end;
	
	infoCli=record
		num:integer;
		cant:integer;
		monto:real;
	end;
	
	lista=^nodoL;
	nodoL=record
		dato:infoCli;
		sig:lista;
	end;
	
	arbol=^nodo;
	nodo=record
		cod:integer;
		dato:lista;
		hi:arbol;
		hd:arbol;
	end;
	
	listaVentas=^nodoV;
	nodoV=record
		dato:compra;
		sig:listaVentas;
	end;
procedure leer(var c:compra);
begin
	with c do begin
		writeln('Ingrese codigo de cliente');
		readln(cod);
		if(cod<>0)then begin
			writeln('Ingrese numero de factura');
			readln(num);
			writeln('Ingrese cantidad de productos');
			readln(cant);
			writeln('Ingrese monto de compra');
			readln(monto);
		end;
	end;
end;
procedure pasarDatos(var i:infoCli;c:compra);
begin
	i.num:=c.num;
	i.cant:=c.cant;
	i.monto:=c.monto;
end;
procedure agregarALista(var l:lista;i:infoCli);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=i;
	nue^.sig:=l;
	l:=nue;
end;
procedure agregar(var a:arbol;c:compra);
var
	i:infoCli;
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=nil;
		a^.cod:=c.cod;
		pasarDatos(i,c);
		a^.hi:=nil;
		a^.hd:=nil;
		agregarALista(a^.dato,i);
	end
	else begin
		if(a^.cod=c.cod)then begin
			pasarDatos(i,c);
			agregarALista(a^.dato,i)
		end
		else begin
			if(c.cod < a^.cod)then
				agregar(a^.hi,c)
			else
				agregar(a^.hd,c);
		end;
	end;
end;
procedure cargarArbol(var a:arbol);
var
	c:compra;
begin
	leer(c);
	while(c.cod<>0)do begin
		agregar(a,c);
		leer(c);
	end;
end;
procedure imprimirLista(l:lista;cod:integer);
begin
	writeln('------CODIGO= ',cod,' -------------');
	while(l<>nil)do begin
		writeln('Numero de factura: ',l^.dato.num);
		writeln('Cantidad de producto: ',l^.dato.cant);
		writeln('Monto: ',l^.dato.monto:1:2);
		l:=l^.sig;
	end;
end;
procedure imprArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprArbol(a^.hi);
		imprimirLista(a^.dato,a^.cod);
		imprArbol(a^.hd);
	end;
end;
procedure cantComprasymonto(a:arbol;codigo:integer;var cantC:integer;var montototal:real);
begin
	if(a<>nil)then begin
		if(a^.cod=codigo)then begin
			while(a^.dato<>nil)do begin
				cantC:=cantC+1;
				montototal:=montototal+a^.dato^.dato.monto;
				a^.dato:=a^.dato^.sig;
			end;
		end
		else begin
			if(codigo < a^.cod)then
				cantComprasymonto(a^.hi,codigo,cantC,montototal)
			else
				cantComprasymonto(a^.hd,codigo,cantC,montototal);
		end;
	end;
end;
procedure agregarAdelante(var l:listaVentas;c:infoCli;cod:integer);
var
	nue:listaVentas;
begin
	new(nue);
	nue^.dato.cod:=cod;
	nue^.dato.num:=c.num;
	nue^.dato.cant:=c.cant;
	nue^.dato.monto:=c.monto;
	nue^.sig:=l;
	l:=nue;
end;
procedure ventasEntreXeY(a:arbol;var l:listaVentas;x,y:integer);
var
	cod:integer;
begin
	if(a<>nil)then begin
		ventasEntreXeY(a^.hi,l,x,y);
		if(a^.dato^.dato.num>=x)and(a^.dato^.dato.num<=y)then begin
			cod:=a^.cod;
			agregarAdelante(l,a^.dato^.dato,cod);
		end;
		ventasEntreXeY(a^.hd,l,x,y);
	end;
end;
procedure imprimirLista2(li:listaVentas);
begin
	while(li<>nil)do begin
		writeln('Codigo: ',li^.dato.cod);
		writeln('Num: ',li^.dato.num);
		writeln('cant: ',li^.dato.cant);
		writeln('monto: ',li^.dato.monto);
		li:=li^.sig;
	end;
end;
var
	a:arbol;
	cantC:integer;
	montototal:real;
	codigo:integer;
	li:listaVentas;
	x,y:integer;
begin
	a:=nil;
	cargarArbol(a);
	imprArbol(a);
	writeln('Ingrese un codigo para buscar sus compras y monto total');
	readln(codigo);
	cantComprasymonto(a,codigo,cantC,montototal);
	writeln('La cantidad de compras es: ',cantC);
	writeln('El monto total gastado es: ',montototal:1:2);
	writeln('Ingrese numero de factura X: ');
	readln(x);
	writeln('Ingrese numero de factura Y: ');
	readln(y);
	ventasEntreXeY(a,li,x,y);
	imprimirLista2(li);
end.
