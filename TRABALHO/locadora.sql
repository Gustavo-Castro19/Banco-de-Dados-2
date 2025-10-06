CREATE DATABASE locadora;
USE locadora; 

-->criação das tabelas
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

--> possivel tabela errada no exemplo 
CREATE TABLE filme_texto (
filme_id SMALLINT(6) PRIMARY KEY AUTO_INCREMENT, 
titulo VARCHAR(255),
descricao TEXT
);


--> criação de exemplos via CHATGPT

-- 1) idiomas (5)
INSERT INTO idioma (idioma_id, nome) VALUES
(1, 'Inglês'),
(2, 'Espanhol'),
(3, 'Francês'),
(4, 'Japonês'),
(5, 'Português');

-- 2) pais (5)
INSERT INTO pais (pais_id, pais) VALUES
(1, 'Brasil'),
(2, 'Estados Unidos'),
(3, 'Japão'),
(4, 'França'),
(5, 'Espanha');

-- 3) cidade (5) - cada cidade referenciando um país
INSERT INTO cidade (cidade_id, cidade, pais_id) VALUES
(1, 'São Paulo', 1),
(2, 'Nova York', 2),
(3, 'Tóquio', 3),
(4, 'Paris', 4),
(5, 'Madri', 5);

-- 4) endereco (25) - 5 por cidade (enderecos simples e coerentes)
INSERT INTO endereco (endereco_id, endereco1, endereco2, bairro, cidade_id, cep, telefone) VALUES
(1, 'Av. Paulista, 1000', 'Apto 101', 'Bela Vista', 1, '01310-100', '(11) 3000-1000'),
(2, 'R. da Consolação, 200', 'Sala 5', 'Consolação', 1, '01302-200', '(11) 3000-2000'),
(3, 'R. Augusta, 500', 'Loja A', 'Consolação', 1, '01304-500', '(11) 3000-3000'),
(4, 'Av. Rebouças, 1500', 'Conj 12', 'Pinheiros', 1, '05402-150', '(11) 3000-4000'),
(5, 'R. Vergueiro, 2500', 'Casa', 'Vila Mariana', 1, '04101-250', '(11) 3000-5000'),

(6, '5th Ave, 700', 'Floor 2', 'Midtown', 2, '10022', '+1 212-555-0101'),
(7, 'Broadway, 120', 'Suite 3', 'Manhattan', 2, '10012', '+1 212-555-0102'),
(8, 'Madison Ave, 50', 'Loja B', 'Manhattan', 2, '10010', '+1 212-555-0103'),
(9, 'Lexington Ave, 300', 'Apt 10', 'Upper East', 2, '10016', '+1 212-555-0104'),
(10, 'Wall St, 20', 'Office 6', 'Financial', 2, '10005', '+1 212-555-0105'),

(11, 'Shibuya Crossing 1-2', 'Bldg A', 'Shibuya', 3, '150-0002', '+81 3-5555-0101'),
(12, 'Shinjuku 3-5', 'Apt 12', 'Shinjuku', 3, '160-0022', '+81 3-5555-0102'),
(13, 'Ginza 4-6', 'Loja C', 'Chuo', 3, '104-0061', '+81 3-5555-0103'),
(14, 'Akihabara 1-1', 'Sala 2', 'Chiyoda', 3, '101-0021', '+81 3-5555-0104'),
(15, 'Ueno Park 2', 'Casa', 'Taito', 3, '110-0007', '+81 3-5555-0105'),

(16, 'Rue de Rivoli 10', 'Appt 4', '1er Arr.', 4, '75001', '+33 1 55 00 01 01'),
(17, 'Boulevard St-Germain 20', 'Loja D', '6ème Arr.', 4, '75006', '+33 1 55 00 01 02'),
(18, 'Avenue des Champs-Élysées 100', 'Floor 5', '8ème Arr.', 4, '75008', '+33 1 55 00 01 03'),
(19, 'Rue Cler 15', 'Maison', '7ème Arr.', 4, '75007', '+33 1 55 00 01 04'),
(20, 'Montmartre 25', 'Apt 9', '18ème Arr.', 4, '75018', '+33 1 55 00 01 05'),

(21, 'Gran Vía 50', 'Local 2', 'Centro', 5, '28013', '+34 91 555 0101'),
(22, 'Paseo de la Castellana 200', 'Despacho 6', 'Chamartín', 5, '28046', '+34 91 555 0102'),
(23, 'Calle de Alcalá 78', 'Apto 3', 'Centro', 5, '28014', '+34 91 555 0103'),
(24, 'Plaza Mayor 8', 'Loja E', 'Centro', 5, '28012', '+34 91 555 0104'),
(25, 'Calle Serrano 45', 'Suite 1', 'Salamanca', 5, '28001', '+34 91 555 0105');

