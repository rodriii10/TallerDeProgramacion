program MeGustaLoSimple;
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
	writeln('Ingrese un numero para pasarlo a binario');
	readln(num);
	while(num<>0)do begin
		swap(num);
		writeln(' ');
		writeln('Ingrese un numero para pasarlo a binario');
		readln(num);
	end;
end.
