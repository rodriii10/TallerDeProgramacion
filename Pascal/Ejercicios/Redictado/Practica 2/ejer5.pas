{
   ejer5.pas
   
   Copyright 2024 rodri <rodri@DESKTOP-VI99AUV>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}


program supposedToBe;
const
	dimF=20;
type
	vector=array[1..20]of integer;
	
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

procedure insercion(var v:vector);
var
	i,j:integer;
	act:integer;
begin
	for i:=2 to dimF do begin
		act:=v[i];
		j:=i-1;
		while(j>0)and(v[j]>act)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=act;
	end;
end;

Procedure busquedaDicotomica (v: vector; ini,fin: integer; dato:integer; var pos: integer);
var
	medio:integer;
begin
	medio:=(ini+fin)div 2;
	while(ini<=fin)and(dato<>v[medio])do begin
		if(v[medio]>dato)then
			fin:=medio-1
		else
			ini:=medio+1;
		medio:=(ini+fin)div 2;
	end;
	if(v[medio]=dato)then
		pos:=medio;
end;

var
	v:vector;
	i:integer;
	valor:integer;
	pos:integer;
begin
	randomize;
	i:=0;
	cargarVector(v,i);
	imprimir(v);
	insercion(v);
	writeln('---------');
	imprimir(v);
	writeln('Ingrese un valor que quiera buscar');
	readln(valor);
	pos:=-1;
	busquedaDicotomica(v,1,dimF,valor,pos);
	if(pos<>-1)then
		writeln('Se encontro en la posicion: ',pos)
	else
		writeln('No se encontro');
end.
		
