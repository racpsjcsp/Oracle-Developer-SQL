CREATE TABLESPACE PROJETO_FINAL
DATAFILE 'C:\Users\Rafael\Desktop\Fatec\ADS4\Banco-de-Dados\projeto_final.dbf' SIZE 1M
AUTOEXTEND ON;

CREATE USER RAFAEL
IDENTIFIED BY ALUNO
DEFAULT TABLESPACE PROJETO_FINAL
QUOTA UNLIMITED ON PROJETO_FINAL;

GRANT DBA TO RAFAEL WITH ADMIN OPTION;

----------------------------------------


--CREATE TABLE PARCEIRO_COMERCIAL (
--PARC_PJ VARCHAR(20),
--COD_FORN VARCHAR(5),
--COD_CLIENTE VARCHAR(5),

--CONSTRAINT FK_COD_FORN FOREIGN KEY(COD_FORN) REFERENCES CLIENTE
--);

CREATE TABLE ENDERECO (
COD_ENDERECO NUMBER PRIMARY KEY NOT NULL,
LOGRADOURO VARCHAR(100),
NUMERO VARCHAR(5),
BAIRRO VARCHAR(50),
CIDADE VARCHAR(50),
ESTADO VARCHAR(20),
CEP VARCHAR(10)
);

CREATE TABLE CLIENTE (
COD_CLIENTE NUMBER PRIMARY KEY NOT NULL,
NOME_CLIENTE VARCHAR(100),
CPF_CLIENTE VARCHAR(15) UNIQUE,
INSCRICAO_ESTADUAL_CLIENTE VARCHAR(15) UNIQUE,
CNPJ_CLIENTE VARCHAR(20) UNIQUE,
BLOQ_CLIENTE NUMBER(1),
LIMITE_COMPRA_CLIENTE NUMBER(5),
DESCRICAO_CLIENTE VARCHAR(200),
FORMA_PAGAMENTO_CLIENTE VARCHAR(100),
RAZAO_SOCIAL_CLIENTE VARCHAR(10),
ENDERECO_CLIENTE NUMBER,

CONSTRAINT CK_BLOQ_CLIENTE CHECK(BLOQ_CLIENTE IN(0,1)),
CONSTRAINT FK_ENDERECO_CLIENTE FOREIGN KEY(ENDERECO_CLIENTE) REFERENCES ENDERECO(COD_ENDERECO)
);

CREATE TABLE FORNECEDOR (
COD_FORN NUMBER PRIMARY KEY NOT NULL,
NOME_FORN VARCHAR(100),
CPF_FORN VARCHAR(15) UNIQUE,
INSCRICAO_ESTADUAL_FORN VARCHAR(15) UNIQUE,
CNPJ_FORN VARCHAR(20) UNIQUE,
BLOQ_FORN NUMBER(1),
DESCRICAO_FORN VARCHAR,
FORMA_PAGAMENTO_FORN VARCHAR,
RAZAO_SOCIAL_FORN VARCHAR(10),
ENDERECO_FORN NUMBER,

CONSTRAINT CK_BLOQ_FORN CHECK(BLOQ_FORN IN(0,1)),
CONSTRAINT FK_ENDERECO_FORN FOREIGN KEY(ENDERECO_FORN) REFERENCES ENDERECO(COD_ENDERECO)
);

CREATE TABLE COMPRA (
COD_COMPRA NUMBER PRIMARY KEY NOT NULL,
COMPRA_DATA DATE,
COMPRA_QTDE NUMBER,
COMPRA_NFE_ENTRADA VARCHAR(20),
COD_FORN NUMBER,

CONSTRAINT FK_COD_FORN FOREIGN KEY(COD_FORN) REFERENCES FORNECEDOR(COD_FORN)
);

CREATE TABLE ESTOQUE_PRODUTO (
PROD_COD NUMBER PRIMARY KEY NOT NULL,
ESTOQUE_QTDE_ATUAL NUMBER,
ESTOQUE_QTDE_MINIMA NUMBER,
ESTOQUE_PROD_VALIDADE DATE,
ESTOQUE_DATA_INVENTARIO DATE,
ESTOQUE_INVENTARIO NUMBER,
DATA_DISPONIBILIZACAO DATE,
PROD_DESC VARCHAR(50),
PROD_PESO NUMBER(4,2),
PROD_DIMENSAO VARCHAR(15),
PROD_PRECO_CUSTO NUMBER(6,2),
PROD_PRECO_VENDA NUMBER(6,2),
PROD_PRECO_FORN NUMBER(6,2),
PROD_PERC_LUCRO NUMBER(3,1)
);


