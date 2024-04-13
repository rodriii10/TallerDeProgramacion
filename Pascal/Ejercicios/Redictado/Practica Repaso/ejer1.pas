{
El administrador de un edificio de oficinas, cuenta en papel, con la información del pago
de las expensas de dichas oficinas. Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se debe leer, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación -1.
b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
vistos en la cursada.
c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en b) y un código de identificación de oficina. En el caso de encontrarlo,
debe retornar la posición del vector donde se encuentra y en caso contrario debe
retornar 0. Luego el programa debe informar el DNI del propietario o un cartel
indicando que no se encontró la oficina.
d) Un módulo recursivo que retorne el monto total de las expensas.
}


program ClubHouse_MacMiller;
const
	dimF=300;
type
	oficina=record
		cod:integer;
		dni:integer;
		valor:real;
	end;
	
	oficinas=array[1..dimF]of oficina;

procedure leerOficina(var o:oficina);
begin
	with o do begin
		writeln('Ingrese codigo de identificacion');
		readln(cod);
		if(cod<>-1)then begin
			writeln('Ingrese dni del propietario');
			readln(dni);
			writeln('Ingrese el valor de la expensa');
			readln(valor);
		end;
	end;
end;

procedure cargarVector(var v:oficinas;var dimL:integer);
var
	o:oficina;
begin
	leerOficina(o);
	while(dimL<dimF)and(o.cod<>-1)do begin
		dimL:=dimL+1;
		v[dimL]:=o;
		leerOficina(o);
	end;
end;

procedure Insercion(var v:oficinas;dimL:integer);
var
	i,j:integer;
	act:oficina;
begin
	for i:=2 to dimL do begin
		act:=v[i];
		j:=i-1;
		while(j>0)and(v[j].cod>act.cod)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=act;
	end;
end;

procedure imprimirVector(v:oficinas;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		writeln('CODIGO: ',v[i].cod);
	end;
end;

procedure dicotomica(v:oficinas;dimL:integer;cod:integer;var pos:integer);
var
	fin,ini,medio:integer;
begin
	fin:=dimL;
	ini:=1;
	medio:=(ini+fin)div 2;
	while(ini<=fin)and(v[medio].cod<>cod)do begin
		if(v[medio].cod>cod)then
			fin:=medio-1
		else
			ini:=medio+1;
		medio:=(ini+fin)div 2;
	end;
	if(v[medio].cod=cod)then
		pos:=medio;
end;

function montoTotal(v:oficinas;diml:integer):real;
begin
	if(diml>0)then begin
		montoTotal:=v[diml].valor+montoTotal(v,diml-1);
	end;
end;
	

var
	v:oficinas;
	dimL:integer;
	pos:integer;
begin
	dimL:=0;
	cargarVector(v,dimL);
	insercion(v,dimL);
	imprimirVector(v,dimL);
	pos:=0;
	dicotomica(v,dimL,240,pos);
	if(pos<>-1)then
		writeln('El codigo 240 se encontro en la posicion: ',pos)
	else
		writeln('No se encontro');
	writeln('El monto total entre todas las expensas es de: ',montoTotal(v,diml):1:2);
end.
