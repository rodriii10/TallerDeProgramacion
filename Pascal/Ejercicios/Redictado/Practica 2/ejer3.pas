{
Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random”
mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
encuentra en la lista o falso en caso contrario.
}


program claseG_RelsB;
type
	lista=^nodo;
	nodo=record
		dato:integer;
		sig:lista;
	end;

procedure agregarAdelante(var l:lista;num:integer);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=num;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarLista(var l:lista);
var
	num:integer;
begin
	num:=random(100);
	if(num<>0)then begin
		agregarAdelante(l,num);
		cargarLista(l);
	end;
end;

{procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln(l^.dato);
		l:=l^.sig
	end;
end;}

procedure minimoValor(l:lista;var min:integer);
begin
	if(l<>nil)then begin
		if(l^.dato<min)then
			min:=l^.dato;
		minimoValor(l^.sig,min);
	end;
end;

procedure maximoValor(l:lista;var max:integer);
begin
	if(l<>nil)then begin
		if(l^.dato>max)then
			max:=l^.dato;
		maximoValor(l^.sig,max);
	end;
end;

function esta(l:lista;valor:integer):boolean;
begin
	if(l<>nil)then begin
		if(l^.dato=valor)then
			esta:=true
		else
			esta:=esta(l^.sig,valor);
	end
end;

var
	l:lista;
	min:integer;
	max:integer;
	valor:integer;
begin
	l:=nil;
	randomize;
	cargarLista(l);
	min:=101;
	max:=-1;
	minimoValor(l,min);
	maximoValor(l,max);
	writeln('El valor minimo encontrado fue: ',min);
	writeln('El valor maximo encontrado fue: ',max);
	writeln('Ingrese un valor que quiera buscar');
	readln(valor);
	if(esta(l,valor))then
		writeln('Se encontro')
	else
		writeln('No se pudo encontrar :(');
	//imprimirLista(l);
end.
