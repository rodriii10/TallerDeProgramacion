program HurtFeeling;
type
	lista=^nodo;
	nodo = record
		dato:integer;
		sig:lista;
	end;
procedure AgregarAdelante(var l:lista;num:integer);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=num;
	nue^.sig:=l;
	l:=nue;
end;
procedure CargarLista(var l:lista);
var
	n:integer;
begin
	n:=abs(random(100));
	if(n <> 0)then begin
		AgregarAdelante(l,n);
		CargarLista(l);
	end;
end;
procedure Imprimir(l:lista);
begin
	if(l<>nil) then begin
		writeln(l^.dato);
		Imprimir(l^.sig);
	end;
end;
procedure Maximo(l:lista;var max:integer);
begin
	if(l<>nil)then begin
		if(l^.dato>max)then
			max:=l^.dato;
		maximo(l^.sig,max)
	end;
end;
procedure Minimo(l:lista;var min:integer);
begin
	if(l<>nil)then begin
		if(l^.dato<min)then
			min:=l^.dato;
		Minimo(l^.sig,min);
	end;
end;
function esta(l:lista;num:integer):boolean;
begin
	if(l<>nil)then begin
		if(l^.dato=num)then
			esta:=true
		else
			esta:=esta(l^.sig,num);
		end
	else
		esta:=false;
end;
			



var
	l:lista;
	max,min,num:integer;
begin
	l:=nil;
	min:=101;
	max:=-1;
	CargarLista(l);
	Imprimir(l);
	writeln('Ingrese un numero a buscar');
	readln(num);
	if(esta(l,num))then
		writeln('El numero esta')
	else
		writeln('El numero NO esta');
end.	
	
	{Maximo(l,max);
	Minimo(l,min);
	writeln('El numero maximo es: ',max);
	writeln('El numero minimo es: ',min);}
	

