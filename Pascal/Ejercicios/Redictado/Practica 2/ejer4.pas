{
Escribir un programa con:
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y
menores a 100.
b. Un módulo recursivo que devuelva el máximo valor del vector.
c. Un módulo recursivo que devuelva la suma de los valores contenidos en el vector.
}


program Ferrari;
const
	dimF=3;
type
	vector=array[1..20]of integer;
	
//INCISO A
procedure cargarVector(var v:vector;i:integer);
var
	num:integer;
begin
	num:=random(100);
	if(i<dimF)then begin
		i:=i+1;
		v[i]:=num;
		cargarVector(v,i);
	end;
end;

procedure imprimir(v:vector);
var
	i:integer;
begin
	for i:=1 to dimF do
		writeln(v[i]);
end;

//INCISO B
function maximoValor(v:vector;max:integer;i:integer):integer;
begin
	if(i<dimF)then begin
		i:=i+1;
		if(v[i]>max)then
			max:=v[i];
		maximoValor:=maximoValor(v,max,i);
	end
	else
		maximoValor:=max;
end;

//INCISO C
function sumaVector(v:vector;i:integer):integer;
begin
	if(i<dimF)then begin
		i:=i+1;
		sumaVector:=sumaVector(v,i)+v[i];
	end
	else
		sumaVector:=0;
end;

var
	v:vector;
	i:integer;
	max:integer;
begin
	randomize;
	max:=0;
	i:=0;
	cargarVector(v,i);
	imprimir(v);
	writeln('El maximo valor del vector es : ',maximoValor(v,max,i));
	writeln('La suma de los valores del vector es: ',sumaVector(v,i));
end.
