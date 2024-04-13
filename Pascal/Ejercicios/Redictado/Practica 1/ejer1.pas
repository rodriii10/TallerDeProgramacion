{
Se desea procesar la información de las ventas de productos de un comercio (como máximo
50).
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce
el día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99
unidades). El código debe generarse automáticamente (random) y la cantidad se debe leer. El
ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos
valores que se ingresan como parámetros.
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a
mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).
}


program TratameSuavemente;
const
	dimF=50;
type
	rangoProducto=1..15;
	rangoCantidad=1..99;
	venta=record
		dia:integer;
		cod:rangoProducto;
		cantVendida:rangoCantidad;
	end;
	
	vector=array[1..dimF]of venta;
	vPares=array[1..dimF]of venta;
//INCISO A
procedure leerVenta(var v:venta);
begin
	with v do begin
		Randomize;
		writeln('----------VENTA-------------');
		writeln('Ingrese el dia de la venta');
		readln(dia);
		if(dia<>0)then begin
			cod:=random(15)+1;
			writeln('Codigo generado: ',cod);
			writeln('Ingrese cantidad vendida');
			readln(cantVendida);
		end;
	end;
end;

procedure cargarVector(var v:vector;var dimL:integer);
var
	ven:venta;
begin
	leerVenta(ven);
	while(ven.dia<>0)and(dimL<dimF)do begin
		dimL:=dimL+1;
		v[dimL]:=ven;
		leerVenta(ven);
	end;
end;

//INCISO C
procedure Seleccion(var v:vector;dimL:integer);
var
	i,j,pos:integer;
	item:venta;
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
end;

//INCISO E		
procedure eliminarEntre(var v:vector;var dimL:integer;valorInf,valorSup:integer);
var
	ini,fin,i:integer;
	aBorrar:integer;
begin
	ini:=1;
	while(ini<=dimL)and(v[ini].cod<valorInf)do
		ini:=ini+1;
	fin:=ini;
	while(fin<=dimL)and(v[fin].cod<=valorSup)do
		fin:=fin+1;
	aBorrar:=fin-ini;
	if(aBorrar>0)then begin
		for i:=fin to dimL do begin
			v[ini]:=v[i];
			ini:=ini+1;
		end;
		dimL:=dimL-aBorrar;
	end;
end;
			

//INCISO G
function esPar(num:integer):boolean;
begin
	esPar:=((num mod 2)=0);
end;

procedure codigosPares(var vP:vPares;v:vector;dimL:integer;var dimL2:integer);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		if(esPar(v[i].cod))then begin
			dimL2:=dimL2+1;
			vP[dimL2]:=v[i];
		end;
	end;
end;

//INCISO B,D,F
procedure imprimirVector(v:vector;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		writeln('-----VENTA ',i,' ------------------');
		writeln('Dia de la venta: ',v[i].dia);
		writeln('Codigo del producto: ',v[i].cod);
		writeln('Cantidad vendida: ',v[i].cantVendida);
	end;
end;

procedure imprimirVectorPares(v:vPares;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		writeln('-----VENTA ',i,' ------------------');
		writeln('Dia de la venta: ',v[i].dia);
		writeln('Codigo del producto: ',v[i].cod);
		writeln('Cantidad vendida: ',v[i].cantVendida);
	end;
end;



var
	dimL:integer;
	v:vector;
	vP:vPares;
	dimL2:integer;
begin
	dimL:=0;
	dimL2:=0;
	cargarVector(v,dimL);
	seleccion(v,dimL);
	codigosPares(vP,v,dimL,dimL2);
	imprimirVector(vP,dimL2);
end.