CREATE TABLE VENDA (
COD_VENDA NUMBER PRIMARY KEY NOT NULL,
VENDA_DATA DATE,
VENDA_QTDE NUMBER,
VENDA_NFE_SAIDA VARCHAR(20),
VENDA_FRETE_ESTIMADO NUMBER(6,2),
COD_CLIENTE NUMBER,

CONSTRAINT FK_COD_CLIENTE FOREIGN KEY(COD_CLIENTE) REFERENCES CLIENTE(COD_CLIENTE)
);

CREATE TABLE PRODUTO_COMPRADO (
PROD_QTDE_COMP NUMBER,
PROD_VALOR_COMP NUMBER(6,2),
COD_COMPRA NUMBER,
COD_PROD NUMBER,

CONSTRAINT PK_COD_COMPRA_COD_PROD PRIMARY KEY(COD_COMPRA,COD_PROD),
CONSTRAINT FK_COD_COMPRA FOREIGN KEY(COD_COMPRA) REFERENCES COMPRA(COD_COMPRA),
CONSTRAINT FK_COD_PROD_COMP FOREIGN KEY(COD_PROD) REFERENCES ESTOQUE_PRODUTO(PROD_COD)

);



CREATE TABLE PRODUTO_VENDIDO (
PROD_QTDE_VEND VARCHAR(6),
PROD_VALOR_VEND NUMBER(6,2),
VENDA_NFE_SAIDA NUMBER,
COD_VENDA NUMBER,
COD_PROD NUMBER,

CONSTRAINT PK_COD_VENDA_COD_PROD PRIMARY KEY(COD_VENDA, COD_PROD),
CONSTRAINT FK_COD_VENDA FOREIGN KEY(COD_VENDA) REFERENCES VENDA(COD_VENDA),
CONSTRAINT FK_COD_PROD_VEND FOREIGN KEY(COD_PROD) REFERENCES ESTOQUE_PRODUTO(PROD_COD)

);


---------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_ENDERECO;
INSERT INTO ENDERECO(COD_ENDERECO, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP) VALUES (
SEQ_ENDERECO.NEXTVAL,
'Avenida Alexanderplatz',
'110',
'Mitte',
'Berlim',
'Brandenburgo',
'41420-430'
);

SELECT * FROM ENDERECO;

---------------------------------------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_FORNECEDOR;
INSERT INTO FORNECEDOR(COD_FORN, NOME_FORN, CPF_FORN, INSCRICAO_ESTADUAL_FORN, CNPJ_FORN, BLOQ_FORN,
DESCRICAO_FORN, FORMA_PAGAMENTO_FORN, RAZAO_SOCIAL_FORN, ENDERECO_FORN) VALUES (
SEQ_FORNECEDOR.NEXTVAL,
'Mobil Gear',
'',
'666.666.666.666',
'006.006.006.006',
0,
'Acessorios para Celular',
'Paypal',
'Mobil Gear Ltda',
15
);


SELECT * FROM FORNECEDOR;



ALTER TABLE FORNECEDOR MODIFY (RAZAO_SOCIAL_FORN VARCHAR(30));

SELECT * FROM FORNECEDOR, ENDERECO WHERE FORNECEDOR.ENDERECO_FORN = ENDERECO.COD_ENDERECO;

DELETE FROM FORNECEDOR WHERE COD_FORN = 2;

-----------------------------------------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_COMPRA;
INSERT INTO COMPRA(COD_COMPRA, COMPRA_DATA, COMPRA_QTDE, COMPRA_NFE_ENTRADA, COD_FORN) VALUES (
SEQ_COMPRA.NEXTVAL,
TO_DATE('10-OCT-2002','DD-MON-YYYY'),
100,
1212121212,
2
);

SELECT * FROM COMPRA;
DELETE FROM COMPRA WHERE COD_COMPRA = 6;

--DROP TABLE PRODUTO_COMPRADO;
--DROP TABLE COMPRA;
--DROP TABLE PRODUTO_VENDIDO;
--DROP TABLE VENDA;

-----------------------------------------------------------------------------------------------------------------

SELECT * FROM VENDA;

CREATE SEQUENCE SEQ_VENDA;
INSERT INTO VENDA(COD_VENDA, VENDA_DATA, VENDA_QTDE, VENDA_NFE_SAIDA, VENDA_FRETE_ESTIMATO, COD_CLIENTE) VALUES (
SEQ_VENDA.NEXTVAL,
TO_DATE('11-OCT-2002','DD-MON-YYYY'),
325,
2323232323,
1234,00

);

--------------------------------------------------------------------------------------------------------------

SELECT * FROM PRODUTO_COMPRADO;

INSERT INTO PRODUTO_COMPRADO(PROD_QTDE_COMP, PROD_VALOR_COMP, COD_COMPRA, COD_PROD) VALUES (