-- 5) loja (2) - observe gerente_id (não há FK definido para gerente na sua DDL original)
INSERT INTO loja (loja_id, gerente_id, endereco_id) VALUES
(1, 1, 1),
(2, 2, 6);

-- 6) funcionario (5)
-- Obs: foto BLOB preenchida com string vazia ('') para satisfazer NOT NULL.
INSERT INTO funcionario (funcionario_id, primeiro_nome, ultimo_nome, endereco_id, foto, email, loja_id, ativo, usuario, senha) VALUES
(1, 'Marcos', 'Pereira', 2, '', 'marcos.pereira@locadora.com', 1, 1, 'mpereira', 'senha1234'),
(2, 'Ana', 'Costa', 7, '', 'ana.costa@locadora.com', 2, 1, 'acosta', 'senha1234'),
(3, 'João', 'Alves', 3, '', 'joao.alves@locadora.com', 1, 1, 'jalves', 'senha1234'),
(4, 'Beatriz', 'Mota', 8, '', 'beatriz.mota@locadora.com', 2, 1, 'bmota', 'senha1234'),
(5, 'Paulo', 'Ramos', 4, '', 'paulo.ramos@locadora.com', 1, 1, 'pramos', 'senha1234');

-- 7) cliente (25) — cada cliente tem loja_id e endereco_id coerentes
INSERT INTO cliente (cliente_id, loja_id, primeiro_nome, ultimo_nome, email, endereco_id, ativo, data_criacao) VALUES
(1, 1, 'Ana', 'Silva', 'ana.silva@email.com', 5, 1, '2025-09-10 10:00:00'),
(2, 1, 'Bruno', 'Souza', 'bruno.souza@email.com', 1, 1, '2025-09-11 11:00:00'),
(3, 1, 'Carla', 'Oliveira', 'carla.oliveira@email.com', 2, 1, '2025-09-11 12:00:00'),
(4, 2, 'Diego', 'Santos', 'diego.santos@email.com', 6, 1, '2025-09-12 09:00:00'),
(5, 2, 'Eduarda', 'Gomes', 'eduarda.gomes@email.com', 7, 1, '2025-09-12 15:30:00'),
(6, 1, 'Felipe', 'Almeida', 'felipe.almeida@email.com', 3, 1, '2025-09-13 14:00:00'),
(7, 1, 'Gabriela', 'Rocha', 'gabriela.rocha@email.com', 4, 1, '2025-09-14 16:00:00'),
(8, 2, 'Henrique', 'Costa', 'henrique.costa@email.com', 8, 1, '2025-09-15 10:30:00'),
(9, 2, 'Isabela', 'Martins', 'isabela.martins@email.com', 9, 1, '2025-09-15 11:45:00'),
(10, 1, 'João', 'Pereira', 'joao.pereira@email.com', 10, 1, '2025-09-16 09:20:00'),
(11, 1, 'Karina', 'Lima', 'karina.lima@email.com', 11, 1, '2025-09-16 13:00:00'),
(12, 2, 'Lucas', 'Fernandes', 'lucas.fernandes@email.com', 12, 1, '2025-09-17 14:10:00'),
(13, 1, 'Mariana', 'Araújo', 'mariana.araujo@email.com', 13, 1, '2025-09-17 16:30:00'),
(14, 2, 'Nicolas', 'Ribeiro', 'nicolas.ribeiro@email.com', 14, 1, '2025-09-18 10:05:00'),
(15, 1, 'Otávio', 'Melo', 'otavio.melo@email.com', 15, 1, '2025-09-18 11:50:00'),
(16, 2, 'Patrícia', 'Duarte', 'patricia.duarte@email.com', 16, 1, '2025-09-19 09:00:00'),
(17, 1, 'Rafael', 'Cardoso', 'rafael.cardoso@email.com', 17, 1, '2025-09-19 12:30:00'),
(18, 2, 'Sabrina', 'Torres', 'sabrina.torres@email.com', 18, 1, '2025-09-20 15:00:00'),
(19, 1, 'Thiago', 'Nunes', 'thiago.nunes@email.com', 19, 1, '2025-09-20 16:00:00'),
(20, 2, 'Ursula', 'Carvalho', 'ursula.carvalho@email.com', 20, 1, '2025-09-21 10:20:00'),
(21, 1, 'Vinícius', 'Barros', 'vinicius.barros@email.com', 21, 1, '2025-09-21 11:10:00'),
(22, 2, 'Wesley', 'Teixeira', 'wesley.teixeira@email.com', 22, 1, '2025-09-22 09:45:00'),
(23, 1, 'Ximena', 'Prado', 'ximena.prado@email.com', 23, 1, '2025-09-22 17:00:00'),
(24, 2, 'Yasmin', 'Brito', 'yasmin.brito@email.com', 24, 1, '2025-09-23 12:00:00'),
(25, 1, 'Zeca', 'Moreira', 'zeca.moreira@email.com', 25, 1, '2025-09-23 18:30:00');

