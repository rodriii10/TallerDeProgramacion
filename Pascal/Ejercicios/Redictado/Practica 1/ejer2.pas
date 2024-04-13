{
 El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}


program FueLoMejorDelAmor;
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
			writeln('Ingrese DNI del propietario');
			readln(dni);
			writeln('Ingrese valor de la expensa');
			readln(valor);
		end;
	end;
end;

procedure cargarOficinas(var vOfi:oficinas;var dimL:integer);
var
	o:oficina;
begin
	leerOficina(o);
	while(o.cod<>-1)and(dimL<dimF)do begin
		dimL:=dimL+1;
		vOfi[dimL]:=o;
		leerOficina(o);
	end;
end;

//INCISO B
{procedure seleccion(var v:oficinas;dimL:integer);
var
	i,j,pos:integer;
	item:oficina;
begin
	for i:=1 to dimL-1 do begin
		pos:=i;
		for j:=i+1 to dimL do begin
			if(v[j].cod<v[pos].cod)then
				pos:=j;
		end;
		item:=v[pos];
		v[pos]:=v[i];
		v[i]:=item;
	end;
end;}

procedure insercion(var v:oficinas;dimL:integer);
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
		writeln('----------OFICINA ',i,' -------------------------');
		writeln('Codigo de identificacion: ',v[i].cod);
		writeln('dni del propietario: ',v[i].dni);
		writeln('Valor de la expensa: ',v[i].valor);
	end;
end;

var
	dimL:integer;
	vO:oficinas;
begin
	dimL:=0;
	cargarOficinas(vO,dimL);
	//seleccion(vO,dimL);
	insercion(vO,dimL);
	imprimirVector(vO,dimL);
end.
