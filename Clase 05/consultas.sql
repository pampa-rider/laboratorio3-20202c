Use MonkeyUniv
-- Cross Join
Select DAT.Apellidos, P.Nombre From Datos_Personales as DAT
Cross Join Paises as P

Use MonkeyUniv
-- (1) Listado con nombre de usuario de todos los usuarios y sus respectivos nombres y apellidos.
 

Select  Usuarios.NombreUsuario,
        Datos_Personales.Apellidos,
        Datos_Personales.Nombres
From Usuarios
Inner Join Datos_Personales ON Usuarios.ID = Datos_Personales.ID

Select U.NombreUsuario, DAT.Apellidos, DAT.Nombres, DAT.Email
From Usuarios as U
Inner Join Datos_Personales as DAT ON U.ID = DAT.ID

-- Lo que realiza la cláusula join en memoria
Select *
From Usuarios as U
Inner Join Datos_Personales as DAT ON U.ID = DAT.ID


 --@pampa_rider
 	select Usuarios.NombreUsuario,Datos_Personales.Nombres,Datos_Personales.Apellidos from Usuarios
 	inner join Datos_Personales on Usuarios.ID = Datos_Personales.ID


-- 2 Listado con apellidos, nombres, fecha de nacimiento y nombre del país de nacimiento. 
 	
 	select Data.Apellidos,Data.Nombres,P.Nombre from Datos_Personales AS Data
    inner join Paises as P on Data.IDPais = P.ID 

-- (3) Listado con nombre de usuario, apellidos, nombres, email o celular de todos los usuarios que vivan en una domicilio cuyo 

Select U.NombreUsuario, DAT.Apellidos, DAT.Nombres, isnull(DAT.Email, DAT.Celular) as InfoContacto, DAT.Domicilio
From Usuarios AS U
Inner Join Datos_Personales as DAT ON U.ID = DAT.ID
Where Dat.Domicilio like '%Presidente%' or Dat.Domicilio like '%General%'


--@pampa_rider	
	select U.NombreUsuario,D.Apellidos,D.Nombres,D.Celular,D.Email,D.Domicilio from Datos_Personales as D
    inner join Usuarios as U on D.ID = U.ID where D.Domicilio LIKE '%Presidente%' OR D.Domicilio LIKE'%General%'

-- 4 Listado con nombre de usuario, apellidos, nombres, email o celular o domicilio como 'Información de contacto'.  NOTA: Si no tiene email, obtener el celular y si no posee celular obtener el domicilio.
	
	select D.Nombres,D.Apellidos,D.Celular,D.email,D.Domicilio from Datos_Personales as D
   
-- (5) Listado con apellido y nombres, nombre del curso y costo de la inscripción de todos los usuarios inscriptos a cursos.  NOTA: No deben figurar los usuarios que no se inscribieron a ningún curso.

select C.Nombre, DAT.Apellidos, DAT.Nombres, I.Costo
From Cursos as C
Inner Join Inscripciones as I ON C.ID = I.IDCurso
Inner Join Usuarios as U ON U.ID = I.IDUsuario
Inner Join Datos_Personales as DAT ON DAT.ID = U.ID
Order by C.Nombre asc, Dat.Apellidos asc, DAT.Nombres Asc

-- Ejemplo de Union
select DAT.Apellidos, DAT.Nombres, 'Estudiante' as Rol
From Cursos as C
Inner Join Inscripciones as I ON C.ID = I.IDCurso
Inner Join Usuarios as U ON U.ID = I.IDUsuario
Inner Join Datos_Personales as DAT ON DAT.ID = U.ID
Where C.ID = 11
Union All
select DAT.Apellidos, DAT.Nombres, 'Instructor' as Rol
From Cursos as C
Inner Join Instructores_x_Curso as IxC on IxC.IDCurso = C.ID
Inner Join Usuarios as U ON U.ID = IxC.IDUsuario
Inner Join Datos_Personales as DAT ON DAT.ID = U.ID
Where C.ID = 11



--@pampa_rider
	select C.Nombre,D.Apellidos,D.Nombres,I.Costo from Cursos as C 
    inner join Inscripciones as I on C.ID = I.IDCurso
    inner join Usuarios as U on  U.ID = I.IDUsuario
    inner join Datos_Personales as D on  D.ID=U.ID    
    order by C.Nombre asc,D.Apellidos asc, D.Nombres asc
   

