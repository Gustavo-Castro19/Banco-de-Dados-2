CREATE DATABASE IF NOT EXISTS loja_db;
USE loja_db;

CREATE TABLE clientes (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
cidade VARCHAR(50)
);

CREATE TABLE pedidos (
id INT PRIMARY KEY AUTO_INCREMENT,
cliente_id INT NOT NULL,
data DATE NOT NULL,
valor_total DECIMAL(10,2),
FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE produtos (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
categoria VARCHAR(50),
preco DECIMAL(10,2)
);

CREATE TABLE itens_pedido (
pedido_id INT NOT NULL,
produto_id INT NOT NULL,
qtd INT NOT NULL,
preco_unit DECIMAL(10,2),
PRIMARY KEY (pedido_id, produto_id),
FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
FOREIGN KEY (produto_id) REFERENCES produtos(id)
);


INSERT INTO clientes (nome, cidade) VALUES
('Ana Silva', 'São Paulo'),
('Bruno Costa', 'Rio de Janeiro'),
('Carlos Souza', 'São Paulo'),
('Diana Lima', 'Belo Horizonte'),
('Eduardo Santos', 'Curitiba');

INSERT INTO produtos (nome, categoria, preco) VALUES
('Notebook Dell', 'Eletrônicos', 3500.00),
('Mouse Logitech', 'Eletrônicos', 150.00),
('Teclado Mecânico', 'Eletrônicos', 450.00),
('Cadeira Gamer', 'Móveis', 1200.00),
('Mesa Escritório', 'Móveis', 800.00);

INSERT INTO pedidos (cliente_id, data, valor_total) VALUES
(1, '2024-01-15', 3650.00),
(2, '2024-01-20', 1200.00),
(1, '2024-02-10', 800.00),
(3, '2024-02-15', 4100.00),
(4, '2024-03-01', 150.00);

INSERT INTO itens_pedido VALUES
(1, 1, 1, 3500.00), (1, 2, 1, 150.00),
(2, 4, 1, 1200.00), (3, 5, 1, 800.00),
(4, 1, 1, 3500.00), (4, 3, 1, 450.00),
(4, 2, 1, 150.00), (5, 2, 1, 150.00);

SELECT nome
FROM clientes
WHERE id IN (
SELECT cliente_id
FROM pedidos);

SELECT nome
FROM clientes c
WHERE EXISTS (
SELECT 1
FROM pedidos p
WHERE p.cliente_id = c.id
);



SELECT nome,categoria 
FROM produtos AS p 
WHERE NOT EXISTS (
SELECT 1 FROM itens_pedido AS ip WHERE ip.pedido_id=p.id
);

-- nome e cidade dos clientes que mais gastam
select nome, cidade FROM (
SELECT MAX(valor_total) WHERE (

)
)