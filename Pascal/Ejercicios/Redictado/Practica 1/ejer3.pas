{
  Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1.
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c).
}


program Intoxicados;
type
	rangoGenero=1..8;
	pelicula=record
		cod:integer;
		codGen:rangoGenero;
		puntaje:real;
	end;
	
	lista=^nodo;
	nodo=record
		dato:pelicula;
		sig:lista;
	end;
	
	
	generos=array[rangoGenero]of lista;
	puntajes=array[rangoGenero]of pelicula;
	
procedure leerPelicula(var p:pelicula);
begin
	with p do begin
		writeln('Ingrese codigo de pelicula');
		readln(cod);
		if(p.cod<>-1)then begin
			writeln('Ingrese codigo de genero entre 1-8');
			readln(codGen);
			writeln('Ingrese puntaje promedio otorgado por las criticas');
			readln(puntaje);
		end;
	end;
end;

procedure agregarAtras(var l:lista;p:pelicula);
var
	nue,aux:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=nil;
	if(l=nil)then
		l:=nue
	else begin
		aux:=l;
		while(aux^.sig<>nil)do
			aux:=aux^.sig;
		aux^.sig:=nue;
	end;
end;

procedure inicializarVector(var v:generos);
var
	i:integer;
begin
	for i:=1 to 8 do
		v[i]:=nil;
end;

procedure cargarVectorListas(var v:generos);
var
	p:pelicula;
begin
	leerPelicula(p);
	while(p.cod<>-1)do begin
		agregarAtras(v[p.codGen],p);
		leerPelicula(p);
	end;
end;

//INCISO B
procedure calcularMaximo(l:lista;max:real;var vP:puntajes;i:integer);
begin
	while(l<>nil)do begin
		if(l^.dato.puntaje>max)then begin
			max:=l^.dato.puntaje;
			vP[l^.dato.codGen]:=l^.dato;
		end;
		l:=l^.sig;
	end;
end;

procedure recorrer(v:generos;var vP:puntajes);
var
	i:integer;
	max:real;
begin
	for i:=1 to 8 do begin
		max:=-1;
		calcularMaximo(v[i],max,vP,i);
	end;
end;

procedure Insercion(var vP:puntajes);
var
	i,j:integer;
	act:pelicula;
begin
	for i:=2 to 8 do begin
		act:=vP[i];
		j:=i-1;
		while(j>0)and(vP[j].puntaje>act.puntaje)do begin
			vP[j+1]:=vP[j];
			j:=j-1;
		end;
		vP[j+1]:=act;
	end;
end;


{procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln('Codigo de pelicula: ',l^.dato.cod);
		l:=l^.sig;
	end;
end;

procedure imprimirVector(v:generos);
var
	i:integer;
begin
	for i:=1 to 8 do
		imprimirLista(v[i]);
end;}

procedure imprimirVector(v:puntajes);
var
	i:integer;
begin
	for i:=1 to 8 do begin
		writeln('Codigo de pelicula: ',v[i].cod);
		writeln('Genero : ',v[i].codGen);
		writeln('Puntaje : ',v[i].puntaje:1:2);
	end;
end;

procedure minimoymax(vP:puntajes;var pMin,pMax:integer);
var
	i:integer;
begin
	i:=1;
	while(i<8)and(vP[i].puntaje=0)do 
		i:=i+1;
	if(i<8)then begin
		pMin:=i;
		pMax:=8;
	end
	else begin
		pMin:=i;
		pMax:=i;
	end;
end;

var
	v:generos;
	vP:puntajes;
	posMax:integer;
	posMin:integer;
begin
	inicializarVector(v);
	cargarVectorListas(v);
	//imprimirVector(v);
	recorrer(v,vP); //INCISO B
	Insercion(vP); //INCISO C
	minimoymax(vP,posMin,posMax);
	imprimirVector(vP);
	writeln('El codigo con menor puntaje es: ',vP[posMin].cod);
	writeln('El codigo con mayor puntaje es: ',vP[posMax].cod);
end.

		
