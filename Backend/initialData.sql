USE semi1_proyecto1;

INSERT INTO Rol(rol) 
VALUES("Admin");

INSERT INTO Rol(rol)
VALUES("User");


INSERT INTO Visibilidad(visibilidad)
VALUES ('Publico');

INSERT INTO Visibilidad(visibilidad)
VALUES ('Privado');

INSERT INTO Visibilidad(visibilidad)
VALUES ('Eliminado');

INSERT INTO Tipo_Archivo(tipo)
VALUES ('Imagen');

INSERT INTO Tipo_Archivo(tipo)
VALUES ('Pdf');

INSERT INTO Estado_Amistad(estado)
VALUES('Amigos');


-- DATOS INICIALES DE PRUEBA
INSERT INTO Usuario(username, correo, nombre, contrasena, imagen_url, Rol_idRol)
VALUES('Hima', 'hima_uzumaki@gmail.com', 'Himawari', '1234', 'https://i.pinimg.com/736x/a8/f2/3b/a8f23bdb2bb0d7ee8f13570e5c7978c8.jpg', 1);


INSERT INTO Usuario(username, correo, nombre, contrasena, imagen_url, Rol_idRol)
VALUES('naruto', 'naruto_uzumaki@gmail.com', 'Naruto Uzumaki','1234', 'https://i.pinimg.com/474x/f5/21/12/f521127cfe76995a71fa597160da220d.jpg', 1);

INSERT INTO Usuario(username, correo, nombre, contrasena, imagen_url, Rol_idRol)
VALUES('gaara', 'gaara@gmail.com', 'Gaara', '1234', 'https://c4.wallpaperflare.com/wallpaper/268/51/590/mikser-naruto-sabaku-no-gaara-tattoo-wallpaper-preview.jpg', 2);

-- IMAGEN PUBLICA DE PRUEBA
INSERT INTO Archivo(nombre, archivo_url, fecha_subida, Archivo_idUsuario, Archivo_idVisibilidad, Archivo_idTipoArchivo)
VALUES('Prueba.jpg', 'https://pbs.twimg.com/media/C56sJxPUoAAIEom.jpg', '2021-09-13', 3, 1, 1);

-- IMAGEN PRIVADA DE PRUEBA
INSERT INTO Archivo(nombre, archivo_url, fecha_subida, Archivo_idUsuario, Archivo_idVisibilidad, Archivo_idTipoArchivo)
VALUES('Random.jpg', 'https://m.media-amazon.com/images/I/81J-VON2MaL._SX355_.jpg', '2021-09-13', 1, 2, 1);

-- IMAGEN PUBLICA DE PRUEBA
INSERT INTO Archivo(nombre, archivo_url, fecha_subida, Archivo_idUsuario, Archivo_idVisibilidad, Archivo_idTipoArchivo)
VALUES('Prueba12.jpg', 'https://pbs.twimg.com/media/C56sJxPUoAAIEom.jpg', '2021-09-13', 2, 1, 1);

-- IMAGEN PRIVADA DE PRUEBA
INSERT INTO Archivo(nombre, archivo_url, fecha_subida, Archivo_idUsuario, Archivo_idVisibilidad, Archivo_idTipoArchivo)
VALUES('Random.jpg', 'https://m.media-amazon.com/images/I/81J-VON2MaL._SX355_.jpg', '2021-09-13', 2, 2, 1);



-- -----------------------------------------------------------
-- LOGIN USER
SELECT username, contrasena FROM Usuario
WHERE username='Hima'
AND contrasena='1234';

-- REGISTER USER
INSERT INTO Usuario(username, correo, nombre, contrasena, Rol_idRol)
VALUES('naruto', 'naruto_uzumaki@gmail.com', 'Naruto Uzumaki', '1234', 2);

-- UPLOAD FILE
INSERT INTO Archivo(nombre, archivo_url, fecha_subida, Archivo_idUsuario, Archivo_idVisibilidad, Archivo_idTipoArchivo)
VALUES('Prueba.jpg', 'https://pbs.twimg.com/media/C56sJxPUoAAIEom.jpg', '2021-09-13', 1, 1, 1);

-- GET ALL FILES of an user
SELECT idArchivo, nombre, archivo_url, fecha_subida, v.visibilidad, t.tipo
from Archivo a, Visibilidad v, Tipo_Archivo t
WHERE A.Archivo_idUsuario = 1
AND	A.Archivo_idVisibilidad = v.idVisibilidad
AND v.idVisibilidad != 3
AND A.Archivo_idTipoArchivo = t.idTipo_Archivo
ORDER BY v.visibilidad, a.idArchivo;

-- ADD AMIGO
INSERT INTO Detalle_Amistad(idAmigo1, idAmigo2, fecha_amistad, idEstado)
VALUES (1, 2, '2020-12-24', 1);

INSERT INTO Detalle_Amistad(idAmigo1, idAmigo2, fecha_amistad, idEstado)
VALUES (2, 1, '2020-12-24', 1);

INSERT INTO Detalle_Amistad(idAmigo1, idAmigo2, fecha_amistad, idEstado)
VALUES (2, 3, '2020-12-24', 1);

INSERT INTO Detalle_Amistad(idAmigo1, idAmigo2, fecha_amistad, idEstado)
VALUES (3, 2, '2020-12-24', 1);


-- --------------------------------------------------------------------------

-- GET ALL USERS AND THEIR PUBLIC FILES COUNT
SELECT u.username, u.nombre, COUNT(a.idArchivo) as cantidad
FROM Usuario u, Archivo a
WHERE u.idUsuario <> 1
AND u.idUsuario = a.Archivo_idUsuario;

SELECT u.idUsuario, u.username, u.nombre, u.imagen_url, COUNT(a.idArchivo) as cantidad
FROM Usuario u, Archivo a, Visibilidad v
WHERE u.idUsuario = a.Archivo_idUsuario
AND a.Archivo_idVisibilidad = v.idVisibilidad
AND a.Archivo_idVisibilidad = 1
AND u.idUsuario <> 1
AND NOT EXISTS (
				SELECT d.idAmigo1, d.idAmigo2
                FROM detalle_amistad d
                WHERE d.idAmigo2 = u.idUsuario
                AND d.idAmigo1 = 1
				)
GROUP BY u.idUsuario
UNION 
SELECT u2.idUsuario, u2.username, u2.nombre, u2.imagen_url, 0
	FROM Usuario u2
    WHERE u2.idUsuario <> 1
     AND not exists  (SELECT * FROM Archivo a2
							WHERE u2.idUsuario = a2.Archivo_idUsuario);


SELECT * from Archivo where Archivo_idUsuario = 3
and Archivo_idVisibilidad = 1;
    
    
-- SEE ALL THE PUBLIC FILES OF A FRIEND
SELECT u.username, a.nombre as archivo, a.archivo_url, a.fecha_subida, t.tipo
FROM Usuario u, Detalle_Amistad d, Archivo a, tipo_archivo t
WHERE d.idAmigo1 = 2
AND d.idAmigo2 = u.idUsuario
AND u.idUsuario = a.Archivo_idUsuario
AND a.Archivo_idVisibilidad = 1
AND a.Archivo_idTipoArchivo = t.idTipo_Archivo;




-- UPDATE NAME AND VISIBILIDAD OF A FILE
UPDATE Archivo
SET nombre='Edited', Archivo_idVisibilidad = 1
WHERE idArchivo = 5;


-- DELETE FILE (Change visibilidad to ELIMINADO)
UPDATE Archivo
SET nombre='Edited', Archivo_idVisibilidad = 3
WHERE idArchivo = 5;