-- 8) categoria (5)
INSERT INTO categoria (categoria_id, nome) VALUES
(1, 'Ação'),
(2, 'Comédia'),
(3, 'Drama'),
(4, 'Ficção'),
(5, 'Terror');

-- 9) filme (25)
-- Campos: filme_id, titulo, descricao, ano_de_lancamento, idioma_id, idioma_original_id,
-- duracao_da_locacao, preco_da_locacao, duracao_do_filme, custo_de_substituicao, classificacao, recursos_especiais
INSERT INTO filme (filme_id, titulo, descricao, ano_de_lancamento, idioma_id, idioma_original_id, duracao_da_locacao, preco_da_locacao, duracao_do_filme, custo_de_substituicao, classificacao, recursos_especiais) VALUES
(1, 'A Origem', 'Ladrões que invadem sonhos.', 2010, 1, 1, 3, 12.90, 148, 79.99, '14', 'legenda,2d'),
(2, 'Matrix', 'Um programador descobre a realidade.', 1999, 1, 1, 3, 10.00, 136, 59.99, '16', 'legenda,2d'),
(3, 'Titanic', 'Romance a bordo de um navio.', 1997, 1, 1, 5, 9.90, 195, 49.99, '12', 'legenda,2d'),
(4, 'Interestelar', 'Viagem espacial para salvar a humanidade.', 2014, 1, 1, 4, 14.00, 169, 99.99, '12', 'legenda,2d'),
(5, 'Parasita', 'Família pobre se infiltra em casa rica.', 2019, 3, 3, 3, 13.00, 132, 79.99, '16', 'legenda,2d'),
(6, 'A Viagem de Chihiro', 'Garota num mundo mágico.', 2001, 4, 4, 5, 9.90, 125, 49.99, 'L', 'legenda,2d'),
(7, 'O Rei Leão', 'A jornada de Simba.', 1994, 1, 1, 5, 8.90, 88, 39.99, 'L', 'dublado,legenda'),
(8, 'Vingadores: Ultimato', 'Heróis enfrentam Thanos.', 2019, 1, 1, 3, 13.90, 181, 119.99, '12', 'legenda,2d'),
(9, 'Coringa', 'A origem do vilão Coringa.', 2019, 1, 1, 3, 11.00, 122, 69.99, '16', 'legenda,2d'),
(10, 'Oppenheimer', 'Biografia do físico Oppenheimer.', 2023, 1, 1, 4, 15.00, 180, 99.99, '16', 'legenda,2d'),
(11, 'Barbie', 'A boneca descobre o mundo real.', 2023, 1, 1, 3, 9.90, 114, 59.99, 'L', 'legenda,2d'),
(12, 'Top Gun: Maverick', 'Pilotos e intensidade aérea.', 2022, 1, 1, 3, 12.50, 130, 89.99, '12', 'legenda,2d'),
(13, 'Toy Story', 'Brinquedos ganham vida.', 1995, 5, 5, 5, 8.00, 81, 39.99, 'L', 'dublado,legenda'),
(14, 'Duna', 'Política e areia em Arrakis.', 2021, 1, 1, 3, 13.90, 155, 89.99, '14', 'legenda,2d'),
(15, 'O Poderoso Chefão', 'Família mafiosa e poder.', 1972, 1, 1, 4, 10.50, 175, 79.99, '18', 'legenda,2d'),
(16, 'Pantera Negra', 'Rei de Wakanda protege sua nação.', 2018, 1, 1, 3, 12.00, 134, 79.99, '12', 'legenda,2d'),
(17, 'A Baleia', 'Professor tenta reconectar-se com a filha.', 2022, 1, 1, 3, 12.00, 117, 69.99, '16', 'legenda,2d'),
(18, 'Clube da Luta', 'Criação de um clube secreto.', 1999, 1, 1, 3, 11.50, 139, 59.99, '18', 'legenda,2d'),
(19, 'A Vida é Bela', 'Pai protege o filho no Holocausto.', 1997, 5, 5, 4, 10.00, 116, 69.99, '12', 'legenda,2d'),
(20, 'Homem-Aranha: Sem Volta Para Casa', 'Multiverso do herói.', 2021, 1, 1, 3, 13.90, 148, 89.99, '12', 'legenda,2d'),
(21, 'O Resgate do Soldado Ryan', 'Operação na guerra.', 1998, 1, 1, 4, 11.00, 170, 79.99, '16', 'legenda,2d'),
(22, 'Amélie', 'História leve ambientada em Paris.', 2001, 3, 3, 4, 9.50, 122, 59.99, 'L', 'legenda,2d'),
(23, 'Sua Vida Me Pertence', 'Filme fictício regional.', 2018, 5, 5, 3, 8.50, 105, 49.99, '12', 'dublado,legenda'),
(24, 'Akira', 'Ficção cyberpunk do Japão.', 1988, 4, 4, 5, 9.90, 124, 59.99, '16', 'legenda,2d'),
(25, 'O Fabuloso Destino de Amélie Poulain', 'Outra entrada clássica francesa.', 2001, 3, 3, 4, 9.50, 122, 59.99, 'L', 'legenda,2d');

