program aTuMerced;
type
	dias=1..31;
	meses=1..12;
	
	prestamo=record   {registro prestamo}
		isbn:integer;
		num:integer;
		dia:dias;
		mes:meses;
		cant:integer;
	end;
	
	prestamoSinISBN=record {para no repetir ISBN en cada elemento de la lista}
		num:integer;
		dia:dias;
		mes:meses;
		cant:integer
	end;
	
	aPrestamo= ^nodoP; {arbol de prestamo}
	nodoP=record
		dato:prestamo;
		hi:aPrestamo;
		hd:aPrestamo;
	end;
	
	
	listaP=^nodoL; {lista de prestamos guiada por ISBN}
	nodoL=record
		dato:prestamoSinISBN;
		sig:listaP;
	end;
	
	aISBN=^nodoA; {Arbol de prestamos sin isbn}
	nodoA=record
		isbn:integer;
		dato:listaP;
		hi:aISBN;
		hd:aISBN;
	end;
	
	numeroISBN=record
		isbn:integer;
		cant:integer;
	end;
	
	listaISBN=^nodoISBN; {Inciso F}
	nodoISBN=record
		dato:numeroISBN;
		sig:listaISBN;
	end;
	
procedure leerPrestamo(var p:prestamo);        {Leo el prestamo}
begin
	with p do begin
		writeln('---------------------------------------------');
		writeln('Ingrese ISBN');
		readln(isbn);
		if(isbn<>-1)then begin
			writeln('Ingrese numero de socio');
			readln(num);
			writeln('Ingrese dia');
			readln(dia);
			writeln('Ingrese mes');
			readln(mes);
			writeln('Ingrese cantidad de dias prestados');
			readln(cant);
			writeln('---------------------------------------');
		end;
	end;
end;

procedure agregarAP(var a:aPrestamo;p:prestamo); {Proceso para cargar el arbol de prestamos}
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=p;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(p.isbn <= a^.dato.isbn)then
			agregarAP(a^.hi,p)
		else
			agregarAP(a^.hd,p);
	end;
end;
procedure agregarALista(var l:listaP;p:prestamoSinISBN);  {Agrego a la lista de cada nodo del arbol}
var
	nue:listaP;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=l;
	l:=nue;
end;
procedure pasarSinIsbn(var pIsbn:prestamoSinISBN;p:prestamo); {Proceso para pasar prestamo a otro registro prestamo pero sin ISBN}
begin                                                        
	pIsbn.num:=p.num;
	pIsbn.dia:=p.dia;
	pIsbn.mes:=p.mes;
	pIsbn.cant:=p.cant;
end;
procedure agregarAI(var a:aISBN;pI:prestamoSinISBN;p:prestamo); {Cargo el arbol de listas}
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=nil;
		a^.hi:=nil;
		a^.hd:=nil;
		a^.isbn:=p.isbn;
		pasarSinIsbn(pI,p);  {Podria haberlo pasado afuera de la carga}
		agregarALista(a^.dato,pI);
	end
	else begin
		if(p.isbn=a^.isbn)then begin
			pasarSinIsbn(pI,p);
			agregarALista(a^.dato,pI);
		end
		else begin
			if(p.isbn < a^.isbn)then
				agregarAI(a^.hi,pI,p)
			else
				agregarAi(a^.hd,pI,p);
		end;
	end;
end;

procedure cargarArboles(var aP:aPrestamo;var aI:aISBN);
var
	pI:prestamoSinISBN;
	p:prestamo;
begin
	leerPrestamo(p);
	while(p.isbn<>-1)do begin
		agregarAP(aP,p);
		agregarAI(aI,pI,p); {Podria pasar aca la carga de los registros prestamo para evitar q tire error de inicializacio pero igual funciona}
		leerPrestamo(p);
	end;
end;
procedure imprPrestamo(p:prestamo);  {Proceso para imprimir el registro}
begin
	writeln('------------------------------------');
	writeln('El ISBN del libro es: ',p.isbn);
	writeln('El numero de socio es: ',p.num);
	writeln('Fue prestado el dia: ',p.dia,' del mes: ',p.mes);
	writeln('Cantidad de dia prestados: ',p.cant);
	writeln('----------------------------------------');
end;
procedure imprimirAP(aP:aPrestamo); {Proceso para imprimir el arbol de prestamos}
begin
	if(aP<>nil)then begin
		imprimirAP(aP^.HI);
		imprPrestamo(aP^.dato);
		imprimirAP(aP^.HD);
	end;
end;
procedure imprLista(l:listaP;isbn:integer); {Proceso para imprimir la lista de cada nodo del arbol}
begin
	writeln('----ISBN = ',isbn);
	while(l<>nil)do begin
		writeln('-----------------------------------');
		writeln('El numero de socio es: ',l^.dato.num);
		writeln('Fue prestado el dia: ',l^.dato.dia,' del mes: ',l^.dato.mes);
		writeln('Cantidad de dias prestados: ',l^.dato.cant);
		writeln('-----------------------------------');
		l:=l^.sig;
	end;
end;
procedure imprimirAI(aI:aISBN);  {Proceso para imprimir arbol de lista}
begin
	if(aI<>nil)then begin
		imprimirAI(aI^.hi);
		imprLista(aI^.dato,aI^.isbn);
		imprimirAI(aI^.hd);
	end;
