# Curso Alura Modelagem de banco de dados relacional: entendendo SQL

Entendendo SQL através da modelagem relacional de um banco de dados, usando o SGBD MySQL com dados fictícios de um e-commerce de livros chamado Clube do Livro.  

1. [Introdução](#1-introdução)
2. [Escolha do SGBD](#2-escolha-do-sgbd)
3. [Esquema e Tabelas](#3-esquema-e-tabelas)
4. [Inserindo dados](#4-inserindo-dados)
5. [Consultando e alterando os dados](#5-consultando-e-alterando-os-dados)
6. [Unindo tabelas](#6-unindo-tabelas)

## 1. Introdução 

Fernanda é desenvolvedora no Clube do Livro, um e-commerce de artigos literários e livros. Ela recebeu de Artur, seu colega, esse modelo relacional, baseado em uma entrevista que mapeou as necessidades e os requisitos da empresa. 

![Modelo Relacional](modelo_relacional.png)

Nós temos quatro principais tabelas. A primeira tem os livros e as suas características, que está relacionada com a tabela “estoque”, que contém a quantidade de livros disponíveis na empresa. Temos também o histórico de pedidos na tabela “vendas”, que está relacionada com os vendedores do Clube do Livro.

A missão de Fernanda e sua equipe é fazer a implementação desse modelo relacional em um sistema de gerenciamento de banco de dados, ou SGBD, se você preferir. Após a implementação, será feita a inserção de informações nesse banco de dados. Além de consultar e alterar essas informações usando a linguagem SQL.

## 2. Escolha do SGBD

Júlia, que é desenvolvedora júnior da equipe de Fernanda, ficou curiosa para saber como iremos gerenciar o banco de dados aqui no Clube do Livro.

Fernanda logo explicou, que mesmo usando o SQL como linguagem de acesso aos dados, existem vários sistemas de gerenciamento de banco de dados, disponíveis no mercado.

Dentro os SGBDs mais comuns, podemos citar o SQL Server, o MySQL, o SQLite e até o DB2 da IBM, por exemplo. Mesmo cada um tempo as suas peculiaridades, todos usam a linguagem SQL para transformar um modelo de alto nível, ou seja, aquele que está mais próximo do nosso entendimento, para o modelo de baixo nível, que está mais próximo da linguagem do computador.

**A equipe escolheu o [MySQL](https://dev.mysql.com/) para manuseio e organização dos dados.** Além de ser uma opção gratuita, ele está entre os SGBDs mais difundidos e utilizados.

## 3. Esquema e Tabelas

Júlia ficou animada para criar todas as tabelas aqui no MySQL, e já perguntou para a Fernanda por qual tabela iríamos começar. Fernanda explicou que antes de criar qualquer tabela, era necessário **criar um esquema que irá reunir todas as tabelas que iríamos criar.**

```sql
CREATE SCHEMA CLUBE_DO_LIVRO;
```

- O modelo relacional do Clube do Livro define quatro diferentes tipos de tabelas: Livros, Estoque, Vendas e Vendedores.

```sql
#Tabela Livros:
CREATE TABLE LIVROS (
    ID_LIVRO INT NOT NULL,
    NOME_LIVRO VARCHAR(100) NOT NULL,
    AUTORIA VARCHAR(100) NOT NULL,
    EDITORA VARCHAR(100) NOT NULL,
    CATEGORIA VARCHAR(100) NOT NULL,
    PREÇO DECIMAL(5,2) NOT NULL,  
 PRIMARY KEY (ID_LIVRO)
);

#Tabela Estoque:
CREATE TABLE ESTOQUE (
    ID_LIVRO INT NOT NULL,
    QTD_ESTOQUE INT NOT NULL,
 PRIMARY KEY (ID_LIVRO)
);

#Tabela Vendas:
CREATE TABLE VENDAS (
    ID_PEDIDO INT NOT NULL,
    ID_VENDEDOR INT NOT NULL,
    ID_LIVRO INT NOT NULL,
    QTD_VENDIDA INT NOT NULL,
    DATA_VENDA DATE NOT NULL,
 PRIMARY KEY (ID_VENDEDOR,ID_PEDIDO)
);

#Tabela Vendedores:
CREATE TABLE VENDEDORES (
    ID_VENDEDOR INT NOT NULL,
    NOME_VENDEDOR VARCHAR(255) NOT NULL,
 PRIMARY KEY (ID_VENDEDOR)
);COPIAR CÓDIGO
```

- Criando todas as tabelas, Júlia percebeu que elas já foram construídas com a chave primária. Mas ainda não entendeu como elas se relacionam. Como será que a tabela “estoque” está relacionada com a tabela “livros”, por exemplo? Fernanda explicou, que para isso precisamos **declarar a chave estrangeira, que é o campo que vai fazer a relação entre as tabelas.**

```sql
#Relação entre as tabelas Vendas e Livros
ALTER TABLE VENDAS ADD CONSTRAINT CE_VENDAS_LIVROS
FOREIGN KEY (ID_LIVRO)
REFERENCES LIVROS (ID_LIVRO)
ON DELETE NO ACTION
ON UPDATE NO ACTION;COPIAR CÓDIGO

#Relação entre as tabelas Livros e Estoque
ALTER TABLE ESTOQUE ADD CONSTRAINT CE_ESTOQUE_LIVROS
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
```

## 4. Inserindo Dados

Agora que o nosso modelo relacional já está implementado, podemos inserir as informações. Fernanda explicou que a inserção de dados pode ser usada através do comando `INSERT INTO`. E Júlia logo perguntou por qual tabela iríamos começar.

- Fernanda explicou que podemos começar por qualquer tabela, desde que a relação entre essas duas tabelas esteja desativada. Ou seja, aquela chave estrangeira não esteja mais ligando uma tabela a outra.

```sql
SET FOREIGN_KEY_CHECKS = 0;
```
- Quando criamos a tabela `LIVROS` definimos os campos `ID_LIVRO` como `INT`, `NOME_LIVRO`, a `AUTORIA`, a `EDITORA` e a `CATEGORIA` como `VARCHAR(100)` e o último campo o `PREÇO` como `DECIMAL(5,2)`.Seguindo a ordem desses campos podemos inserir o livro Percy Jackson e o Ladrão de Raios e todas essas características usando o comando abaixo:

```sql
INSERT INTO LIVROS VALUES (
 1,
'Percy Jackson e o Ladrão de Raios',
'Rick Riordan',
'Intrínseca',
'Aventura',
34.45
);
```
- Júlia ficou responsável por inserir 11 linhas na tabela “Livros”, e ficou pensando se teria uma maneira de otimizar os seus códigos. Ela inseriu as características dos livros: “A Volta ao Mundo em 80 Dias”, “O Cortiço” e “Dom Casmurro”. Mas, conseguimos perceber que todo esses comandos precisam ser executados unicamente.

> Ela mostrou esse código para a Fernanda, para ver se tem outra maneira de otimizá-lo. Fernanda explicou, que dá para inserir várias linhas em uma única execução. Para isso, ela vai precisar copiar cada linha, cada informação que está entre parênteses e separar por vírgula. 

```sql
INSERT INTO LIVROS VALUES
(2,    'A Volta ao Mundo em 80 Dias',    'Júlio Verne',         'Principis',     'Aventura',    21.99),
(3,    'O Cortiço',                     'Aluísio de Azevedo',  'Panda Books',   'Romance',    47.8),
(4,    'Dom Casmurro',                     'Machado de Assis',    'Via Leitura',   'Romance',    19.90),
(5,    'Memórias Póstumas de Brás Cubas',    'Machado de Assis',    'Antofágica',    'Romance',    45),
(6,    'Quincas Borba',                 'Machado de Assis',    'L&PM Editores', 'Romance',    48.5),
(7,    'Ícaro',                             'Gabriel Pedrosa',     'Ateliê',          'Poesia',    36),
(8,    'Os Lusíadas',                     'Luís Vaz de Camões',  'Montecristo',   'Poesia',    18.79),
(9,    'Outros Jeitos de Usar a Boca',    'Rupi Kaur',          'Planeta',          'Poesia',    34.8);
```

- Jorge é desenvolvedor júnior da equipe de Fernanda, e estava acompanhando todo esse processo. Ele ficou responsável por continuar o preenchimento das informações. Só que ao se deparar com o seu código, percebeu que escreveu as informações em uma ordem diferente da ordem da tabela. 

> Percebendo a preocupação de Jorge, Fernanda logo disse que é possível inserir informações fora de ordem, porém, para isso, é preciso declarar a ordem que você deseja, que você inseriu os seus campos. E essa ordem deve ser declarada antes do comando `Values`.

```sql
#Inserindo valores fora de ordem
INSERT INTO LIVROS 
(CATEGORIA, AUTORIA, NOME_LIVRO, EDITORA, ID_LIVRO, PRECO)
VALUES
('Biografia' ,    'Malala Yousafzai', 'Eu sou Malala'       , 'Companhia das Letras', 11, 22.32),
('Biografia' ,    'Michelle Obama'  , 'Minha história'      , 'Objetiva'            ,    12,    57.90),
('Biografia' ,    'Anne Frank'      , 'Diário de Anne Frank', 'Pe Da Letra'         , 13, 34.90);
```

## 5. Consultando e alterando os dados 

Após inserir todos os dados, Júlia ficou com uma dúvida: como podemos conferir todas as informações que foram inseridas? Fernanda explicou que existe um comando bem simples, que pode nos mostrar isso, e que quase que forma uma frase em inglês.

```sql
SELECT ID_LIVRO AS "Código do Livro" FROM LIVROS;
```

- Jorge também ficou animado para verificar os dados que foram inseridos, e usou o comando `SELECT * FROM LIVROS`, para selecionar todas as informações da tabela “Livros”. Mas ele estava mais interessado em verificar apenas as biografias. Para isso, precisamos montar uma consulta mais específica, usando o comando `WHERE`, para construir um filtro.

```sql
SELECT * FROM LIVROS
WHERE CATEGORIA = "BIOGRAFIA";
```

- Depois que o comercial ficou sabendo que as informações já estavam cadastradas nas tabelas, demandou duas tabelas: A primeira, com todos os romances que fossem mais baratos que R$48,00. E a segunda tabela, com todas as poesias que não fossem nem de Camões, nem de Pedrosa. Vamos construir a primeira tabela.

```sql
#1.Uma tabela com os romances que custam menos de 48 reais.
SELECT * FROM LIVROS
WHERE CATEGORIA = "ROMANCE" AND PRECO <48;

#2. Poesias que não são nem de Luís Vaz de Camões nem de Gabriel Pedrosa. 
SELECT * FROM LIVROS
WHERE CATEGORIA = "POESIA" AND NOT (AUTORIA = "Luís Vaz de Camões" OR AUTORIA = "Gabriel Pedrosa")
```

- Júlia queria entender quais foram os livros pedidos, e lá no histórico de pedidos da tabela Venda usou o comando `SELECT * FROM VENDAS` para dar uma olhada em todas as informações. Porém, ela percebeu que os números dos livros se repetem, e ela queria uma seleção única desses livros.Para isso, é preciso fazer uma mudança nesse comando, acrescentando o comando `DISTINCT`.

```sql
SELECT DISTINCT ID_LIVRO FROM VENDAS;
```

- E ela ficou mais curiosa ainda para saber apenas os livros que foram vendidos pelo vendedor 1.

```sql
SELECT DISTINCT ID_LIVRO FROM VENDAS
WHERE ID_VENDEDOR = 1
ORDER BY ID_LIVRO;
```

- O comercial do Clube do Livro estava acompanhando toda a implementação do modelo relacional e da inserção de formações pela equipe de Fernanda. E ao conferir as informações, percebeu que “Os Lusíadas” estava na tabela de livros, mas ele não estava mais sendo vendido pela empresa. Então, solicitou a retirada, a exclusão dessa linha da tabela. 

```sql
SELECT * FROM LIVROS; #"Os Lusíadas --> ID_LIVRO = 8

DELETE FROM LIVROS WHERE ID_LIVRO = 8;
```

- Aproveitando essas alterações nas tabelas, o comercial fez mais um pedido, nessa nova temporada, todos os livros estariam com 10% de desconto, e para isso, precisaríamos alterar todos os preços da tabela “Livros”.

```sql
UPDATE LIVROS SET PRECO = 0.9*PRECO;
```

## 6. Unindo Tabelas

Como acompanhamos nos passos anteriores, Júlia já fez a implementação do modelo relacional, criou tabelas e relações e alimentou todas com informações. E após algumas consultas, Júlia ficou com dificuldades de criar uma tabela em que tem tanto os nomes dos vendedores quanto o histórico de pedidos.

Essa dificuldade se deu porque na tabela “Vendedores” tem o código do vendedor e o nome do vendedor, mas na tabela “Histórico de pedidos” tem apenas o código do vendedor, não tendo nome.

Ela pediu ajuda para a Fernanda, para montar essa consulta que une campos de tabelas diferentes. 

```sql
SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR, SUM(VENDAS.QTD_VENDIDA)
FROM VENDAS, VENDEDORES
WHERE VENDAS.ID_VENDEDOR = VENDEDORES.ID_VENDEDOR
GROUP BY VENDAS.ID_VENDEDOR;
```

- Para Júlia identificar o nome dos livros que foram vendidos na tabela VENDAS há três formas:
```sql
#1
SELECT LIVROS.NOME_LIVRO,
           VENDAS.QTD_VENDIDA
FROM LIVROS,  VENDAS
WHERE VENDAS.ID_LIVRO = LIVROS.ID_LIVRO;

#2 - Usando um apelido com o comando AS e referenciando esse apelido nos campos selecionados na consulta
SELECT A.NOME_LIVRO,
           B.QTD_VENDIDA
FROM LIVROS AS  A,  VENDAS AS  B
WHERE B.ID_LIVRO = A.ID_LIVRO;

#3 - Omitindo o AS
SELECT A.NOME_LIVRO,
           B.QTD_VENDIDA
FROM LIVROS  A,  VENDAS   B
WHERE B.ID_LIVRO = A.ID_LIVRO;
```

- Na programação, há diversas maneiras de chegar em uma mesma solução. Para aquele problema de Júlia, que ela queria saber a quantidade de livros por pessoa vendedora, ela também poderia ter usado o comando `INNER JOIN`, que faz a junção entre tabelas e mostra informações que existem em ambas as tabelas referenciadas.

```sql
SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR, SUM(VENDAS.QTD_VENDIDA)
FROM VENDAS INNER JOIN VENDEDORES
ON VENDAS.ID_VENDEDOR = VENDEDORES.ID_VENDEDOR
GROUP BY VENDAS.ID_VENDEDOR;
```

- Ao analisar o histórico de pedidos, Júlia ficou pensando: será que todos os livros da nossa base de dados foram vendidos? Ela ficou pensando nessa dúvida, mas não sabia muito bem como construir uma consulta para trazer essa resposta. Fernanda disse que tem muitas maneiras de construir uma consulta que traga esse resultado, mas que ela poderia usar o `LEFT JOIN`, que é responsável por trazer informações da primeira tabela do join, ou seja, aquela tabela à esquerda, e procurar correspondência, informações, na segunda tabela do join, a tabela à direita.

```sql
SELECT LIVROS.NOME_LIVRO, 
	   VENDAS.QTD_VENDIDA
FROM LIVROS LEFT JOIN VENDAS
ON LIVROS.ID_LIVRO = VENDAS.ID_LIVRO
WHERE VENDAS.QTD_VENDIDA IS NULL;
```

- Fazendo as suas pesquisas, a Júlia percebeu que não tem apenas o `LEFT JOIN`, temos também a junção à direita, o `RIGHT JOIN`, que mantém informações da segunda tabela, ou seja, a tabela à direta do join. Vamos manter essas consultas, mas mudar o `RIGHT JOIN` para sabermos o que aparece.

```sql
SELECT VENDAS.ID_LIVRO, 
       LIVROS.NOME_LIVRO, 
	   VENDAS.QTD_VENDIDA
FROM LIVROS RIGHT JOIN VENDAS
ON LIVROS.ID_LIVRO = VENDAS.ID_LIVRO;
```



