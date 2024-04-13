{
Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número
leído, sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo
recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 256, se debe
imprimir 2 5 6
}


program sexspace;

procedure descomponer(num:integer);
var
	dig:integer;
begin
	if(num<>0)then begin  
		descomponer(num div 10);
		dig:=num mod 10;
		write(dig,' ');
	end;
end;	

var
	num:integer;
begin
	writeln('Ingrese un numero');
	readln(num);
	while(num<>0)do begin
		descomponer(num);
		writeln('Ingrese un numero');
		readln(num);
	end;
end.
