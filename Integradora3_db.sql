CREATE DATABASE Alke_Wallet;
USE Alke_Wallet;

-- Creación de la tabla de Usuarios
CREATE TABLE IF NOT EXISTS Usuarios(
Id_Usuario INT AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR (80) NOT NULL,
Correo_Electronico VARCHAR (100)NOT NULL,
Contrasena VARCHAR (100)NOT NULL,
Saldo DECIMAL (10,2),
Fecha_Creación TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creación de la tabla de Transacción
CREATE TABLE IF NOT EXISTS Transaccion(
Id_Transaccion INT AUTO_INCREMENT PRIMARY KEY,
Id_Usuario_Envia INT,
FOREIGN KEY (Id_Usuario_Envia) REFERENCES Usuarios(Id_Usuario),
Id_Usuario_Recibe INT,
FOREIGN KEY (Id_Usuario_Recibe) REFERENCES Usuarios(Id_Usuario),
Importe INT,
Fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Creación de la tabla de Moneda
CREATE TABLE IF NOT EXISTS Monedas(
Id_moneda INT AUTO_INCREMENT PRIMARY KEY,
Nombre_moneda VARCHAR (20)NOT NULL,
Símbolo_moneda VARCHAR (5) NOT NULL
);

-- Agregación de columna Id moneda para consulta
ALTER TABLE Usuarios
ADD Moneda_Usada INT,
ADD FOREIGN KEY (Moneda_Usada) REFERENCES Monedas(Id_Moneda);

-- Agregación de datos a la tabla Monedas

INSERT INTO Monedas (Nombre_moneda,Símbolo_moneda)
VALUES ("Yen Japonés","¥");
INSERT INTO Monedas (Nombre_moneda,Símbolo_moneda)
VALUES ("Peso Mexicano","MX$");
INSERT INTO Monedas (Nombre_moneda,Símbolo_moneda)
VALUES ("Dólar Estadounidense","$USD");
INSERT INTO Monedas (Nombre_moneda,Símbolo_moneda)
VALUES ("Peso Chileno","CLP$");
INSERT INTO Monedas (Nombre_moneda,Símbolo_moneda)
VALUES ("Unidad de fomento","UF");

-- Agregación de datos a la tabla Usuarios

INSERT INTO Usuarios (Nombre,Correo_Electronico,Contrasena,Saldo,Moneda_Usada)
VALUES 
("Mario Castañeda","Mario.C@gmail.com",sha2("marito123",256),30000,2);
INSERT INTO Usuarios (Nombre,Correo_Electronico,Contrasena,Saldo,Moneda_Usada)
VALUES 
("Akira Yamaoka","Akirayama@Konami.jp",sha2("yama321",256),100000,1);
INSERT INTO Usuarios (Nombre,Correo_Electronico,Contrasena,Saldo,Moneda_Usada)
VALUES 
("Uematsu Nobou","Nobunobu@Square.jp",sha2("ff123",256),50000,1);	

-- Agregación de datos a la tabla Transacción

INSERT INTO Transaccion (Id_Usuario_Envia,Id_Usuario_Recibe,Importe)
VALUES(1,2,300);
INSERT INTO Transaccion (Id_Usuario_Envia,Id_Usuario_Recibe,Importe)
VALUES(2,1,300);
INSERT INTO Transaccion (Id_Usuario_Envia,Id_Usuario_Recibe,Importe)
VALUES(3,2,300);
INSERT INTO Transaccion (Id_Usuario_Envia,Id_Usuario_Recibe,Importe)
VALUES(1,3,300);


-- Requerimientos :

-- Consulta para obtener el nombre de la moneda elegida por un usuario específico
SELECT usuarios.Nombre,monedas.Nombre_moneda FROM alke_wallet.monedas,usuarios
WHERE monedas.id_moneda = usuarios.moneda_usada AND usuarios.nombre = "Mario Castañeda";

-- Consulta para obtener las transacciones realizadas por un usuario específico
SELECT usuarios.nombre,transaccion.fecha_transaccion FROM alke_wallet.usuarios,transaccion
WHERE usuarios.id_usuario = transaccion.id_usuario_envia AND usuarios.nombre = "Mario Castañeda";

-- Consulta para obtener todos los usuarios registrados
SELECT Nombre FROM Usuarios;

-- Consulta para obtener todas las monedas registradas
SELECT Nombre_moneda FROM Monedas;

-- Consulta para obtener todas las transacciones registradas
SELECT * FROM Transaccion;

-- Consulta para obtener todas las transacciones realizadas por un usuario específico
SELECT usuarios.nombre,transaccion.fecha_transaccion FROM alke_wallet.usuarios,transaccion
WHERE usuarios.id_usuario = transaccion.id_usuario_envia AND usuarios.nombre = 'Akira Yamaoka';

-- Consulta para obtener todas las transacciones recibidas por un usuario específico
SELECT usuarios.nombre,transaccion.fecha_transaccion FROM alke_wallet.usuarios,transaccion
WHERE usuarios.id_usuario = transaccion.id_usuario_envia AND usuarios.nombre = 'Uematsu Nobou';

-- Sentencia DML para modificar el campo correo electrónico de un usuario específico (desmarcar "Safe Updates" y reiniciar si usa workbench) 
UPDATE Usuarios SET Correo_Electronico = "MarioVC@doblaje.mx"
WHERE Nombre = "Mario Castañeda";  

-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)
DELETE FROM Transaccion WHERE transaccion.id_transaccion = 1;

-- Sentencia para DDL modificar el nombre de la columna correo_electronico por email
ALTER TABLE Usuarios RENAME COLUMN Correo_Electronico TO Email;