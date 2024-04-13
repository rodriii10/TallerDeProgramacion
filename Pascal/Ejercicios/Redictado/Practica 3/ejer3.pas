{
3.Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y los almacene en
una estructura de datos. De cada alumno se lee legajo, DNI, año de ingreso y los códigos y
notas de los finales rendidos. La estructura generada debe ser eficiente para la búsqueda por
número de legajo. La lectura de los alumnos finaliza con legajo 0 y para cada alumno el ingreso
de las materias finaliza con el código de materia -1.
b. Un módulo que reciba la estructura generada en a. y retorne los DNI y año de ingreso de  // es una lista??
aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.
c. Un módulo que reciba la estructura generada en a. y retorne el legajo más grande. 
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
e. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del
alumno con mayor promedio.
f. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.
}


program irresponsables_babasonicos;
type
	materia=record
		cod:integer;
		nota:real;
	end;
	
	lista=^nodo;
	nodo=record
		dato:materia;
		sig:lista;
	end;
	
	alumno=record
		legajo:integer;
		dni:integer;
		anioIngreso:integer;
		materias:lista;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:alumno;
		hi:arbol;
		hd:arbol;
	end;
	
	alumno2=record
		dni:integer;
		anio:integer;
	end;
	
	lista2=^nodoB;
	nodoB=record
		dato:alumno2;
		sig:lista2;
	end;
	

procedure leerMateria(var m:materia);
begin
	with m do begin
		writeln('Ingrese codigo de materia');
		readln(cod);
		if(cod<>-1)then begin
			writeln('Ingrese nota');
			readln(nota);
		end;
	end;
end;

procedure agregarAdelante(var l:lista;m:materia);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=m;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarMaterias(var l:lista);
var
	m:materia;
begin
	leerMateria(m);
	while(m.cod<>-1)do begin
		agregarAdelante(l,m);
		leerMateria(m);
	end;
end;

procedure leerAlumno(var a:alumno);
begin
	with a do begin
		writeln('Ingrese legajo del alumno');
		readln(legajo);
		if(legajo<>0)then begin
			writeln('Ingrese dni del alumno');
			readln(dni);
			writeln('Ingrese año de ingreso');
			readln(anioIngreso);
			materias:=nil;
			cargarMaterias(materias);
		end;
	end;
end;
	
procedure agregar(var a:arbol;alu:alumno);
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=alu;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(a^.dato.legajo=alu.legajo)then
			a^.dato:=alu
		else begin
			if(alu.legajo<=a^.dato.legajo)then
				agregar(a^.hi,alu)
			else
				agregar(a^.hd,alu);
		end;
	end;
end;

procedure cargarArbol(var a:arbol);
var
	alu:alumno;
begin
	leerAlumno(alu);
	while(alu.legajo<>0)do begin
		agregar(a,alu);
		leerAlumno(alu);
	end;
end;

procedure imprimirMaterias(l:lista);
begin
	while(l<>nil)do begin
		writeln('---Materia : ',l^.dato.cod);
		writeln('Nota: ',l^.dato.nota:1);
		l:=l^.sig;
	end;
end;

procedure imprimir(a:arbol);
begin
	if(a<>nil)then begin
		imprimir(a^.hi);
		writeln('ALUMNO--------------------------------------');
		writeln('legajo de alumno: ',a^.dato.legajo);
		writeln('--------------MATERIAS-----------------------');
		imprimirMaterias(a^.dato.materias);
		imprimir(a^.hd);
	end;
end;


//INCISO B
procedure agregarAdelante2(var l:lista2;a:alumno2);
var
	nue:lista2;
begin
	new(nue);
	nue^.dato:=a;
	nue^.sig:=l;
	l:=nue;
end;

procedure legajoInferiorA(a:arbol;var l:lista2;leg:integer);
var
	alu:alumno2;
