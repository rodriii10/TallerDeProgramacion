program AmigosNuevos;
function descomponer(num:integer):integer;
var
	digito:integer;
begin
	if(num<>0)then begin
		digito:=num mod 10;
		num:=num div 10;
		descomponer:=descomponer(num);
		write(digito,' ');
	end;
end;

var
	num:integer;
begin
	writeln('Ingrese un numero');
	readln(num);
	while(num<>0)do begin
		descomponer(num);
		readln(num); 
	end;
end.

