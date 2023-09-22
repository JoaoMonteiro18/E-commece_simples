
CREATE DATABASE ecommerce_simples;
USE ecommerce_simples;

-- Criação das tabelas (clientes, produtos, pedidos, itens e endereços):

CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(35) NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(100)
);

CREATE TABLE produtos (
    produto_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(75) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE itens_pedido (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);

CREATE TABLE endereco_entrega (
    endereco_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    endereco VARCHAR(100) NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    estado VARCHAR(25) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);
-- Incluindo registros nas tabelas:

-- Inserir clientes
INSERT INTO clientes (nome, email, telefone, endereco)
VALUES
    ('João Paulo', 'joao@example.com', '(11) 1234-5678', 'Rua A, 123'),
    ('Adriana Cristina', 'adriana@example.com', '(21) 9876-5432', 'Av. B, 456'),
    ('Geovanna Aliaga', 'geovanna@example.com', '(31) 5555-9999', 'Rua C, 789'),
    ('Paulo Sérgio', 'paulo@example.com', '(41) 7777-8888', 'Rua D, 000');

-- Inserir produtos
INSERT INTO produtos (nome, descricao, preco)
VALUES
    ('Produto 1', 'Descrição do Produto 1', 19.99),
    ('Produto 2', 'Descrição do Produto 2', 29.99),
    ('Produto 3', 'Descrição do Produto 3', 39.99),
    ('Produto 4', 'Descrição do Produto 4', 69.99);

-- Inserir pedidos
INSERT INTO pedidos (cliente_id, data_pedido)
VALUES
    (1, '2021-09-23'),
    (2, '2023-02-16'),
    (3, '2023-09-15'),
    (3, '2022-12-18');

-- Inserir itens do pedido
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
VALUES
    (1, 1, 2, 19.99),
    (1, 2, 1, 29.99),
    (2, 2, 3, 29.99),
    (3, 3, 1, 39.99);

-- Inserir endereços de entrega
INSERT INTO endereco_entrega (cliente_id, endereco, cidade, estado, cep)
VALUES
    (1, 'Rua A, 123', 'São Paulo', 'SP', '01234-567'),
    (2, 'Av. B, 456', 'Rio de Janeiro', 'RJ', '20000-123'),
    (3, 'Rua C, 789', 'Belo Horizonte', 'MG', '30000-456'),
    (4, 'Rua D, 000', 'Paraná', 'PR', '40000-789');
    
    -- Queries que retornam pedidos por data com identificação de clientes, produtos e endereço de entrega:
    
    -- 1: Retorna todos os pedidos, ordenados por data, com identificação de clientes, produtos e endereço de entrega
    SELECT
    pedidos.data_pedido,
    clientes.nome nome_cliente,
    produtos.nome nome_produto,
    endereco_entrega.endereco,
    endereco_entrega.cidade,
    endereco_entrega.estado,
    endereco_entrega.cep
FROM pedidos
JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
JOIN itens_pedido ON pedidos.pedido_id = itens_pedido.pedido_id
JOIN produtos ON itens_pedido.produto_id = produtos.produto_id
JOIN endereco_entrega ON pedidos.cliente_id = endereco_entrega.cliente_id
ORDER BY pedidos.data_pedido;

-- 2: Retorna os pedidos feitos na data específica com identificação de clientes, produtos e endereço de entrega.
SELECT
    pedidos.data_pedido,
    clientes.nome nome_cliente,
    produtos.nome nome_produto,
    itens_pedido.quantidade,
    itens_pedido.preco_unitario,
    endereco_entrega.endereco,
    endereco_entrega.cidade,
    endereco_entrega.estado,
    endereco_entrega.cep
FROM pedidos
JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
JOIN itens_pedido ON pedidos.pedido_id = itens_pedido.pedido_id
JOIN produtos ON itens_pedido.produto_id = produtos.produto_id
JOIN endereco_entrega ON pedidos.cliente_id = endereco_entrega.cliente_id
WHERE pedidos.data_pedido = '2021-09-23';

