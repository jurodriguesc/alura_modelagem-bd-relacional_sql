CREATE SCHEMA CLUBE_DO_LIVRO;

#Tabela Livros
CREATE TABLE LIVROS (
    ID_LIVRO INT NOT NULL,
    NOME_LIVRO VARCHAR(100) NOT NULL, 
    AUTORIA VARCHAR(100) NOT NULL, 
    EDITORA VARCHAR(100) NOT NULL, 
    CATEGORIA VARCHAR(100) NOT NULL, 
    PRECO DECIMAL(5,2) NOT NULL, 
    PRIMARY KEY (ID_LIVRO)
);

#Tabela Estoque
CREATE TABLE ESTOQUE (
    ID_LIVRO INT NOT NULL,
    QTD_ESTOQUE INT NOT NULL,
    PRIMARY KEY (ID_LIVRO)
);

#Tabela Vendas
CREATE TABLE VENDAS (
    ID_PEDIDO INT NOT NULL,
    ID_VENDEDOR INT NOT NULL,
    ID_LIVRO INT NOT NULL,
    QTD_VENDIDA INT NOT NULL,
    DATA_VENDA DATE NOT NULL,
    PRIMARY KEY (ID_VENDEDOR,ID_PEDIDO)
);

#Tabela Vendedores
CREATE TABLE VENDEDORES (
    ID_VENDEDOR INT NOT NULL,
    NOME_VENDEDOR VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_VENDEDOR)
);

#Relação entre as tabelas Livros e Estoque
ALTER TABLE ESTOQUE ADD CONSTRAINT CE_ESTOQUE_LIVROS
FOREIGN KEY (ID_LIVRO)
REFERENCES LIVROS (ID_LIVRO)
ON DELETE NO ACTION
ON UPDATE NO ACTION; 

#Relação entre as tabelas Vendas e Livros
ALTER TABLE VENDAS ADD CONSTRAINT CE_VENDAS_LIVROS
FOREIGN KEY (ID_LIVRO)
REFERENCES LIVROS (ID_LIVRO)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

#Relação entre as tabelas Vendedores e Vendas
ALTER TABLE VENDAS ADD CONSTRAINT CE_VENDAS_VENDEDORES
FOREIGN KEY (ID_VENDEDOR)
REFERENCES VENDEDORES (ID_VENDEDOR)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO LIVROS VALUES (
    1, 
    "Percy Jackson e o Ladrão de Raios",
    "Rick Riodan",
    "Intrínseca",
    "Aventura", 
    34.65
);

#Informações da tabela LIVROS
INSERT INTO LIVROS VALUES
(2,    'A Volta ao Mundo em 80 Dias',    'Júlio Verne',         'Principis',     'Aventura',    21.99),
(3,    'O Cortiço',                     'Aluísio de Azevedo',  'Panda Books',   'Romance',    47.8),
(4,    'Dom Casmurro',                     'Machado de Assis',    'Via Leitura',   'Romance',    19.90),
(5,    'Memórias Póstumas de Brás Cubas',    'Machado de Assis',    'Antofágica',    'Romance',    45),
(6,    'Quincas Borba',                 'Machado de Assis',    'L&PM Editores', 'Romance',    48.5),
(7,    'Ícaro',                             'Gabriel Pedrosa',     'Ateliê',          'Poesia',    36),
(8,    'Os Lusíadas',                     'Luís Vaz de Camões',  'Montecristo',   'Poesia',    18.79),
(9,    'Outros Jeitos de Usar a Boca',    'Rupi Kaur',          'Planeta',          'Poesia',    34.8);

#Informações da tabela VENDEDORES
INSERT INTO VENDEDORES 
VALUES
(1,'Paula Rabelo'),
(2,'Juliana Macedo'),
(3,'Roberto Barros'),
(4,'Barbara Jales');

#Informações da tabela VENDAS
INSERT INTO VENDAS 
VALUES 
(1, 3, 7, 1, '2020-11-02'),
(2, 4, 8, 2, '2020-11-02'),
(3, 4, 4, 3, '2020-11-02'),
(4, 1, 7, 1, '2020-11-03'),
(5, 1, 6, 3, '2020-11-03'),
(6, 1, 9, 2, '2020-11-04'),
(7, 4, 1, 3, '2020-11-04'),
(8, 1, 5, 2, '2020-11-05'),
(9, 1, 2, 1, '2020-11-05'),
(10, 3, 8, 2, '2020-11-11'),
(11, 1, 1, 4, '2020-11-11'),
(12, 2, 10, 10, '2020-11-11'),
(13, 1, 12, 5, '2020-11-18'),
(14, 2, 4, 1, '2020-11-25'),
(15, 3, 13, 2,'2021-01-05'),
(16, 4, 13, 1, '2021-01-05'),
(17, 4, 4, 3, '2021-01-06'),
(18, 2, 12, 2, '2021-01-06');

#Informações da tabela ESTOQUE
INSERT INTO ESTOQUE 
VALUES
(1,  7),
(2,  10),
(3,  2),
(8,  4),
(10, 5),
(11, 3),
(12, 3);

#Inserindo valores fora de ordem
INSERT INTO LIVROS 
(CATEGORIA, AUTORIA, NOME_LIVRO, EDITORA, ID_LIVRO, PRECO)
VALUES
('Biografia' ,    'Malala Yousafzai', 'Eu sou Malala'       , 'Companhia das Letras', 11, 22.32),
('Biografia' ,    'Michelle Obama'  , 'Minha história'      , 'Objetiva'            ,    12,    57.90),
('Biografia' ,    'Anne Frank'      , 'Diário de Anne Frank', 'Pe Da Letra'         , 13, 34.90);

SET FOREIGN_KEY_CHECKS = 1

#######       Código Extra      ########
# Excluindo uma tabela
DROP TABLE VENDEDORES;

#Consultando dados
SELECT * FROM LIVROS;

SELECT ID_LIVRO AS "Código do Livro" FROM LIVROS;

SELECT * FROM LIVROS
WHERE CATEGORIA = "BIOGRAFIA";

#Primeira demanda do Comercial: Uma tabela com os romances  que custam menos de 48 reais.
SELECT * FROM LIVROS
WHERE CATEGORIA = "ROMANCE" AND PRECO <48;

#Segunda demanda do Comercial: Poesias que não são nem de Luís Vaz de Camões nem de Gabriel Pedrosa. 
SELECT * FROM LIVROS
WHERE CATEGORIA = "POESIA" AND NOT (AUTORIA = "Luís Vaz de Camões" OR AUTORIA = "Gabriel Pedrosa")

SELECT * FROM VENDAS;

SELECT DISTINCT ID_LIVRO FROM VENDAS;

SELECT DISTINCT ID_LIVRO FROM VENDAS
WHERE ID_VENDEDOR = 1
ORDER BY ID_LIVRO;

#Excluindo Os Lusíadas
SELECT * FROM LIVROS; #"Os Lusíadas --> ID_LIVRO = 8

DELETE FROM LIVROS WHERE ID_LIVRO = 8;