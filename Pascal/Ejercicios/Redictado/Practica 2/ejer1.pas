{1.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto, los
almacene en un vector con dimensión física igual a 10 y retorne el vector.
b. Un módulo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
d. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne la cantidad de caracteres leídos. El programa debe informar el valor retornado.
e. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne una lista con los caracteres leídos.
f. Un módulo recursivo que reciba la lista generada en e) e imprima los valores de la lista en el
mismo orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en e) e imprima los valores de
la lista en orden inverso al que están almacenados.
}


program azulmarino;
const
	dimF=10;
type
	vector=array[1..dimF]of char;
	
	lista=^nodo;
	nodo=record
		dato:char;
		sig:lista;
	end;

//Inciso A	
procedure cargarVector(var v:vector;i:integer);
var
	c:char;
begin
	writeln('Ingrese un caracter');
	readln(c);  //Un punto de parada puede ser que sea c<>'.' pero si se pasa de la dimF el usuario que se hace?
	if(i<dimF)and(c<>'.')then begin//Si se pasa de dimF estaria haciendo sumas de mas
		i:=i+1;
		v[i]:=c;
		cargarVector(v,i);
	end;
end;

//INCISO B
procedure imprimir(v:vector);
var
	i:integer;
begin
	for i:=1 to 10 do
		writeln(v[i]);
end;

//INCISO C
procedure imprimirRecursivo(v:vector;i:integer);
begin	
	if(i<dimF)then begin
		i:=i+1;
		writeln(v[i]);
		imprimirRecursivo(v,i);
	end;
end;

//INCISO D
procedure contarChars(var cant:integer);
var
	c:char;
begin
	writeln('Ingrese un char');
	readln(c);
	if(c<>'.')then begin
		cant:=cant+1;
		contarChars(cant);
	end;
end;

procedure agregarAdelante(var l:lista;c:char);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=c;
	nue^.sig:=l;
	l:=nue;
end;

//INCISO E
procedure cargarLista(var l:lista);
var
	c:char;
begin
	writeln('Ingrese un char');
	readln(c);
	if(c<>'.')then begin
		agregarAdelante(l,c);
		cargarLista(l);
	end;
end;

//INCISO F
procedure imprimirLista(l:lista);
begin
	if(l<>nil)then begin
		writeln(l^.dato);
		imprimirLista(l^.sig);
	end;
end;

//INCISO G
procedure imprimirListaInverso(l:lista);
begin
	if(l<>nil)then begin
		imprimirListaInverso(l^.sig);
		writeln(l^.dato);
	end;
end;

var
	v:vector;
	i:integer;
	l:lista;
begin
	{i:=0;
	cargarVector(v,i);
	imprimir(v);
	writeln('-------------');
	imprimirRecursivo(v,i);
	contarChars(i);
	writeln('La cantidad de caracteres leidos fueron: ',i);}
	l:=nil;
	cargarLista(l);
	imprimirLista(l);
	writeln('ORDEN INVERSO');
	imprimirListaInverso(l);
end.
