{
Un supermercado requiere el procesamiento de sus productos. De cada producto se
conoce código, rubro (1..10), stock y precio unitario. Se pide:
a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
más eficiente posible. La lectura finaliza con el código de producto igual a -1.
b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
de producto y retorne si dicho código existe o no para ese rubro.
c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
rubro, el código y stock del producto con mayor código.
d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
ingresados.
}

program rushhour_macmiller;
type
    rangoRubro=1..10;
    
    producto=record
        cod:integer;
        rubro:rangoRubro;
        stock:integer;
        precio:real;
    end;
    
    productos=^nodo;
    nodo=record
        dato:producto;
        sig:productos;
    end;
    
    vector=array[rangoRubro]of productos;

procedure inicializarVector(var v:vector);
var
    i:integer;
begin
    for i:=1 to 10 do
        v[i]:=nil;
end;

procedure leerProducto(var p:producto);
begin
    with p do begin
        writeln('Ingrese codigo de producto');
        readln(cod);
        if(cod<>-1)then begin
            writeln('Ingrese rubro');
            readln(rubro);
            writeln('Ingrese stock del producto');
            readln(stock);
            writeln('Ingrese precio unitario');
            readln(precio);
        end;
    end;
end;

procedure agregarAdelante(var l:productos;p:producto);
var
    nue:productos;
begin
    new(nue);
    nue^.dato:=p;
    nue^.sig:=l;
    l:=nue;
end;

procedure cargarVector(var v:vector);
var
    p:producto;
begin
    leerProducto(p);
    while(p.cod<>-1)do begin
        agregarAdelante(v[p.rubro],p);
        leerProducto(p);
    end;
end;

procedure imprimirLista(l:productos);
begin
    while(l<>nil)do begin
        writeln('Producto ',l^.dato.cod);
        l:=l^.sig;
    end;
end;

procedure imprimirVector(v:vector);
var
    i:rangoRubro;
begin
    for i:=1 to 10 do begin
        writeln('RUBRO----', i ,' ------------');
        imprimirLista(v[i]);
    end;
end;
//INCISO B

function esta(l:productos;cod:integer):boolean;
var
	si:boolean;
begin
	si:=false;
	while(l<>nil)and(not si)do begin
		if(l^.dato.cod=cod)then begin  //SE PODRIA HACER SIN AUXILIAR,PERO NO SE PORQUE NO DETECTA Y LA ASIGNACION esta:=true;
			si:=true;
			esta:=si;
		end;
		l:=l^.sig;
	end;
	esta:=si;
end;

//INCISO C
procedure maximoCod(l:productos;var codMax,stockMax:integer);
begin
	while(l<>nil)do begin
		if(l^.dato.cod>codMax)then begin
			codMax:=l^.dato.cod;
			stockMax:=l^.dato.stock;
		end;
		l:=l^.sig;
	end;
end;

procedure maximosDeRubros(v:vector);
var
	i:integer;
	codMax,stockMax:integer;
begin
	for i:=1 to 10 do begin
		codMax:=-1;
		stockMax:=-1;
		maximoCod(v[i],codMax,stockMax);
		writeln('El codigo mayor del rubro ',i,' ,es: ',codMax,' con un stock de :',stockMax);
	end;
end;

function cantidadDeProductosEntre(l:productos;inf:integer;sup:integer):integer;
var
	cant:integer;
begin
	cant:=0;
	while(l<>nil)do begin
		if(l^.dato.cod>inf)and(l^.dato.cod<sup)then
			cant:=cant+1;
		l:=l^.sig;
	end;
	cantidadDeProductosEntre:=cant;
end;

procedure cantProductosEnRubrosEntreCodigos(v:vector;inf:integer;sup:integer);
var
	i:integer;
begin
	for i:=1 to 10 do
		writeln('La cantidad de productos entre ',inf,' y ',sup,' del rubro ',i,' es de: ',cantidadDeProductosEntre(v[i],inf,sup));
end;

var
    v:vector;
begin
    inicializarVector(v);
    cargarVector(v);
    imprimirVector(v);
	if(esta(v[3],240))then
		writeln('Se encontro')
	else
		writeln('No se encontro');
	maximosDeRubros(v);
	cantProductosEnRubrosEntreCodigos(v,100,400);
end.
