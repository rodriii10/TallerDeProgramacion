{
Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la
información de los autos en venta. Implementar un programa que:
a) Lea la información de los autos (patente, año de fabricación (2010..2018), marca y
modelo) y los almacene en dos estructuras de datos:
i. Una estructura eficiente para la búsqueda por patente.
ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
almacenar todos juntos los autos pertenecientes a ella.
b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne
la cantidad de autos de dicha marca que posee la agencia.
c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
la cantidad de autos de dicha marca que posee la agencia.
d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
la información de los autos agrupados por año de fabricación.
e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
modelo del auto con dicha patente.
f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
modelo del auto con dicha patente. 
}

program nenasad_pablo_chill_e;
type
	rangoFabricacion=2010..2018;
	
	auto=record
		patente:string;
		anioFabricacion:rangoFabricacion;
		marca:string;
		modelo:string;
	end;
	
	arbolA=^nodoA;
	nodoA=record
		dato:auto;
		hi:arbolA;
		hd:arbolA;
	end;
	
	arbolB=^nodoB;
	nodoB=record
		dato:auto;
		hi:arbolB;
		hd:arbolB;
	end;
	
	lista=^nodo;
	nodo=record
		dato:auto;
		sig:lista;
	end;
	
	//ESTRUCTURA D
	vector=array[rangoFabricacion]of lista;
	
procedure leerAuto(var a:auto);
begin
	with a do begin
		writeln('Ingrese patente');
		readln(patente);
		if(patente<>'ZZZ')then begin
			writeln('Ingrese  anio de fabricacion');
			readln(anioFabricacion);
			writeln('Ingrese marca');
			readln(marca);
			writeln('Ingrese modelo');
			readln(modelo);
		end;
	end;
end;

procedure agregarA(var a:arbolA;au:auto);
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=au;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(au.patente=a^.dato.patente)then
			writeln('Ya existe esta patente')
		else begin
			if(au.patente<a^.dato.patente)then
				agregarA(a^.hi,au)
			else
				agregarA(a^.hd,au);
		end;
	end;
end;

procedure agregarB(var a:arbolB;au:auto);
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=au;
		a^.hd:=nil;
		a^.hd:=nil;
	end
	else begin
		if(au.marca<=a^.dato.marca)then
			agregarB(a^.hi,au)
		else
			agregarB(a^.hd,au);
	end;
end;

procedure cargarArboles(var aA:arbolA;var aB:arbolB);
var
	au:auto;
begin
	leerAuto(au);
	while(au.patente<>'ZZZ')do begin
		agregarA(aA,au);
		agregarB(aB,au);
		leerAuto(au);
	end;
end;

procedure imprimirArbolA(a:arbolA);
begin
	if(a<>nil)then begin
		imprimirArbolA(a^.hi);
		writeln('Patente: ',a^.dato.patente);
		imprimirArbolA(a^.hd);
	end;
end;

procedure imprimirArbolB(a:arbolB);
begin
	if(a<>nil)then begin
		imprimirArbolB(a^.hi);
		writeln('Marca: ',a^.dato.marca);
		imprimirArbolB(a^.hd);
	end;
end;
//INCISO B
function cantidadDeMarca(a:arbolA;marca:string):integer;
begin
	if(a=nil)then
		cantidadDeMarca:=0
	else begin
		if(a^.dato.marca=marca)then
			cantidadDeMarca:=cantidadDeMarca(a^.hi,marca)+cantidadDeMarca(a^.hd,marca)+1
		else
			cantidadDeMarca:=cantidadDeMarca(a^.hi,marca)+cantidadDeMarca(a^.hd,marca);
	end;
end;
//INCISO C
function cantidadDeMarca2(a:arbolB;marca:string):integer;
begin
	if(a=nil)then
		cantidadDeMarca2:=0
	else begin
		if(marca=a^.dato.marca)then
			cantidadDeMarca2:=cantidadDeMarca2(a^.hi,marca)+1
		else begin
			if(marca<a^.dato.marca)then
				cantidadDeMarca2:=cantidadDeMarca2(a^.hi,marca)
			else
				cantidadDeMarca2:=cantidadDeMarca2(a^.hd,marca);
		end;
	end;
end;

//INCISO D
procedure inicializarVector(var v:vector);
var
	i:rangoFabricacion;
begin
	for i:=2010 to 2018 do
		v[i]:=nil;
end;

procedure agregarAdelante(var l:lista;a:auto);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=a;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarVector(var v:vector;a:arbolA);
begin
	if(a<>nil)then begin
		agregarAdelante(v[a^.dato.anioFabricacion],a^.dato);
		cargarVector(v,a^.hi);
		cargarVector(v,a^.hd);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln('Patente: ',l^.dato.patente,', Marca: ',l^.dato.marca);
		l:=l^.sig;
	end;
end;

procedure imprimirVector(v:vector);
var
	i:rangoFabricacion;
begin
	for i:=2010 to 2018 do begin
		writeln('Autos anio: ',i);
		imprimirLista(v[i])
	end;
end;

function devolverModelo(a:arbolA;patente:string):string;
begin
	if(a=nil)then
		devolverModelo:='No Encontrado'
	else begin
		if(patente=a^.dato.patente)then
			devolverModelo:=a^.dato.modelo
		else begin
			if(patente<a^.dato.patente)then
				devolverModelo:=devolverModelo(a^.hi,patente)
			else
				devolverModelo:=devolverModelo(a^.hd,patente);
		end;
	end;
end;

function devolverModelo2(a:arbolB;patente:string):string;
begin
    if(a=nil)then
        devolverModelo2:='No se encontro'
    else begin
        if(patente=a^.dato.patente)then
            devolverModelo2:=a^.dato.modelo
        else begin
            if(a^.hi<>nil)then
                devolverModelo2:=devolverModelo2(a^.hi,patente)
            else
                devolverModelo2:=devolverModelo2(a^.hd,patente);
        end;
    end;
end;

var
	aA:arbolA;
	aB:arbolB;
	v:vector;
begin
	aA:=nil;
	aB:=nil;
	cargarArboles(aA,aB);
	imprimirArbolA(aA);
	imprimirArbolB(aB);
	writeln('La cantidad de autos renault que hay son: ',cantidadDeMarca(aA,'Renault'));
	writeln('La cantidad de autos chevrolet que hay son: ',cantidadDeMarca2(aB,'Chevrolet'));
	inicializarVector(v);
	cargarVector(v,aA);
	imprimirVector(v);
	writeln('De la patente 28D se encontro el modelo: ',devolverModelo(aA,'28D'));
	writeln('De la patente 28D se encontro el modelo: ',devolverModelo2(aB,'28D'));
end.
