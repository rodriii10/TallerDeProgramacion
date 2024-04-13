{
Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio,
día y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN -1. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
h. Un módulo recursivo que reciba la estructura generada en h. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos). 
}

program summerHit;
type
	rangoDia=1..31;
	rangoMes=1..12;
	
	//ESTRUCTURA i
	prestamo=record
		isbn:integer;
		num:integer;
		dia:rangoDia;
		mes:rangoMes;
		cantDias:integer;
	end;
	
	arbol=^nodo;
	nodo=record
		dato:prestamo;
		hi:arbol;
		hd:arbol;
	end;
	
	//ESTRUCTURA ii
	prestamoSinIsbn=record
		num:integer;
		dia:rangoDia;
		mes:rangoMes;
		cantDias:integer;
	end;
	
	lista=^nodoL;
	nodoL=record
		dato:prestamoSinIsbn;
		sig:lista;
	end;
	
	librosIsbn=record
		isbn:integer;
		prestamos:lista;
	end;
	
	arbolisbn=^nodo2;
	nodo2=record
		dato:librosIsbn;
		hi:arbolisbn;
		hd:arbolisbn;
	end;
	
	//ESTRUCTURA f
	
	libro=record
		isbn:integer;
		cantPrestado:integer;
	end;
	
	listaisbn=^nodo3;
	nodo3=record
		dato:libro;
		sig:listaisbn;
	end;
	

procedure leerPrestamo(var p:prestamo);
begin
	with p do begin
		writeln('Ingrese isbn del libro');
		readln(isbn);
		if(isbn<>-1)then begin
			writeln('Ingrese numero de socio');
			readln(num);
			writeln('Ingrese dia que se encargo');
			readln(dia);
			writeln('Y mes');
			readln(mes);
			writeln('Ingrese la cantidad de dias');
			readln(cantDias);
		end;
	end;
end;
//AGREGAR i
procedure agregar(var a:arbol;p:prestamo);
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=p;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(p.isbn<=a^.dato.isbn)then
			agregar(a^.hi,p)
		else
			agregar(a^.hd,p);
	end;
end;

//AGREGAR ii
procedure armarPrestamo(var pSin:prestamoSinIsbn;p:prestamo);
begin
	pSin.num:=p.num;
	pSin.dia:=p.dia;
	pSin.mes:=p.mes;
	pSin.cantDias:=p.cantDias;
end;

procedure agregarAdelante(var l:lista;p:prestamoSinIsbn);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=l;
	l:=nue;
end;

procedure agregar2(var a:arbolisbn;p:prestamo);
var
	pSin:prestamoSinIsbn;
begin
	if(a=nil)then begin
		new(a);
		a^.dato.isbn:=p.isbn;
		a^.dato.prestamos:=nil;
		armarPrestamo(pSin,p);
		agregarAdelante(a^.dato.prestamos,pSin);
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(a^.dato.isbn=p.isbn)then begin
			armarPrestamo(pSin,p);
			agregarAdelante(a^.dato.prestamos,pSin);
		end
		else begin
			if(p.isbn<a^.dato.isbn)then
				agregar2(a^.hi,p)
			else
				agregar2(a^.hd,p);
		end;
	end;
end;

procedure cargarArboles(var a:arbol;var a2:arbolisbn);
var
	p:prestamo;
begin
	leerPrestamo(p);
	while(p.isbn<>-1)do begin
		agregar(a,p);
		agregar2(a2,p);
		leerPrestamo(p);
	end;
end;

procedure imprimira1(a:arbol);
begin
	if(a<>nil)then begin
		imprimira1(a^.hi);
		writeln('Isbn: ',a^.dato.isbn);
		imprimira1(a^.hd);
	end;
end;

procedure imprimirPrestamos(l:lista);
begin
	while(l<>nil)do begin
		writeln('>>PRESTAMO<<');
		writeln('NUMERO DE SOCIO>',l^.dato.num);
		writeln('DIA Y MES QUE SE PIDIO>',l^.dato.dia,'/',l^.dato.mes);
		writeln('CANTIDAD DE DIAS PRESTADOS: ',l^.dato.cantDias);
		l:=l^.sig;
	end;
end;

procedure imprimira2(a:arbolisbn);
begin
	if(a<>nil)then begin
		imprimira2(a^.hi);
		writeln('ISBN >',a^.dato.isbn);
		writeln('>>>>>PRESTAMOS<<<<<');
		imprimirPrestamos(a^.dato.prestamos);
		imprimira2(a^.hd);
	end;
end;

//INCISO B
function isbnMasGrande(a:arbol):integer;
begin
	if(a=nil)then
		isbnMasGrande:=-1
	else begin
		if(a^.hd<>nil)then
			isbnMasGrande:=isbnMasGrande(a^.hd)
		else
			isbnMasGrande:=a^.dato.isbn;
	end;
end;

//INCISO C
function isbnMasChico(a:arbolisbn):integer;
begin
	if(a=nil)then
		isbnMasChico:=-1
	else begin
		if(a^.hi<>nil)then
			isbnMasChico:=isbnMasChico(a^.hi)
		else
			isbnMasChico:=a^.dato.isbn;
	end;
end;

//INCISO D
function prestamosDelSocio(a:arbol;numS:integer):integer;
begin
	if(a=nil)then
		prestamosDelSocio:=0
	else begin
		if(a^.dato.num=numS)then
			prestamosDelSocio:=prestamosDelSocio(a^.hi,numS)+prestamosDelSocio(a^.hd,numS)+1
		else
			prestamosDelSocio:=prestamosDelSocio(a^.hi,numS)+prestamosDelSocio(a^.hd,numS);
	end;
