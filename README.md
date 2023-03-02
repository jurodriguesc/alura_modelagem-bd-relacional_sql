# Curso Alura Modelagem de banco de dados relacional: entendendo SQL

Entendendo SQL através da modelagem relacional de um banco de dados, usando o SGBD MySQL com dados fictícios de um e-commerce de livros chamado Clube do Livro.  

1. [Introdução](#1-introdução)
2. [Escolha do SGBD](#2-escolha-do-sgbd)
3. [Esquema e Tabelas](#3-esquema-e-tabelas)
4. [Inserindo dados](#4-inserindo-dados)
5. [Consultando e alterando os dados](#4-consultando-e-alterando-os-dados)
6. [Unindo tabelas](#5-unindo-tabelas)

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
- Quando criamos a tabela LIVROS definimos os campos ID_LIVRO como INT, NOME_LIVRO, a AUTORIA, a EDITORA e a CATEGORIA como VARCHAR(100) e o último campo o PREÇO como DECIMAL(5,2).Seguindo a ordem desses campos podemos inserir o livro Percy Jackson e o Ladrão de Raios e todas essas características usando o comando abaixo:

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
