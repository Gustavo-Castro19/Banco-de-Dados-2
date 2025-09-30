CREATE DATABASE locadora;
USE locadora; 


CREATE TABLE idioma(
idioma_id TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
nome CHAR(20) NOT NULL,
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

CREATE TABLE filme(
filme_id SMALLINT(5) PRIMARY KEY AUTO_INCREMENT, 
titulo VARCHAR(255) NOT NULL,
descricao TEXT, 
ano_de_lancamento YEAR(4) NOT NULL,
idioma_id TINYINT(3),
idioma_original_id TINYINT(3) NOT NULL,
duracao_da_locacao TINYINT(3) NOT NULL,
preco_da_locacao DECIMAL(4,2) NOT NULL,
duracao_do_filme SMALLINT(5) NOT NULL,
custo_de_substituicao DECIMAL (5,2) NOT NULL,
classificacao ENUM ("L","10","12","14","16","18"), 
recursos_especiais SET ('legenda','3d','audiodescricao','dublado','2d'),
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
FOREIGN KEY (idioma_id) REFERENCES idioma(idioma_id),
FOREIGN KEY (idioma_original_id) REFERENCES idioma(idioma_id)
);

CREATE TABLE ator (
ator_id SMALLINT(5) PRIMARY KEY auto_increment,
primeiro_nome VARCHAR(45) NOT NULL,
ultimo_nome VARCHAR (45) NOT NULL,
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE filme_ator(
ator_id SMALLINT(5),
filme_id SMALLINT(5),
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (ator_id) REFERENCES ator(ator_id),
FOREIGN KEY (filme_id) REFERENCES filme(filme_id)
);

CREATE TABLE pais(
pais_id SMALLINT(5) PRIMARY KEY AUTO_INCREMENT ,
pais VARCHAR(50),
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE cidade (
cidade_id SMALLINT (5) PRIMARY KEY AUTO_INCREMENT, 
cidade VARCHAR(50) NOT NULL,
pais_id SMALLINT(5),
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (pais_id) REFERENCES pais(pais_id)
);

CREATE TABLE endereco(
endereco_id SMALLINT(5) PRIMARY KEY AUTO_INCREMENT, 
endereco1 VARCHAR(50) NOT NULL,
endereco2 VARCHAR(50) NOT NULL,
bairro VARCHAR(20) NOT NULL, 
cidade_id SMALLINT(5), 
cep VARCHAR(10),
telefone VARCHAR(20),
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (cidade_id) REFERENCES cidade(cidade_id)
);


CREATE TABLE loja(
loja_id TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
gerente_id TINYINT(3) NOT NULL,
endereco_id SMALLINT(5),
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (endereco_id) REFERENCES endereco(endereco_id)  
);

CREATE TABLE funcionario(
funcionario_id TINYINT(3) PRIMARY KEY AUTO_INCREMENT, 
primeiro_nome VARCHAR(45) NOT NULL,
ultimo_nome VARCHAR(45) NOT NULL,
endereco_id SMALLINT(5),
foto BLOB NOT NULL,
email VARCHAR(50) NOT NULL, 
loja_id TINYINT(3),
ativo TINYINT(1) NOT NULL,
usuario VARCHAR(16) NOT NULL, 
senha VARCHAR(40) NOT NULL,  
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (endereco_id) REFERENCES endereco(endereco_id),
FOREIGN KEY (loja_id) REFERENCES loja(loja_id)
);

CREATE TABLE cliente(
cliente_id SMALLINT(5) PRIMARY KEY AUTO_INCREMENT, 
loja_id TINYINT(3), 
primeiro_nome VARCHAR(45) NOT NULL,
ultimo_nome VARCHAR(45) NOT NULL,
email VARCHAR(50),
endereco_id SMALLINT(5),
ativo TINYINT(1) NOT NULL,
data_criacao DATETIME default CURRENT_TIMESTAMP,
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (loja_id) REFERENCES loja(loja_id),
FOREIGN KEY (endereco_id) REFERENCES endereco(endereco_id)
);

CREATE TABLE categoria(
categoria_id TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(25),
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE filme_categoria(
filme_id SMALLINT(5), 
categoria_id TINYINT(3),
FOREIGN KEY (filme_id) REFERENCES filme(filme_id),
FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id),
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE inventario(
id_inventario MEDIUMINT(8) PRIMARY KEY AUTO_INCREMENT,
filme_id SMALLINT(5), 
loja_id TINYINT (3),
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (filme_id) REFERENCES filme(filme_id),
FOREIGN KEY (loja_id) REFERENCES loja(loja_id)
);

CREATE TABLE aluguel(
aluguel_id INT(11) PRIMARY KEY AUTO_INCREMENT, 
data_de_aluguel DATETIME NOT NULL, 
id_inventario MEDIUMINT(8), 
cliente_id SMALLINT(5) NOT NULL, 
data_de_devolucao DATETIME NOT NULL,
funcionario_id TINYINT(3) NOT NULL,
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario), 
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
FOREIGN KEY (funcionario_id) REFERENCES funcionario(funcionario_id) 
);

CREATE TABLE pagamento(
pagamento_id SMALLINT(5) PRIMARY KEY AUTO_INCREMENT, 
cliente_id SMALLINT(5) NOT NULL, 
funcionario_id TINYINT(3) NOT NULL, 
aluguel_id INT(11) NOT NULL,
valor DECIMAL(5,2) NOT NULL, 
data_de_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
FOREIGN KEY (funcionario_id) REFERENCES funcionario(funcionario_id),
FOREIGN KEY (aluguel_id) REFERENCES aluguel(aluguel_id)
);

