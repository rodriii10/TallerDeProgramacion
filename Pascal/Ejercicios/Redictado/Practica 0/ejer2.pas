{
Implementar un programa que procese información de propiedades que están a la venta
en una inmobiliaria.
Se pide:
a) Implementar un módulo para almacenar en una estructura adecuada, las propiedades
agrupadas por zona. Las propiedades de una misma zona deben quedar almacenadas
ordenadas por tipo de propiedad. Para cada propiedad debe almacenarse el código, el tipo de
propiedad y el precio total. De cada propiedad se lee: zona (1 a 5), código de propiedad, tipo
de propiedad, cantidad de metros cuadrados y precio del metro cuadrado. La lectura finaliza
cuando se ingresa el precio del metro cuadrado -1.
b) Implementar un módulo que reciba la estructura generada en a), un número de zona y un
tipo de propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo
recibido.
}

program EsUnSecreto;
type
	rangoZona=1..5;

	propInfo=record
		zona:rangoZona;
		cod:integer;
		tipo:String;
		metrosCuadrados:integer;
		precioMetro:real;
	end;
	
	propiedad=record
		cod:integer;
		tipo:String;
		precioTotal:real;
	end;
	
	lista=^nodo;
	nodo=record
		dato:propiedad;
		sig:lista;
	end;

	vZona=array[rangoZona]of lista;
	

procedure leerPropiedad(var p:propInfo);
begin
	with p do begin
		writeln('Ingrese precio del metro cuadrado');
		readln(precioMetro);
		if(precioMetro<>-1)then begin
			writeln('Ingrese la zona de la propiedad');
			readln(zona);
			writeln('Ingrese el tipo de propiedad');
			readln(tipo);
			writeln('Ingrese el codigo de propiedad');
			readln(cod);
			writeln('Ingrese los metros cuadrados de la propiedad');
			readln(metrosCuadrados);
		end;
	end;
end;

procedure AgregarAdelante(var l:lista;p:propiedad);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=l;
	l:=nue;
end;

procedure InicializarVector(var vZ:vZona);
var
	i:integer;
begin
	for i:=1 to 5 do
		vZ[i]:=nil;
end;


procedure cargarVectoryLista(var vZ:vZona);
var
	pInfo:propInfo;
	prop:propiedad;
	tipoAct:string;
begin
	leerPropiedad(pInfo);
	while(pInfo.precioMetro<>-1)do begin
		tipoAct:=pInfo.tipo;
		while(pInfo.precioMetro<>-1)and(pInfo.tipo=tipoAct)do begin
			prop.cod:=pInfo.cod;
			prop.tipo:=pInfo.tipo;
			prop.precioTotal:=pInfo.precioMetro*pInfo.MetrosCuadrados;
			AgregarAdelante(vZ[pInfo.zona],prop);
			leerPropiedad(pInfo);
		end;
	end;
end;

procedure imprimirPropiedades(zona:integer;tipo:String;vZ:vZona);
begin
	while(vZ[zona]<>nil)and(vZ[zona]^.dato.tipo<>tipo)do
		vZ[zona]:=vZ[zona]^.sig;
	if(vZ[zona]<>nil)then begin
		while(vZ[zona]<>nil) and (vZ[zona]^.dato.tipo=tipo)do begin
			writeln('Codigo de propiedad de tipo: ',tipo,' es: ',vZ[zona]^.dato.cod);
			vZ[zona]:=vZ[zona]^.sig;
			end;
	end
	else
		writeln('No se encontro propiedades de tal tipo');
end;

var
	vZ:vZona;
	zona:integer;
	tipo:String;
begin
	InicializarVector(vZ);
	cargarVectoryLista(vZ);
	writeln('Ingrese una zona');
	readln(zona);
	writeln('Ingrese un tipo');
	readln(tipo);
	imprimirPropiedades(zona,tipo,vZ);
end.
		
	

		
	
