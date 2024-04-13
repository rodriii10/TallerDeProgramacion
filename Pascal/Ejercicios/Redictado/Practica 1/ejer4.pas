{
* Una librería requiere el procesamiento de la información de sus productos. De cada
producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y
agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza
cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que
puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3
es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
métodos vistos en la teoría.
e. Muestre los precios del vector resultante del punto d).
f. Calcule el promedio de los precios del vector resultante del punto d).
}

program Aprovecha;
const
	dimF=30;
type
	rangoRubro=1..8;
	producto=record
		cod:integer;
		rubro:rangoRubro;
		precio:real;
	end;
	
	lista=^nodo;
	nodo=record
		dato:producto;
		sig:lista;
	end;
	
	rubros=array[rangoRubro]of lista;
	rubro3=array[1..dimF]of producto;
	
procedure leerProducto(var p:producto);
begin
	with p do begin
		writeln('Ingrese precio del producto');
		readln(precio);
		if(precio<>0)then begin
			writeln('Ingrese un codigo de producto');
			readln(cod);
			writeln('Ingrese rubro perteneciente');
			readln(rubro);
		end;
	end;
end;

procedure inicializarVector(var v:rubros);
var
	i:integer;
begin
	for i:=1 to 8 do
		v[i]:=nil;
end;

procedure insertarOrdenado(var l:lista;p:producto);
var
	ant,act,nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	act:=l;
	while(act<>nil)and(act^.dato.cod<p.cod)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=l)then
		l:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
//INCISO A
procedure cargarVectorListas(var v:rubros);
var
	p:producto;
begin
	leerProducto(p);
	while(p.precio<>0)do begin
		insertarOrdenado(v[p.rubro],p);
		leerProducto(p);
	end;
end;
//INCISO B
procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln('-------PRODUCTO--------------');
		writeln('Codigo del producto: ',l^.dato.cod);
		writeln('Precio: ',l^.dato.precio:1:2);
		l:=l^.sig;
	end;
end;

procedure imprimirVectorListas(v:rubros);
var
	i:integer;
begin
	for i:=1 to 8 do begin
		writeln('-----RUBRO ',i,' -----------------------');
		imprimirLista(v[i]);
	end;
end;

//INCISO C
procedure cargarRubro3(var v:rubro3;var dimL:integer;l:lista);
begin
	while(l<>nil)and(dimL<dimF)do begin
		dimL:=dimL+1;
		v[dimL]:=l^.dato;
		l:=l^.sig;
	end;
end;

//INCISO E
procedure imprimirVector(v:rubro3;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		writeln('-------PRODUCTO--------------');
		writeln('Codigo del producto: ',v[i].cod);
		writeln('Precio: ',v[i].precio:1);
	end;
end;

//INCISO D
procedure insercion(var v:rubro3;dimL:integer);
var
	i,j:integer;
	act:producto;
begin
	for i:=2 to dimL do begin
		act:=v[i];
		j:=i-1;
		while(j>0)and(v[j].precio>act.precio)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=act;
	end;
end;

//INCISO F
function calcularPromedio(v:rubro3;dimL:integer):real;
var
	i:integer;
	suma:real;
begin
	suma:=0;
	for i:=1 to dimL do
		suma:=suma+v[i].precio;
	calcularPromedio:=suma/dimL;
end;

var
	v:rubros;
	v3:rubro3;
	dimL:integer;
begin
	inicializarVector(v);
	cargarVectorListas(v);
	//imprimirVectorListas(v);
	dimL:=0;
	cargarRubro3(v3,dimL,v[3]);
	insercion(v3,dimL);
	imprimirVector(v3,dimL);
	writeln('El promedio de precios es: ',calcularPromedio(v3,dimL):1:2);
end.
