program Auxinas;
type
	socio=record
		num:integer;
		nom:string;
		edad:integer;
	end;
	arbol=^nodo;
	nodo = record
		dato:socio;
		HI:arbol;
		HD:arbol;
	end;
procedure Leer(var s:socio);
begin
	with s do begin
		writeln('Ingrese numero de socio');
		readln(num);
		if(num<>0)then begin
			writeln('Ingrese nombre de socio');
			readln(nom);
			writeln('Ingrese edad');
			readln(edad)
		end;
	end;
end;
procedure Agregar(var a:arbol;s:socio);
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=s;
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else
		if(s.num<=a^.dato.num)then
			Agregar(a^.HI,s)
		else
			Agregar(a^.HD,s);
end;
procedure CargarA(var a:arbol);
var
	s:socio;
begin
	Leer(s);
	while(s.num<>0)do begin
		Agregar(a,s);
		Leer(s);
	end;
end;
procedure Imprimir(a:arbol);
begin
	if(a<>nil)then begin
		Imprimir(a^.HD);
		writeln(a^.dato.num);
		Imprimir(a^.HI);
	end;
end;
function MaximoSoc(a:arbol;max:integer):integer;
begin
	if(a=nil)then
		MaximoSoc:=max
	else begin
		if(a^.dato.num > max)then
			max:=a^.dato.num;
		MaximoSoc:=MaximoSoc(a^.HD,max);
	end;
end;
function NodoMinimo(a:arbol;min:integer):arbol;
begin
	if(a = nil)then
		NodoMinimo:=a
	else begin
		if(a^.dato.num < min)then
			min:=a^.dato.num;
		if(a^.HI=nil)then 
			NodoMinimo:=a
		else
			NodoMinimo:=NodoMinimo(a^.HI,min);
	end;
end;
procedure MaximaEdad(a:arbol;var maxedad,maxsoc:integer);
begin
	if(a<>nil)then begin
		MaximaEdad(a^.HI,maxedad,maxsoc);
		if(a^.dato.edad > maxedad)then begin
			maxedad:=a^.dato.edad;
			maxsoc:=a^.dato.num;
		end;
		MaximaEdad(a^.HD,maxedad,maxsoc);
	end;
end;
procedure Sumar(var a:arbol);
begin
	if(a<>nil)then begin
		Sumar(a^.HI);
		a^.dato.edad:=a^.dato.edad + 1;
		Sumar(a^.HD);
	end;
end;
function BuscarSocio(a:arbol;valor:integer;aux:boolean):boolean;
begin
	if(a=nil)then
		BuscarSocio:=aux
	else begin
		if(a^.dato.num=valor)then begin
			aux:=true;
			BuscarSocio:=aux;
		end
		else begin
			if(valor < a^.dato.num)then
				BuscarSocio:=BuscarSocio(a^.HI,valor,aux)
			else
				BuscarSocio:=BuscarSocio(a^.HD,valor,aux);
		end;
	end;
end;
procedure BuscarNombre(a:arbol;nomb:string;var aux:boolean);
begin
	if(a<>nil) and (aux<>true) then begin
		if(a^.dato.nom=nomb)then
			aux:=true
		else begin
			BuscarNombre(a^.HI,nomb,aux);
			BuscarNombre(a^.HD,nomb,aux);
			end;
	end;
end;
procedure CantSocios(a:arbol;var cant:integer);
begin
	if(a<>nil)then begin
		cant:=cant+1;
		CantSocios(a^.HI,cant);
		CantSocios(a^.HD,cant);
	end;
end;
procedure Sumaedades(a:arbol;var suma:integer);
begin
	if(a<>nil)then begin
		suma:=suma+a^.dato.edad;
		Sumaedades(a^.HI,suma);
		Sumaedades(a^.HD,suma);
	end;
end;
function Promedio(a:arbol):real;
var
	cant,suma:integer;
begin
	cant:=0;
	suma:=0;
	Sumaedades(a,suma);
	CantSocios(a,cant);
	Promedio:=suma/cant;
end;
var
	a:arbol;
	aux:boolean;
	valor:string;
	cant:integer;
begin
	a:=nil;
	CargarA(a);
	Imprimir(a);
	Promedio(a);
end.

{var
	a:arbol;
	minS:arbol;
	min:integer;
	max,maxSoc:integer;
begin
	max:=-1;
	maxSoc:=-1;
	min:=maxint;
	a:=nil;
	CargarA(a);
	Imprimir(a);
	writeln('El maximo socio es: ',MaximoSoc(a,max));
	minS:=NodoMinimo(a,min);
	writeln('El socio con minimo numero de socio es: ',minS^.dato.num,' ',minS^.dato.nom,' ',minS^.dato.edad);
	MaximaEdad(a,max,maxSoc);
	writeln('El numero de socio con mayor edad es: ',maxSoc,' de edad: ',max);
	Sumar(a);
	Imprimir(a);
	if(BuscarSocio(a,valor,aux))then
		writeln('El socio esta')
	else
		writeln('El socio no esta');
end.}
