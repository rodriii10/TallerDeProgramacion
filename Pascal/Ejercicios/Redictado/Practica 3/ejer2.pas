{
Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee
código de producto, fecha y cantidad de unidades vendidas. La lectura finaliza con el código de
producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendida.
Nota: El módulo debe retornar los dos árboles.
b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.
}


program tuPaz;
type
	venta=record
		cod:integer;
		fecha:string;
		cant:integer;
	end;
	
	//Arbol venta
	arbol=^nodo;
	nodo=record
		dato:venta;
		hi:arbol;
		hd:arbol;
	end;
	
	producto=record
		cod:integer;
		cantTotal:integer;
	end;
	
	//Arbol Producto
	arbolP=^nodo2;
	nodo2=record
		dato:producto;
		hi:arbolP;
		hd:arbolP;
	end;
	
procedure leerVenta(var v:venta);
begin
	with v do begin
		writeln('Ingrese codigo de producto');
		readln(cod);
		if(cod<>0)then begin
			writeln('Ingrese fecha de venta');
			readln(fecha);
			writeln('Ingrese cantidad unidades vendidas');
			readln(cant);
		end;
	end;
end;

//Agregar i
procedure agregar(var a:arbol;v:venta);
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=v;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(v.cod<=a^.dato.cod)then
			agregar(a^.hi,v)
		else
			agregar(a^.hd,v);
	end;
end;

//Agregar ii
procedure agregar2(var a:arbolP;p:producto);
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=p;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(a^.dato.cod=p.cod)then
			a^.dato.cantTotal:=a^.dato.cantTotal+p.cantTotal
		else begin
			if(p.cod<a^.dato.cod)then
				agregar2(a^.hi,p)
			else
				agregar2(a^.hd,p);
		end;
	end;
end;

procedure cargarArboles(var a:arbol;var aP:arbolP);
var
	v:venta;
	p:producto;
begin
	leerVenta(v);
	while(v.cod<>0)do begin
		agregar(a,v);
		p.cod:=v.cod;
		p.cantTotal:=v.cant;
		agregar2(aP,p);
		leerVenta(v);
	end;
end;

procedure imprimir(a:arbol);
begin
	if(a<>nil)then begin
		imprimir(a^.hi);
		writeln('----PRODUCTO ',a^.dato.cod,' --------------------');
		writeln('cantidad vendida: ',a^.dato.cant);
		writeln('Fecha: ',a^.dato.fecha);
		imprimir(a^.hd);
	end;
end;

procedure imprimirAP(a:arbolP);
begin
	if(a<>nil)then begin
		imprimirAP(a^.hi);
		writeln('---PRODUCTO ',a^.dato.cod,' -------------------');
		writeln('Cantidad total vendida: ',a^.dato.cantTotal);
		imprimirAP(a^.hd);
	end;
end;

function cantidadVendidas(a:arbol;cod:integer):integer;
begin
	if(a=nil)then
		cantidadVendidas:=0
	else begin
		if(a^.dato.cod=cod)then
			cantidadVendidas:=cantidadVendidas(a^.hi,cod)+a^.dato.cant
		else begin
			if(cod<a^.dato.cod)then
				cantidadVendidas:=cantidadVendidas(a^.hi,cod)
			else begin
				if(cod>a^.dato.cod)then
					cantidadVendidas:=cantidadVendidas(a^.hd,cod)
			end;
		end;
	end;
end;

function cantidadVendidasAP(a:arbolP;cod:integer):integer;
begin
	if(a=nil)then
		cantidadVendidasAP:=0
	else begin
		if(a^.dato.cod=cod)then
			cantidadVendidasAP:=a^.dato.cantTotal
		else begin
			if(cod<a^.dato.cod)then
				cantidadVendidasAP:=cantidadVendidasAP(a^.hi,cod)
			else
				cantidadVendidasAP:=cantidadVendidasAP(a^.hd,cod);
		end;
	end;
end;


var
	a:arbol;
	aP:arbolP;
begin
	a:=nil;
	aP:=nil;
	cargarArboles(a,aP);
	imprimir(a);
	imprimirAP(aP);
	writeln('Cantidades vendidas del codigo 123: ',cantidadVendidas(a,123));
	writeln('Cantidad total del producto 123: ',cantidadVendidasAP(aP,123));
end.
