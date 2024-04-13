{
Realizar un programa que lea números y que utilice un módulo recursivo que escriba el
equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa
el número 0 (cero).
}


program IbaALlamarte;
procedure swap(num:integer);
begin
	if(num<>0)then begin
		swap(num div 2);
		write(num mod 2);
	end;
end;
var
	num:integer;
begin
	writeln('Ingrese un numero para tranformar a binario');
	readln(num);
	while(num<>0)do begin
		swap(num);
		writeln(' ');
		writeln('Ingrese un numero para tranformar a binario');
		readln(num);
	end;
end.