-- 6 Listado con nombre de curso, nombre de usuario y mail de todos los inscriptos a cursos que se hayan estrenado en el año 2020.
		
	select C.Nombre,I.Costo,U.Nombreusuario,D.Email from Cursos as C 
    inner join Inscripciones as I on C.ID = I.IDCurso
    inner join Usuarios as U on  U.ID = I.IDUsuario
    inner join Datos_Personales as D on I.IDUsuario = D.ID
    Where year(C.Estreno)='2020'
    order by C.Nombre asc

-- 7 Listado con nombre de curso, nombre de usuario, apellidos y nombres, fecha de inscripción, costo de inscripción, fecha de pago e importe de pago. Sólo listar información de aquellos que hayan pagado.

 	select U.Nombreusuario,D.Apellidos,D.Nombres,
    I.Fecha as FECHA_ISC,I.costo,
    P.fecha AS FECHA_PAGO,
    P.Importe from Usuarios as U

    inner join Datos_Personales as D on U.ID = D.ID
    inner join Inscripciones as I on D.ID = I.IDUsuario
    inner join Pagos as P on I.ID = P.IDInscripcion
    where I.Costo = P.Importe 

-- 8 Listado con nombre y apellidos, genero, fecha de nacimiento, mail, nombre del curso y fecha de certificación de todos aquellos usuarios que se hayan certificado.

  	select D.Nombres,D.Apellidos,D.Genero,
    D.Nacimiento,
    D.Email,CT.Fecha,
    C.Nombre as Nombre_Curso,
    CT.Fecha as Fecha_Cert 
    from Datos_Personales as D

    inner join Inscripciones as I on D.ID = I.IDUsuario
    inner join Cursos as C on I.IDCurso = C.ID
    inner join Certificaciones as CT on I.ID = CT.IDInscripcion
   

-- 9 Listado de cursos con nombre, costo de cursado y certificación, costo total (cursado + certificación) con 10% de todos los cursos de nivel Principiante.

	select C.Nombre,C.CostoCurso,
    C.CostoCertificacion,
    ((C.CostoCurso+CostoCertificacion) * 0.9) as CostoTotal
    from Cursos as C
    where IDNivel=5

-- 10 Listado con nombre y apellido y mail de todos los instructores. Sin repetir.
 	
 	select distinct IC.IDUsuario,D.Nombres,D.Apellidos,D.Email from Instructores_x_Curso as IC
    inner join Datos_Personales as D on IC.IDUsuario = D.ID

-- 11 Listado con nombre y apellido de todos los usuarios que hayan cursado algún curso cuya categoría sea 'Historia'.    
    	select distinct Dat.Apellidos,Dat.Nombres From Datos_Personales as DAT
    	Inner Join Usuarios as U on U.ID=DAT.ID
    	Inner Join Inscripciones as I on U.ID = I.IDUsuario
    	Inner Join Cursos as C on C.ID = I.IDCurso
    	Inner Join Categorias_x_Curso as CxC on C.ID = CxC.IDCurso
    	Inner Join Categorias as CAT on CAT.ID = CxC.IDCategoria
    	Where CAT.Nombre='Historia'
    	Order by DAT.Apellidos

--@pampa_rider
    select D.Nombres,D.Apellidos,I.IDCurso from Cursos as C 
    Inner join Inscripciones as I on C.ID = I.IDCurso 
    Inner join Datos_Personales as D on I.IDUsuario = D.ID
    where Nombre LIKE '%historia%'

-- (12) Listado con nombre de idioma, código de curso y código de tipo de idioma. Listar todos los idiomas indistintamente si no tiene cursos relacionados.
Select I.Nombre, IxC.IDCurso, IxC.IDTipo
From Idiomas as I
Left Join Idiomas_x_Curso as IxC on I.ID = IxC.IDIdioma


--@pampa_rider 
	Select I.Nombre, IxC.IDCurso,IxC.IDTipo
 	From Idiomas as I 
    Left Join Idiomas_x_Curso as IxC on I.ID = IxC.IDIdioma


-- 13 Listado con nombre de idioma de todos los idiomas que no tienen cursos relacionados.
 	
 	select C.Nombre,I.Nombre from Cursos as C
    left join Idiomas_x_Curso as IxC on C.ID=IxC.IDCurso
   
   			--los no incluidos
    		right join Idiomas as I on IxC.IDIdioma = I.ID
   
          	--no estan inscriptos en ningun curso
    		where C.Nombre is NULL