end;
//INCISO E
function recorrerLista(l:lista;numS:integer):integer;
begin
	if(l=nil)then
		recorrerLista:=0
	else begin
		if(l^.dato.num=numS)then
			recorrerLista:=recorrerLista(l^.sig,numS)+1
		else
			recorrerLista:=recorrerLista(l^.sig,numS);
	end;
end;

function prestamosDelSocio2(a:arbolisbn;numS:integer):integer;
begin
	if(a=nil)then
		prestamosDelSocio2:=0
	else
		prestamosDelSocio2:=prestamosDelSocio2(a^.hi,numS)+prestamosDelSocio2(a^.hd,numS)+recorrerLista(a^.dato.prestamos,numS);
end;

//INCISO F
function cantidadVecesPrestado(a:arbol;isbn:integer):integer;
begin
	if(a=nil)then
		cantidadVecesPrestado:=0
	else begin
		if(a^.dato.isbn=isbn)then
			cantidadVecesPrestado:=cantidadVecesPrestado(a^.hi,isbn)+1
		else
			cantidadVecesPrestado:=0;
	end;
end;

procedure agregarAdelante2(var l:listaisbn;lib:libro);
var
	nue:listaisbn;
begin
	new(nue);
	nue^.dato:=lib;
	nue^.sig:=l;
	l:=nue;
end;

procedure incisoF(a:arbol;var l:listaisbn;var ant:integer);
var
	lib:libro;
begin
	if(a<>nil)then begin
		incisoF(a^.hd,l,ant);
		if(ant<>a^.dato.isbn)then begin
			lib.isbn:=a^.dato.isbn;
			lib.cantPrestado:=cantidadVecesPrestado(a,a^.dato.isbn);
			agregarAdelante2(l,lib);
			ant:=a^.dato.isbn;
		end;
		incisoF(a^.hi,l,ant);
	end;
end;

procedure imprimirLista(l:listaisbn);
begin
	while(l<>nil)do begin
		writeln('ISBN--------: ',l^.dato.isbn);
		writeln('Cantidad de veces prestado: ',l^.dato.cantPrestado);
		l:=l^.sig;
	end;
end;

//INCISO G

function cantidadPrestamos(l:lista):integer;
begin
	if(l<>nil)then
		cantidadPrestamos:=cantidadPrestamos(l^.sig)+1
	else
		cantidadPrestamos:=0;
end;

procedure incisoG(a:arbolisbn;var l:listaisbn);
var	
	lib:libro;
begin
	if(a<>nil)then begin
		incisoG(a^.hd,l);
		lib.isbn:=a^.dato.isbn;
		lib.cantPrestado:=cantidadPrestamos(a^.dato.prestamos);
		agregarAdelante2(l,lib);
		incisoG(a^.hi,l);
	end;
end;

//INCISO H

//INCISO I
function cantidadPrestamosEntre(a:arbol;isbninf,isbnsup:integer):integer;
begin
	if(a=nil)then
		cantidadPrestamosEntre:=0
	else begin
		if(a^.dato.isbn>=isbninf)then begin
			if(a^.dato.isbn<=isbnsup)then
				cantidadPrestamosEntre:=cantidadPrestamosEntre(a^.hi,isbninf,isbnsup)+cantidadPrestamosEntre(a^.hd,isbninf,isbnsup)+1
			else
				cantidadPrestamosEntre:=cantidadPrestamosEntre(a^.hi,isbninf,isbnsup);
		end
		else
			cantidadPrestamosEntre:=cantidadPrestamosEntre(a^.hd,isbninf,isbnsup);
	end;
end;

//INCISO J
function cantidadPrestamosEntre2(a:arbolisbn;isbninf,isbnsup:integer):integer;
begin
	if(a=nil)then
		cantidadPrestamosEntre2:=0
	else begin
		if(a^.dato.isbn>=isbninf)then begin
			if(a^.dato.isbn<=isbnsup)then
				cantidadPrestamosEntre2:=cantidadPrestamosEntre2(a^.hi,isbninf,isbnsup)+
											cantidadPrestamosEntre2(a^.hd,isbninf,isbnsup)+
												cantidadPrestamos(a^.dato.prestamos)
			else
				cantidadPrestamosEntre2:=cantidadPrestamosEntre2(a^.hi,isbninf,isbnsup);
		end
		else
			cantidadPrestamosEntre2:=cantidadPrestamosEntre2(a^.hd,isbninf,isbnsup);
	end;
end;

var
	a:arbol;
	a2:arbolisbn;
	l:listaisbn;
	ant:integer;
	l2:listaisbn;
begin
	a:=nil;
	a2:=nil;
	cargarArboles(a,a2);
	imprimira1(a);
	imprimira2(a2);
	writeln('El isbn ingresado mas grande fue: ',isbnMasGrande(a));
	writeln('El isbn mas chico ingresado fue: ',isbnMasChico(a2));
	writeln('La cantidad de prestamos del socio 403 fue de: ',prestamosDelSocio(a,403));
	writeln('La cantidad de prestamos del socio 403 fue de: -----------',prestamosDelSocio2(a2,403),' ----------');
	ant:=-1;
	l:=nil;
	incisoF(a,l,ant);
	imprimirLista(l);
	l2:=nil;
	incisoG(a2,l2);
	imprimirLista(l2);
	writeln('La cantidad de prestamos realizados entre 190 y 480 es de: ',cantidadPrestamosEntre(a,190,480));
	writeln('La cantidad de prestamos realizados entre 190 y 480 es de: ',cantidadPrestamosEntre2(a2,190,480));
end.

	
	