begin
	if(a<>nil)then begin
		if(leg<=a^.dato.legajo)then
			legajoInferiorA(a^.hi,l,leg)
		else begin
			alu.dni:=a^.dato.dni;
			alu.anio:=a^.dato.anioIngreso;
			agregarAdelante2(l,alu);
			legajoInferiorA(a^.hi,l,leg);
			legajoInferiorA(a^.hd,l,leg);
		end;
	end;
end;

procedure imprimirLista(l:lista2);
begin
	while(l<>nil)do begin
		writeln('-----------------------');
		writeln('DNI >',l^.dato.dni);
		writeln('Anio>',l^.dato.anio);
		l:=l^.sig;
	end;
end;

//INCISO C

function legajoMasGrande(a:arbol):integer;
begin
	if(a=nil)then
		legajoMasGrande:=0
	else begin
		if(a^.hd<>nil)then
			legajoMasGrande:=legajoMasGrande(a^.hd)
		else
			legajoMasGrande:=a^.dato.legajo;
	end;
end;

//INCISO D
procedure maximoDni(a:arbol;var max:integer);
begin
	if(a<>nil)then begin
		if(a^.dato.dni>max)then
			max:=a^.dato.dni;
		maximoDni(a^.hi,max);
		maximoDni(a^.hd,max);
	end;
end;

//INCISO E
function legajosImpares(a:arbol):integer;
begin
	if(a=nil)then
		legajosImpares:=0
	else begin
		if((a^.dato.legajo mod 2)<>0)then
			legajosImpares:=legajosImpares(a^.hi)+legajosImpares(a^.hd)+1
		else
			legajosImpares:=legajosImpares(a^.hi)+legajosImpares(a^.hd)+0
	end;
end;

//INCISO F
function calcularPromedio(l:lista):real;
var
	total:real;
	cantMaterias:integer;
begin
	total:=0;
	cantMaterias:=0;
	while(l<>nil)do begin
		total:=total+l^.dato.nota;
		cantMaterias:=cantMaterias+1;
		l:=l^.sig;
	end;
	calcularPromedio:=total/cantMaterias;
end;

procedure legajoMayorPromedio(a:arbol;var legMax:integer;var promMax:real);
var
	prom:real;
begin
	if(a<>nil)then begin
		prom:=calcularPromedio(a^.dato.materias);
		if(prom>promMax)then begin
			promMax:=prom;
			legMax:=a^.dato.legajo;
		end;
		legajoMayorPromedio(a^.hi,legMax,promMax);
		legajoMayorPromedio(a^.hd,legMax,promMax);
	end;
end;

procedure promedioMayoresA(a:arbol;promMayor:real);
var
	prom:real;
begin
	if(a<>nil)then begin
		prom:=calcularPromedio(a^.dato.materias);
		if(prom>promMayor)then begin
			writeln('----------');
			writeln('Legajo: ',a^.dato.legajo);
			writeln('Promedio: ',prom);
		end;
		promedioMayoresA(a^.hi,promMayor);
		promedioMayoresA(a^.hd,promMayor);
	end;
end;

var
	a:arbol;
	leg:integer;
	l:lista2;
	maxDni:integer;
	legMax:integer;
	promMax:real;
	prom:real;
begin
	a:=nil;
	cargarArbol(a);
	imprimir(a);
	{writeln('Ingrese un legajo');
	readln(leg);
	l:=nil;
	legajoInferiorA(a,l,leg);
	imprimirLista(l);
	writeln('El legajo mas grande es: ',legajoMasGrande(a));
	maxDni:=-1;
	maximoDni(a,maxDni);
	writeln('El dni mas grande encontrado fue: ',maxDni);
	writeln('Cantidad de legajos impares: ',legajosImpares(a));}
	legMax:=-1;
	promMax:=-1;
	legajoMayorPromedio(a,legMax,promMax);
	writeln('El legajo con mayor promedio es: ',legMax,' con Promedio de: ',promMax:1:2);
	writeln('Ingrese un promedio');
	readln(prom);
	promedioMayoresA(a,prom);// SE guardaba en una lista aparte
end.
