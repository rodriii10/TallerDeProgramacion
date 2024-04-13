{
Escribir un programa que:
a. Implemente un módulo que lea información de socios de un club y las almacene en un árbol
binario de búsqueda. De cada socio se lee número de socio, nombre y edad. La lectura finaliza
con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
b. Una vez generado el árbol, realice módulos independientes que reciban el árbol como
parámetro y que :
i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.
ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un
módulo recursivo que retorne dicho socio.
iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que
retorne dicho valor.
iv. Aumente en 1 la edad de todos los socios.
v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a
un módulo recursivo que reciba el valor leído y retorne verdadero o falso.
vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a
un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha
cantidad.
viii. Informe el promedio de edad de los socios. Debe invocar al módulo recursivo del
inciso vii e invocar a un módulo recursivo que retorne la suma de las edades de los socios.
xi. Informe los números de socio en orden creciente.
x. Informe los números de socio pares en orden decreciente.
}

program queVasHacerTanSolaHoy;
type
	socio=record
		num:integer;
		nombre:string;
		edad:integer;
	end;
	
	arbol=^nodo;
	nodo=record
		dato:socio;
		hi:arbol;
		hd:arbol;
	end;


//INCISO A
procedure leerSocio(var s:socio);
begin
	with s do begin
		writeln('Ingrese numero de socio');
		readln(num);
		if(num<>0)then begin
			writeln('Ingrese nombre');
			readln(nombre);
			writeln('Ingrese edad');
			readln(edad);
		end;
	end;
end;

procedure agregar(var a:arbol;s:socio);
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=s;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(s.num<=a^.dato.num)then
			agregar(a^.hi,s)
		else
			agregar(a^.hd,s);
	end;
end;
		

procedure cargarArbol(var a:arbol);
var
	s:socio;
begin
	leerSocio(s);
	while(s.num<>0)do begin
		agregar(a,s);
		leerSocio(s);
	end;
end;

//INCISO ix
procedure imprimir(a:arbol);
begin
	if(a<>nil)then begin
		imprimir(a^.hi);
		writeln('Num de socio: ',a^.dato.num);
		writeln('Edad: ',a^.dato.edad);
		imprimir(a^.hd);
	end;
end;

//INCISO B
//INCISO i

function maximoSocio(a:arbol):integer;
begin
	if(a^.hd<>nil)then
		maximoSocio:=maximoSocio(a^.hd)
	else
		maximoSocio:=a^.dato.num;
end;

//INCISO ii
function minimoSocio(a:arbol):integer;
begin
	if(a^.hi<>nil)then
		minimoSocio:=minimoSocio(a^.hi)
	else
		minimoSocio:=a^.dato.num;
end;

//INCISO iii
procedure maximaEdad(a:arbol;var maxEdad:integer);
begin
	if(a<>nil)then begin
		maximaEdad(a^.hi,maxEdad);
		if(a^.dato.edad>maxEdad)then
			maxEdad:=a^.dato.edad;
		maximaEdad(a^.hd,maxEdad);
	end;
end;

//INCISO iv
procedure sumarUnAnio(a:arbol);
begin
	if(a<>nil)then begin
		sumarUnAnio(a^.hi);
		a^.dato.edad:=a^.dato.edad+1;
		sumarUnAnio(a^.hd);
	end;
end;

//INCISO v
function existe(a:arbol;num:integer):boolean;
begin
	if(a<>nil)then begin
		if(a^.dato.num=num)then 
			existe:=true
		else begin
			if(num<a^.dato.num)then
				existe:=existe(a^.hi,num)
			else
				existe:=existe(a^.hd,num);
		end;
	end
	else
		existe:=false;
end;

//INCISO vi
procedure existeNombre(a:arbol;nombre:string;var esta:boolean);
begin
	if(a<>nil)and(not esta)then begin
		if(a^.dato.nombre=nombre)then
			esta:=true;
		existeNombre(a^.hi,nombre,esta);
		existeNombre(a^.hd,nombre,esta);
	end;
end;

//INCISO vii
{procedure cantidadSocios(a:arbol;var cant:integer);
begin
	if(a<>nil)then begin
		cant:=cant+1;
		cantidadSocios(a^.hi,cant);
		cantidadSocios(a^.hd,cant);
	end;
end;}

function cantidadSocios(a:arbol):integer;
begin
	if(a=nil)then
		cantidadSocios:=0
	else begin
		if(a^.hi<>nil)then
			cantidadSocios:=cantidadSocios(a^.hi)+cantidadSocios(a^.hd)+1
		else
			cantidadSocios:=cantidadSocios(a^.hd)+1;
	end;
end;

//INCISO viii
function sumarEdades(a:arbol):integer;
begin
	if(a=nil)then
		sumarEdades:=0
	else begin
		if(a^.hi<>nil)then
			sumarEdades:=sumarEdades(a^.hi)+sumarEdades(a^.hd)+a^.dato.edad
		else
			sumarEdades:=sumarEdades(a^.hd)+a^.dato.edad;
	end;
end;

//INCISO x
procedure imprimirDecrecente(a:arbol);
begin
	if(a<>nil)then begin
		imprimirDecrecente(a^.hd);
		writeln('Numero de socio: ',a^.dato.num);
		imprimirDecrecente(a^.hi);
	end;
end;

var
	a:arbol;
	maxEdad:integer;
	num:integer;
	nombre:String;
	esta:boolean;
	cant:integer;
	prom:real;
begin
	a:=nil;
	maxEdad:=-1;
	cargarArbol(a);
	imprimir(a);
	writeln('El numero de socio mas grande es: ',maximoSocio(a));
	writeln('El numero de socio mas chico es: ',minimoSocio(a));
	maximaEdad(a,maxEdad);
	writeln('El socio mas mayor tiene como edad : ',maxEdad);
	sumarUnAnio(a);
	imprimir(a);
	writeln('Ingrese un numero de socio para ver si existe o no');
	readln(num);
	if(existe(a,num))then
		writeln('Se encontro')
	else
		writeln('No se encontro :(');
	writeln('Ingrese un nombre para ver si existe o no');
	readln(nombre);
	esta:=false;
	existeNombre(a,nombre,esta);
	if(esta)then
		writeln('Se encontro el nombre')
	else
		writeln('No se encontro el nombre');
	cant:=0;
	cantidadSocios(a,cant);
	writeln('Hay ',cantidadSocios(a),' socios');
	prom:=sumarEdades(a)/cantidadSocios(a);
	writeln('El promedio de edades es: ',prom:1:2);
	imprimirDecrecente(a);
end.