-- 14 Listado con nombres de idioma que figuren como audio de algún curso. Sin repeticiones.
   
   	select distinct IxC.IDIdioma, I.Nombre from Idiomas_x_Curso as IxC
    inner join Idiomas as I on IxC.IDIdioma = I.ID   
    where IxC.IDTipo = 2

-- (15) Listado con nombres y apellidos de todos los usuarios y el nombre del país en el que nacieron. Listar todos los países 

Select DAT.Apellidos, DAT.Nombres, P.Nombre as Pais
From Datos_Personales as DAT
Right Join Paises as P on P.ID = DAT.IDPais

--@pampa_rider
 	
 	SELECT PD.Nombres,PD.APELLIDOS,P.Nombre AS PAIS FROM Datos_Personales as PD
    INNER JOIN paises as P on PD.IDPais = P.ID 

-- 16 Listado con nombre de curso, fecha de estreno y nombres de usuario de todos los inscriptos. Listar todos los nombres de usuario indistintamente si no se inscribieron a ningún curso.

  	select U.ID,NombreUsuario, C.Nombre from Usuarios as U
    left join Inscripciones as I on U.ID = I.IDUsuario
    left join Cursos as C on I.IDCurso = C.ID

-- 17 Listado con nombre de usuario, apellido, nombres, género, fecha de nacimiento y mail de todos los usuarios que no cursaron ningún curso.

   	select U.NombreUsuario,D.Nombres,D.Apellidos,D.Genero,D.Nacimiento,D.Email 
    from Usuarios as U
    inner join Datos_Personales as D on U.ID = D.ID
    left join Inscripciones as I on U.ID = I.IDUsuario
    where I.IDCurso is null


-- 18 Listado con nombre y apellido, nombre del curso, puntaje otorgado y texto de la reseña. Sólo de aquellos usuarios que hayan realizado una reseña inapropiada.

   select D.Nombres,D.Apellidos,C.Nombre,R.Puntaje,R.Observaciones from Reseñas as R
    inner join Inscripciones as I on R.IDInscripcion = I.ID
    inner join Datos_Personales as D ON D.ID = I.IDUsuario 
    inner join Cursos as C on I.IDCurso = C.ID
    where R.Inapropiada=1

-- 19 Listado con nombre del curso, costo de cursado, costo de certificación, nombre del idioma y nombre del tipo de idioma de todos los cursos cuya fecha de estreno haya sido antes del año actual. Ordenado por nombre del curso y luego por nombre de tipo de idioma. Ambos ascendentemente.

  	select C.Nombre,C.CostoCurso,C.CostoCertificacion, 
    I.Nombre as Idioma,
    T.Nombre as Tipo from Cursos as C
    
    inner join Idiomas_x_Curso as IxC on C.ID=IxC.IDIdioma
    inner join Idiomas as I ON Ixc.IDIdioma=I.ID
    inner join TiposIdioma as T on IxC.IDTipo = T.ID

    where YEAR(C.Estreno) < 2020
    Order By  C.Nombre,I.Nombre ASC


-- 20 Listado con nombre del curso y todos los importes de los pagos relacionados.

    select C.Nombre,P.Importe from Pagos as P
    inner join Inscripciones as I on P.IDInscripcion = p.IDInscripcion
    inner join Cursos as C on I.IDCurso=C.ID

-- 21 Listado con nombre de curso, costo de cursado y una leyenda que indique "Costoso" si el costo de cursado es mayor a $ 15000, "Accesible" si el costo de cursado está entre $2500 y $15000, "Barato" si el costo está entre $1 y $2499 y "Gratis" si el costo es $0.

Select C.Nombre, C.CostoCurso,
    Case
    When C.CostoCurso > 15000 then 'Costoso'
    When C.CostoCurso >= 2500 then 'Accesible'
    When C.CostoCurso >= 1 then 'Barato'
    Else 'Gratis'
    End as 'Costo descriptivo'
From Cursos as C

--@pampa_rider
	select C.Nombre,C.CostoCurso, 
	Case
	When C.CostoCurso > 15000 then 'Costoso'
	When C.CostoCurso >= 2500 then 'Accesible'
	When C.CostoCurso >=1 then 'Barato'
	Else 'Gratis'
	End as 'Costo descriptivo'
	From Cursos as C