-- 10) filme_categoria (25) - cada filme recebe uma categoria (1-5)
INSERT INTO filme_categoria (filme_id, categoria_id) VALUES
(1, 4),
(2, 1),
(3, 3),
(4, 4),
(5, 3),
(6, 4),
(7, 4),
(8, 1),
(9, 3),
(10, 3),
(11, 2),
(12, 1),
(13, 2),
(14, 4),
(15, 3),
(16, 1),
(17, 3),
(18, 3),
(19, 3),
(20, 1),
(21, 3),
(22, 2),
(23, 2),
(24, 4),
(25, 2);

-- 11) inventario (25) - um inventário por filme, alternando lojas (1 e 2)
INSERT INTO inventario (id_inventario, filme_id, loja_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 2),
(7, 7, 2),
(8, 8, 2),
(9, 9, 2),
(10, 10, 2),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 2),
(15, 15, 2),
(16, 16, 1),
(17, 17, 1),
(18, 18, 2),
(19, 19, 2),
(20, 20, 1),
(21, 21, 1),
(22, 22, 2),
(23, 23, 2),
(24, 24, 1),
(25, 25, 1);

-- 12) aluguel (25)
-- Campos: aluguel_id, data_de_aluguel, id_inventario, cliente_id, data_de_devolucao, funcionario_id
-- Datas próximas a outubro de 2025, prazos de 1 a 4 dias
INSERT INTO aluguel (aluguel_id, data_de_aluguel, id_inventario, cliente_id, data_de_devolucao, funcionario_id) VALUES
(1, '2025-10-01 10:00:00', 1, 1, '2025-10-03 18:00:00', 1),
(2, '2025-10-01 14:30:00', 2, 2, '2025-10-04 13:00:00', 3),
(3, '2025-10-02 09:20:00', 3, 3, '2025-10-05 09:00:00', 5),
(4, '2025-10-02 11:00:00', 4, 4, '2025-10-04 20:00:00', 2),
(5, '2025-10-03 16:10:00', 5, 5, '2025-10-06 16:00:00', 1),
(6, '2025-10-03 17:45:00', 6, 6, '2025-10-05 17:00:00', 4),
(7, '2025-10-04 12:30:00', 7, 7, '2025-10-06 12:00:00', 3),
(8, '2025-10-04 13:00:00', 8, 8, '2025-10-07 13:00:00', 2),
(9, '2025-10-05 09:00:00', 9, 9, '2025-10-06 19:00:00', 1),
(10, '2025-10-05 10:30:00', 10, 10, '2025-10-08 10:00:00', 5),
(11, '2025-10-06 11:15:00', 11, 11, '2025-10-08 11:00:00', 4),
(12, '2025-10-06 14:00:00', 12, 12, '2025-10-09 14:00:00', 2),
(13, '2025-10-07 09:30:00', 13, 13, '2025-10-10 09:00:00', 3),
(14, '2025-10-07 15:00:00', 14, 14, '2025-10-10 15:00:00', 1),
(15, '2025-10-08 08:45:00', 15, 15, '2025-10-11 08:30:00', 5),
(16, '2025-10-08 13:20:00', 16, 16, '2025-10-10 13:00:00', 4),
(17, '2025-10-09 10:10:00', 17, 17, '2025-10-12 10:00:00', 1),
(18, '2025-10-09 18:00:00', 18, 18, '2025-10-11 18:00:00', 2),
(19, '2025-10-10 09:00:00', 19, 19, '2025-10-13 09:00:00', 3),
(20, '2025-10-10 12:00:00', 20, 20, '2025-10-13 12:00:00', 5),
(21, '2025-10-11 14:30:00', 21, 21, '2025-10-14 14:00:00', 4),
(22, '2025-10-11 16:00:00', 22, 22, '2025-10-15 16:00:00', 1),
(23, '2025-10-12 09:20:00', 23, 23, '2025-10-15 09:00:00', 2),
(24, '2025-10-12 11:45:00', 24, 24, '2025-10-15 11:30:00', 3),
(25, '2025-10-13 10:00:00', 25, 25, '2025-10-16 10:00:00', 5);

