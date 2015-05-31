CREATE DATABASE livraria;

USE livraria;

CREATE TABLE categoria (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE usuario (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	username VARCHAR(50) NOT NULL,
	senha VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL,
	dataCadastro DATETIME DEFAULT GETDATE(),
	descricao VARCHAR(MAX),
	imageurl VARCHAR(50)
);

INSERT INTO usuario (username,senha,email,dataCadastro,descricao,imageurl) 
VALUES ('admin','admin','admin','02-12-2014','Administrador do sistema','default.png');

CREATE TABLE livro (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	isbn VARCHAR(20) NOT NULL,
	paginas INT NOT NULL,
	edicao INT NOT NULL,
	idioma VARCHAR(40) NOT NULL,
	titulo VARCHAR(100) NOT NULL,
	autor VARCHAR(50) NOT NULL,
	ano INT NOT NULL,
	preco DECIMAL NOT NULL,
	quantidade INT DEFAULT 1,
	descricao VARCHAR(MAX),
	idCategoria INT,
	idUsuario INT,
	imageurl VARCHAR(50),
	created DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (idCategoria) REFERENCES categoria(id),
	FOREIGN KEY (idUsuario) REFERENCES usuario(id)
);

CREATE TABLE carrinho (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	created DATETIME DEFAULT GETDATE()
);

CREATE TABLE carrinho_produto(
	idCarrinho INT NOT NULL,
	idLivro INT NOT NULL,
	quantidade INT NOT NULL DEFAULT 1,
	FOREIGN KEY (idCarrinho) REFERENCES carrinho(id),
	FOREIGN KEY (idLivro) REFERENCES livro(id),
	PRIMARY KEY(idCarrinho,idLivro)
);

/*insert categoriras*/
INSERT INTO categoria (nome) VALUES ('Coleções');
INSERT INTO categoria (nome) VALUES ('Lançamentos');
INSERT INTO categoria (nome) VALUES ('Administração e negócios');
INSERT INTO categoria (nome) VALUES ('Direito');
INSERT INTO categoria (nome) VALUES ('Literatura estrangeira');
INSERT INTO categoria (nome) VALUES ('Literatura nacional');
INSERT INTO categoria (nome) VALUES ('Auto-ajuda');
INSERT INTO categoria (nome) VALUES ('Romance');
INSERT INTO categoria (nome) VALUES ('Informática');
INSERT INTO categoria (nome) VALUES ('Medicina e saúde');
INSERT INTO categoria (nome) VALUES ('Religião');
INSERT INTO categoria (nome) VALUES ('Boxes e coleções');

SELECT * FROM usuario;