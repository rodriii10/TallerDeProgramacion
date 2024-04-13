{
1. Implementar un programa modularizado para una librería que:
a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por código
de producto. De cada producto deben quedar almacenados la cantidad total de unidades
vendidas y el monto total. De cada venta se lee código de venta, código del producto
vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las ventas finaliza
cuando se lee el código de venta -1.
b. Imprima el contenido del árbol ordenado por código de producto.
c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el
código de producto con mayor cantidad de unidades vendidas.
d. Contenga un módulo que reciba la estructura generada en el punto a y un código de
producto y retorne la cantidad de códigos menores que él que hay en la estructura.
e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de
producto y retorne el monto total entre todos los códigos de productos comprendidos
entre los dos valores recibidos (sin incluir).
}


program ContentExplicit;
type
	venta=record
		codV:integer;
		codP:integer;
		cantUnidades:integer;
		precio:real;
	end;
	
	producto=record
		cod:integer;
		cantTotal:integer;
		montoTotal:real;
	end;
	
	arbol=^nodo;
	nodo=record
		dato:producto;
		hi:arbol;
		hd:arbol;
	end;
	
	
	

procedure leerVenta(var v:venta);
begin
	with v do begin
		writeln('Ingrese un codigo de venta');
		readln(codV);
		if(codV<>-1)then begin
			writeln('Ingrese codigo de producto');
			readln(codP);
			writeln('Ingrese cantidad de unidades vendidas');
			readln(cantUnidades);
			writeln('Ingrese precio unitario');
			readln(precio);
		end;
	end;
end;

procedure armarProducto(var p:producto;v:venta);
begin
	with p do begin
		cod:=v.codP;
		cantTotal:=v.cantUnidades;
		montoTotal:=v.precio*v.cantUnidades;
	end;
end;

procedure agregar(var a:arbol;v:venta);
var
	p:producto;
begin
	if(a=nil)then begin
		new(a);
		armarProducto(p,v);
		a^.dato:=p;
		a^.hd:=nil;
		a^.hi:=nil;
	end
	else begin
		if(a^.dato.cod=v.codP)then begin
			a^.dato.cantTotal:=a^.dato.cantTotal+v.cantUnidades;
			a^.dato.montoTotal:=a^.dato.montoTotal+(v.cantUnidades*v.precio);
		end
		else begin
			if(v.codP<a^.dato.cod)then
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
	leerVenta(v);
	while(v.codV<>-1)do begin
		agregar(a,v);
		leerVenta(v);
	end;
end;

//INCISO B

procedure imprimir(a:arbol);
begin
	if(a<>nil)then begin
		imprimir(a^.hi);
		writeln('Producto: ',a^.dato.cod);
		writeln('Cantidad total vendidas: ',a^.dato.cantTotal);
		writeln('Monto total: ',a^.dato.montoTotal:1:2);
		imprimir(a^.hd);
	end;
end;

//INCISO C

procedure maximaCantidadVendida(a:arbol;var maxProd:integer;var maxCant:integer);
begin
	if(a<>nil)then begin
		if(a^.dato.cantTotal>maxCant)then begin
			maxCant:=a^.dato.cantTotal;
			maxProd:=a^.dato.cod;
		end;
		maximaCantidadVendida(a^.hi,maxProd,maxCant);
		maximaCantidadVendida(a^.hd,maxProd,maxCant);
	end;
end;

//INCISO D

function cantidadCodigosMenores(a:arbol;cod:integer):integer;
begin
	if(a=nil)then
		cantidadCodigosMenores:=0
	else begin
		if(a^.dato.cod>=cod)then
			cantidadCodigosMenores:=cantidadCodigosMenores(a^.hi,cod)
		else
			cantidadCodigosMenores:=cantidadCodigosMenores(a^.hi,cod)+cantidadCodigosMenores(a^.hd,cod)+1;
	end;
end;

//INCISO E
function montoTotalEntreCodigos(a:arbol;cod1,cod2:integer):real;
begin
	if(a=nil)then
		montoTotalEntreCodigos:=0
	else begin
		if(a^.dato.cod>cod1)then begin
			if(a^.dato.cod<cod2)then
				montoTotalEntreCodigos:=montoTotalEntreCodigos(a^.hi,cod1,cod2)+montoTotalEntreCodigos(a^.hd,cod1,cod2)+a^.dato.montoTotal
			else
				montoTotalEntreCodigos:=montoTotalEntreCodigos(a^.hi,cod1,cod2);
		end
		else 
			montoTotalEntreCodigos:=montoTotalEntreCodigos(a^.hd,cod1,cod2);
	end;
end;
		
var
	a:arbol;
	maxProd:integer;
	maxCant:integer;
	cod:integer;
begin
	a:=nil;
	cargarArbol(a);
	imprimir(a);
	maxProd:=-1;
	maxCant:=-1;
	maximaCantidadVendida(a,maxProd,maxCant);
	writeln('El codigo: ',maxProd,' es el que tiene mayor cantidad vendida con una cantidad de: ',maxCant);
	writeln('Ingrese un codigo');
	readln(cod);
	writeln('Cantidad de codigos menores a: ',cod,' son: ',cantidadCodigosMenores(a,cod));
	writeln('Monto total entre 25 y 38 es de : ',montoTotalEntreCodigos(a,25,38):1:2);
end.