-- 13) pagamento (25)
-- Campos: pagamento_id, cliente_id, funcionario_id, aluguel_id, valor, data_de_pagamento
INSERT INTO pagamento (pagamento_id, cliente_id, funcionario_id, aluguel_id, valor, data_de_pagamento) VALUES
(1, 1, 1, 1, 12.90, '2025-10-03 18:05:00'),
(2, 2, 3, 2, 10.00, '2025-10-04 13:10:00'),
(3, 3, 5, 3, 9.90, '2025-10-05 09:05:00'),
(4, 4, 2, 4, 14.00, '2025-10-04 20:10:00'),
(5, 5, 1, 5, 13.90, '2025-10-06 16:05:00'),
(6, 6, 4, 6, 9.50, '2025-10-05 17:10:00'),
(7, 7, 3, 7, 12.00, '2025-10-06 12:05:00'),
(8, 8, 2, 8, 15.00, '2025-10-07 13:10:00'),
(9, 9, 1, 9, 11.00, '2025-10-06 19:10:00'),
(10, 10, 5, 10, 15.00, '2025-10-08 10:05:00'),
(11, 11, 4, 11, 11.50, '2025-10-08 11:05:00'),
(12, 12, 2, 12, 10.90, '2025-10-09 14:05:00'),
(13, 13, 3, 13, 9.50, '2025-10-10 09:10:00'),
(14, 14, 1, 14, 9.90, '2025-10-10 15:10:00'),
(15, 15, 5, 15, 11.00, '2025-10-11 08:35:00'),
(16, 16, 4, 16, 12.50, '2025-10-10 13:05:00'),
(17, 17, 1, 17, 12.00, '2025-10-12 10:15:00'),
(18, 18, 2, 18, 15.00, '2025-10-11 18:10:00'),
(19, 19, 3, 19, 10.00, '2025-10-13 09:05:00'),
(20, 20, 5, 20, 13.90, '2025-10-13 12:05:00'),
(21, 21, 4, 21, 11.00, '2025-10-14 14:05:00'),
(22, 22, 1, 22, 9.50, '2025-10-15 16:05:00'),
(23, 23, 2, 23, 8.50, '2025-10-15 09:10:00'),
(24, 24, 3, 24, 9.90, '2025-10-15 11:40:00'),
(25, 25, 5, 25, 9.50, '2025-10-16 10:05:00');


--> Queries pedidas 

SELECT primeiro_nome, ultimo_nome, email FROM cliente;

SELECT titulo,ano_de_lancamento, preco_da_locacao FROM 

SELECT * FROM cliente ORDER BY cliente.ultimo_nome; 

SELECT loja_id, COUNT(cliente_id) 
FROM cliente
GROUP BY loja_id;

SELECT * FROM filme WHERE filme.preco_da_locacao > 6.00;

SELECT cliente.primeiro_nome,cliente.ultimo_nome, aluguel.data_de_aluguel FROM aluguel a
JOIN cliente c ON a.cliente_id = c.cliente_id;  


SELECT c.* , f.*, a.data_de_aluguel
FROM aluguel a
JOIN cliente c ON a.cliente_id = c.cliente_id
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN filme f ON i.filme_id = f.filme_id;

SELECT c.primeiro_nome, c.ultimo_nome, SUM(p.valor) AS total_gasto
FROM pagamento p
JOIN cliente c ON p.cliente_id = c.cliente_id; 

SELECT f.titulo, COUNT(a.aluguel_id) AS total_alugueis
FROM aluguel a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN filme f ON i.filme_id = f.filme_id
GROUP BY f.filme_id
ORDER BY total_alugueis DESC
LIMIT 5;


SELECT l.loja_id, SUM(p.valor) AS receita_total
FROM pagamento p
JOIN funcionario f ON p.funcionario_id = f.funcionario_id
JOIN loja l ON f.loja_id = l.loja_id
GROUP BY l.loja_id;
