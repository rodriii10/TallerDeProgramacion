{
Una facultad nos ha encargado procesar la información de sus alumnos de la carrera XXX.
Esta carrera tiene 30 materias. Implementar un programa con:
a. Un módulo que lea la información de los finales rendidos por los alumnos y los
almacene en dos estructuras de datos.
i. Una estructura que para cada alumno se almacenen sólo código y nota de las
materias aprobadas (4 a 10). De cada final rendido se lee el código del alumno, el
código de materia y la nota (valor entre 1 y 10). La lectura de los finales finaliza con
nota -1. La estructura debe ser eficiente para buscar por código de alumno.
ii. Otra estructura que almacene para cada materia, su código y todos los finales
rendidos en esa materia (código de alumno y nota).
b. Un módulo que reciba la estructura generada en i. y un código de alumno y retorne los
códigos y promedios de los alumnos cuyos códigos sean mayor al ingresado.
c. Un módulo que reciba la estructura generada en i., dos códigos de alumnos y un valor
entero, y retorne la cantidad de alumnos con cantidad de finales aprobados igual al
valor ingresado para aquellos alumnos cuyos códigos están comprendidos entre los
dos códigos de alumnos ingresados.
}


program facil_ara; //¿Que pasa si se lee el mismo codigo de materia
const			  //Y si leo al mismo alumno,como llevo la cuenta de las materias aprobadas?
				//Le pongo un dimL o recorro el vector pregunta si nota>=4? seria ineficiente esta ult?
				//Donde pongo la dimL? porque solo pone explicitamente que se almacene codigo y nota?
	dimF=30;
type
	materias=array[1..dimF]of real;
	
	iFinal=record
		codAlumno:integer;
		codMateria:integer;
		nota:real;
	end;
	
	alumno=record //DATO a guardar en i
		cod:integer;
		cantAprobadas:integer;//DimL para vector aprobadas
		aprobadas:materias;
	end;
	
	arbolA=^nodo;
	nodo=record
		dato:alumno;
		hi:arbolA;
		hd:arbolA;
	end;
	
	//ESTRUCTURA ii
	finalAlu=record
		codAlumno:integer;
		nota:real;
	end;
	
	lista=^nodoL;
	nodoL=record;
		dato:finalAlu;
		sig:lista;
	end;
	
	materia=record
		cod:integer;
		finales:lista;
	end;
	
	vectorMaterias=array[1..dimF]of materia;
	
	
procedure leerFinal(var f:iFinal);
begin
	with f do begin
		writeln('Ingrese nota');
		readln(nota);
		if(nota<>-1)then begin
			writeln('Ingrese codigo de alumno');
			readln(codAlumno);
			writeln('Ingrese codigo de materia');
			readln(codMateria);
		end;
	end;
end;

procedure crearAlumno(var a:alumno;f:iFinal);
begin
	a.cod:=f.codAlumno;
	if(f.nota>=4)then begin
		a.cantAprobadas:=1;
		a.aprobadas[a.cantAprobadas]:=f.nota;
	end
	else
		a.cantAprobadas:=0;
end;

procedure agregar(var a:arbolA;f:iFinal);
var
	alu:alumno;
begin
	if(a=nil)then begin
		new(a);
		crearAlumno(alu,f);
		a^.dato:=alu;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(a^.dato.cod=f.codAlumno)then begin
			if(f.nota>=4)then begin
				a^.dato.cantAprobadas:=a^.dato.cantAprobadas+1;
				a^.dato.aprobadas[a^.dato.cantAprobadas]:=f.nota;
			end;
		end
		else begin
			if(f.codAlumno<a^.dato.cod)then
				agregar(a^.hi,f)
			else
				agregar(a^.hd,f);
		end;
	end;
end;

procedure inicializarListas(var v:vectorMaterias);
var
	i:integer;
begin
	for i:=1 to dimF do
		v[i].finales:=nil;
end;

function posicion(v:vectorMaterias;dimL:integer;cod:integer):integer;
var
	i:integer;
	pos:integer;
begin
	i:=1;
	while(i<dimL)do begin
		if(v[i].cod=cod)then begin
			posicion:=i;
		i:=i+1;
	end;
	posicion:=-1;
end;

function aprobado(l:lista;cod:integer):boolean;
begin
	while(l<>nil)do begin
		if(l^.dato.cod=cod)then begin
			if(l^.dato.nota>=4)then
				aprobado:=true;
		else
			l:=l^.sig;
	end;
end;

procedure agregarVector(var v:vectorMaterias;var dimL:integer;f:iFinal);
var
	f2:finalAlu;
begin
	pos:=posicion(v,f.codMateria);
		if(pos<>-1)then begin
			if(not aprobado(v.finales,f.codAlumno)then begin//si no rindio,entra y lo agrega,si esta,pero desaprobo anteriormente,lo agrega
				pasarDatos(f2,f);
				agregarAdelante(v[pos].finales,						//Unico caso que no agrega,es si aprobo anteriormente(no puede aprobar dos veces la materia)
			end
		else begin
			v[dimL].cod:=f.codMateria;
			pasarDatos(f2,f);
			agregarAdelante(v[dimL].finales,f2);
		end;
end;

procedure cargarEstructuras(var a:arbolA;var v:vectorMaterias;var dimL:integer);
var
	f:iFinal;
	f2:finalAlu;
begin
	leerFinal(f);
	while(f.nota<>-1)do begin
		agregar(a,f);
		agregarVector(v,dimL,f)
		leerFinal(f);
	end;
end;

procedure imprimirNotas(v:materias;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		writeln('Nota ',i,' :',v[i]:1:2);
end;

procedure imprimirArbolA(a:arbolA);
begin
	if(a<>nil)then begin
		imprimirArbolA(a^.hi);
		writeln('--------ALUMNO ',a^.dato.cod,' ----------------');
		writeln('-------FINALES----------');
		imprimirNotas(a^.dato.aprobadas,a^.dato.cantAprobadas);
		imprimirArbolA(a^.hd);
	end;
end;

var
	a:arbolA;
	v:vectorMaterias;
begin
	a:=nil;
	inicializarListas(v);
	cargarEstructuras(a);
	imprimirArbolA(a);
end.
