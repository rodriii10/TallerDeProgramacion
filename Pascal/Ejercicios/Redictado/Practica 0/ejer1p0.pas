{
Implementar un programa que procese la información de los alumnos de la Facultad de
Informática.
a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de
todos los alumnos. De cada alumno se lee su apellido, número de alumno, año de ingreso,
cantidad de materias aprobadas (a lo sumo 36) y el código de materia junto con la nota
obtenida (sin contar los aplazos) en cada una de las materias aprobadas. La lectura finaliza
cuando se ingresa el número de alumno 11111, el cual debe procesarse.
b) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne la
información con número de alumno y promedio de cada alumno.
c) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne la
información con número de alumno y el código y nota de la materia con mayor nota de cada
alumno.
d) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de
materias aprobadas de cada alumno, y si además se desean registrar los aplazos? ¿cómo
puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?
   
}


program SiNoLeContesto;
type
	rangoMaterias=1..36;
	
	materia=record
		cod:integer;
		nota:real;
	end;
	
	vMaterias=array[rangoMaterias]of materia;
	
	alumno=record
		ape:string;
		num:integer;
		anio:integer;
		cantAprobadas:rangoMaterias;
		materias:vMaterias;
	end;
	
	alumnoProm=record
		num:integer;
		prom:real;
	end;
	
	lista=^nodo;
	nodo=record
		dato:alumno;
		sig:lista;
	end;
	
	listaProm=^nodo2;
	nodo2=record
		dato:alumnoProm;
		sig:listaProm;
	end;
	
	//INCISO C
	
	alumnoNota=record
		num:integer;
		codMateria:integer;
		notaMax:real;
	end;
	
	lista3=^nodo3;
	nodo3=record
		dato:alumnoNota;
		sig:lista3;
	end;
	

procedure LeerAlumno(var a:alumno);
var
	i:integer;
begin
	with a do begin
		writeln('Ingrese un numero de alumno');
		readln(num);
		if(num<>11111)then begin
			writeln('Ingrese apellido del alumno');
			readln(ape);
			writeln('Ingrese año de ingreso');
			readln(anio);
			writeln('Ingrese cantidad de materias aprobadas');
			readln(cantAprobadas);
			writeln('MATERIAS');
			for i:=1 to cantAprobadas do begin
				writeln('Ingrese codigo de materia');
				readln(materias[i].cod);
				writeln('Ingrese nota');
				readln(materias[i].nota);
			end;
		end;
	end;
end;

procedure AgregarAdelante(var l:lista;a:alumno);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=a;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarLista(var l:lista);
var
	a:alumno;
begin
	LeerAlumno(a);
	while(a.num<>11111)do begin
		AgregarAdelante(l,a);
		LeerAlumno(a);
	end;
end;

function calcularPromedio(aprobadas:integer;vecMate:vMaterias):real;
var
	i:integer;
	sumaNotas:real;
begin
	sumaNotas:=0;
	for i:=1 to aprobadas do
		sumaNotas:=sumaNotas+vecMate[i].nota;
	calcularPromedio:=sumaNotas/aprobadas;
end;

procedure AgregarAdelante2(var l:listaProm;a:alumnoProm);
var
	nue:listaProm;
begin
	new(nue);
	nue^.dato:=a;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarLista2(var l2:listaProm;l:lista);
var
	a:alumnoProm;
begin
	while(l<>nil)do begin
		a.num:=l^.dato.num;
		a.prom:=calcularPromedio(l^.dato.cantAprobadas,l^.dato.materias);
		AgregarAdelante2(l2,a);
		l:=l^.sig;
	end;
end;

procedure calcularMaximaNota(var maxNota:real;var codMax:integer;aprobadas:integer;vMates:vMaterias);
var
	i:integer;
begin
	for i:=1 to aprobadas do begin
		if(vMates[i].nota>maxNota)then begin
			maxNota:=vMates[i].nota;
			codMax:=vMates[i].cod;
		end;
	end;
end;

procedure AgregarAdelante3(var l:lista3;a:alumnoNota);
var
	nue:lista3;
begin
	new(nue);
	nue^.dato:=a;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarLista3(var l3:lista3;l:lista);
var
	a:alumnoNota;
begin
	while(l<>nil)do begin
		a.num:=l^.dato.num;
		a.codMateria:=-1;
		a.notaMax:=-999;
		calcularMaximaNota(a.notaMax,a.codMateria,l^.dato.cantAprobadas,l^.dato.materias);
		AgregarAdelante3(l3,a);
		l:=l^.sig;
	end;
end;

		

{procedure ImprimirLista(l:lista);
var
	i:integer;
begin
	while(l<>nil)do begin
		writeln('Apellido : ',l^.dato.ape);
		writeln('numero de alumno: ', l^.dato.num);
		writeln('Año de ingreso: ',l^.dato.anio);
		writeln('Cantidad de materias aprobadas: ',l^.dato.cantAprobadas);
		for i:=1 to l^.dato.cantAprobadas do begin
			writeln('---Materia ',i,' ------');
			writeln('Codigo de la materia: ',l^.dato.materias[i].cod);
			writeln('Nota del alumno: ',l^.dato.materias[i].nota);
		end;
		l:=l^.sig;
	end;
end;}

{procedure ImprimirLista(l2:listaProm);
begin
	while(l2<>nil)do begin
		writeln('El numero de alumno es: ',l2^.dato.num);
		writeln('Con la nota promedio de : ',l2^.dato.prom);
		l2:=l2^.sig;
	end;
end;}

procedure ImprimirLista(l:lista3);
begin
	while(l<>nil)do begin
		writeln('El numero de alumno es: ',l^.dato.num);
		writeln('Codigo de la materia con mayor nota : ',l^.dato.codMateria);
		writeln('La nota: ',l^.dato.notaMax);
		l:=l^.sig;
	end;
end;

var
	l:lista;
	l2:listaProm;
	l3:lista3;
begin
	l:=nil;
	l2:=nil;
	l3:=nil;
	cargarLista(l);
	cargarLista2(l2,l);
	cargarLista3(l3,l);
	ImprimirLista(l3);
end.
				