end;
function maximoISBN(aP:aPrestamo):integer; {Proceso para sacar maximo isbn de ap}
begin
	if(aP^.hd=nil)then
		maximoISBN:=aP^.dato.isbn
	else
		maximoISBN:=maximoISBN(aP^.hd);
end;
function minimoISBN(aI:aISBN):integer; {Proceso para sacar maximo isbn de ap}
begin
	if(aI^.hi=nil)then
		minimoISBN:=aI^.isbn
	else
		minimoISBN:=minimoISBN(aI^.hi);
end;
function cantidadPrestamos(aP:aPrestamo;num:integer):integer; {Proceso para sacar cantidad de prestamos de x numero de socio}
begin
	if(aP=nil)then
		cantidadPrestamos:=0
	else begin
		if(num=aP^.dato.num)then
			cantidadPrestamos:=1+cantidadPrestamos(aP^.hi,num)+cantidadPrestamos(aP^.hd,num)
		else
			cantidadPrestamos:=0+cantidadPrestamos(aP^.hi,num)+cantidadPrestamos(aP^.hd,num);
	end;
end;
function cantEnLista(l:listaP;num:integer):integer; {Proceso para recorrer la lista y suma una cantidad}
var
	cant:integer;
begin
	cant:=0;
	while(l<>nil)do begin
		if(l^.dato.num=num)then
			cant:=cant+1;
		l:=l^.sig;
	end;
	cantEnLista:=cant;
end;
procedure cantidadPrestamos(aI:aISBN;num:integer;var cant:integer); {Proceso para ver la cantidad de prestamos en el arbol isbn}
begin
	if(aI<>nil)then begin
		cantidadPrestamos(aI^.hi,num,cant);
		cant:=cant+cantEnLista(aI^.dato,num);
		cantidadPrestamos(aI^.hd,num,cant);
	end;
end;
procedure agregarAtras(var l:listaISBN;isbn:integer);
var
	libro:numeroISBN;
	ant,act,nue: listaISBN;
begin
	ant:=l;
	act:=l;
	new(nue);
	libro.cant:=1;
	libro.isbn:=isbn;
	nue^.dato:=libro;
	while(act<>nil)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant)then 
		l:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
function buscarNodo(l:listaISBN;isbn:integer):listaISBN;
begin
	if(l=nil)then
		buscarNodo:=nil
	else begin
		if(l^.dato.isbn=isbn)then
			buscarNodo:=l
		else
			buscarNodo:=buscarNodo(l^.sig,isbn);
	end;
end;
procedure moduloF(aP:aPrestamo;var l:listaISBN);
var
	aux:listaISBN;
begin
	if(aP<>nil)then begin
		moduloF(aP^.hi,l);
		if(l=nil)then
			agregarAtras(l,aP^.dato.isbn)
		else begin
			aux:=buscarNodo(l,aP^.dato.isbn);
			if(aux<>nil)then
				aux^.dato.cant:=aux^.dato.cant+1
			else
				agregarAtras(l,aP^.dato.isbn);
		end;
		moduloF(aP^.hd,l);
	end;
end;
procedure ImprimirLista(l:listaISBN);
begin
	while(l<>nil)do begin
		writeln('--------------------------------');
		writeln('ISBN: ',l^.dato.isbn);
		writeln('Cantidad de veces prestado: ',l^.dato.cant);
		writeln('--------------------------------');
		l:=l^.sig;
	end;
end;
function cantQueSePresto(l:listaP):integer;
begin
	if(l=nil)then
		cantQueSePresto:=0
	else
		cantQueSePresto:=1+cantQueSePresto(l^.sig);
end;
procedure agregarAdelante(var l:listaISBN;libro:numeroISBN);
var
	nue:listaISBN;
begin
	new(nue);
	nue^.dato:=libro;
	nue^.sig:=l;
	l:=nue;
end;
procedure moduloG(aI:aISBN;l:listaISBN);
var
	libro:numeroISBN;
begin
	if(aI<>nil)then begin
		moduloG(aI^.hi,l);
		libro.isbn:=aI^.isbn;
		libro.cant:=cantQueSePresto(aI^.dato);
		agregarAdelante(l,libro);
		moduloG(aI^.hd,l);
	end;
end;
var
	aI:aISBN;
	aP:aPrestamo;
	num:integer;
	cant:integer;
	l:listaISBN;
	l2:listaISBN;
begin
	aI:=nil;
	aP:=nil;
	l:=nil;
	l2:=nil;
	cargarArboles(aP,AI);
	writeln('----ARBOL DE PRESTAMOS----------');
	imprimirAP(aP);
	writeln('-------ARBOL DE ISBN----------');
	imprimirAI(aI);
	{writeln('Maximo ISBN es: ',maximoISBN(aP)); Inciso B
	writeln('Minimo ISBN es: ',minimoISBN(aI)); Inciso C
	writeln('Ingrese un numero de socio');
	readln(num);
	cant:=0;
	writeln('El numero de socio: ',num,' tiene ',cantidadPrestamos(aP,num),' de prestamos');Inciso D
	cantidadPrestamos(aI,num,cant);
	writeln('El numero de socio: ',num,' tiene ',cant,' prestamos realizados'); Inciso E}
	{moduloF(aP,l);
	ImprimirLista(l);}
	moduloG(aI,l2);
	ImprimirLista(l2);
end.




