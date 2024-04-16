CREATE database Biblioteca;

Use Biblioteca;

CREATE TABLE IF NOT EXISTS Autor(
Autor_id int auto_increment primary key,
Nombre_autor varchar (50) not null
);

CREATE TABLE IF NOT EXISTS Libro(
Libro_id int auto_increment primary key,
Nombre_libro varchar(100) not null,
Autor_id int,
FOREIGN KEY (Autor_id) references Autor(Autor_id),
Año year,
Copias TINYINT not null
);

ALTER TABLE Autor
ADD Libro_id INT,
ADD FOREIGN KEY (Libro_id) REFERENCES Libro(Libro_id);

CREATE TABLE IF NOT EXISTS Prestamos(
Prestamo_id int auto_increment primary key not null,
Libro_id int,
FOREIGN KEY (Libro_id) references Libro(Libro_id),
Devuelto TINYINT(1) DEFAULT 0,
Fecha datetime
);

CREATE TABLE IF NOT EXISTS Usuarios(
Usuario_id int auto_increment primary key not null,
Rut varchar(20),
Prestamo_id int,
FOREIGN KEY (Prestamo_id) references Prestamos(Prestamo_id),
Nombre_Usuario varchar(100) not null,
Correo varchar(100)
);

ALTER TABLE Prestamos
ADD Usuario_id INT,
ADD FOREIGN KEY (Usuario_id) REFERENCES Usuarios(Usuario_id);

CREATE TABLE IF NOT EXISTS Bibliotecarios(
Bibliotecario_id int auto_increment primary key not null,
Nombre_Bibliotecario Varchar (100)not null,
Turno varchar(5)
);

ALTER TABLE Prestamos
ADD Bibliotecario_id INT,
ADD FOREIGN KEY (Bibliotecario_id) REFERENCES Bibliotecarios(Bibliotecario_id);

CREATE TABLE IF NOT EXISTS Multas(
Multa_id  int auto_increment primary key not null,
Prestamo_id int,
FOREIGN KEY (Prestamo_id) references Prestamos(Prestamo_id),
Usuario_id INT,
FOREIGN KEY (Usuario_id) REFERENCES Usuarios(Usuario_id),
Fecha datetime,
Activa TINYINT(1) DEFAULT 0
);

ALTER TABLE Usuarios
ADD Multa_id INT,
ADD FOREIGN KEY (Multa_id) REFERENCES Multas(Multa_id);










