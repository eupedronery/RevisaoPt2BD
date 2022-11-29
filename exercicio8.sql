CREATE DATABASE Exercicio8
GO

USE Exercicio8
GO

CREATE TABLE cliente (
codigo                INT                       NOT NULL,
nome                  VARCHAR(30)               NOT NULL,
endereco              VARCHAR(40)               NOT NULL,
telefone              VARCHAR(8)                NOT NULL,
telefone_comercial    VARCHAR(8)                NULL
PRIMARY KEY(codigo)
)
GO


CREATE TABLE tipomercadorias (
codigo                INT                       NOT NULL,
nome                  VARCHAR(20)               NOT NULL  
PRIMARY KEY(codigo)      
)
GO


CREATE TABLE corredor (
codigo                      INT                       NOT NULL,
nome                        VARCHAR(30)               NULL,
tipomercadorias_codigo      INT                       NULL
PRIMARY KEY(codigo)
FOREIGN KEY(tipomercadorias_codigo)  REFERENCES  tipomercadorias(codigo)
)
GO


CREATE TABLE mercadoria (
codigo                      INT                       NOT NULL,
nome                        VARCHAR(30)               NOT NULL,
corredor_codigo             INT                       NOT NULL,
tipomercadorias_codigo      INT                       NOT NULL,
valor                       DECIMAL(7, 2)             NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (corredor_codigo)          REFERENCES corredor(codigo),
FOREIGN KEY (tipomercadorias_codigo)   REFERENCES tipomercadorias(codigo)
)
GO


CREATE TABLE compra (
nota_fiscal                 INT                       NOT NULL,
codigo_cliente              INT                       NOT NULL,
valor                       DECIMAL(7, 2)             NOT NULL
PRIMARY KEY (nota_fiscal)
FOREIGN KEY (codigo_cliente)    REFERENCES cliente(codigo)
)
GO



INSERT INTO cliente VALUES 
            (1, 'Luis Paulo', 'R. Xv de Novembro, 100', '45657878', NULL),
			(2, 'Maria Fernanda', 'R. Anhaia, 1098', '27289098', '40040090'),
			(3, 'Ana Claudia', 'Av. Voluntários da Pátria, 876', '21346548', NULL),
			(4, 'Marcos Henrique', 'R. Pantojo, 76', '51425890', '30394540'),
			(5, 'Emerson Souza', 'R. Pedro Álvares Cabral, 97', '44236545', '39389900'),
			(6, 'Ricardo Santos', 'Trav. Hum, 10', '98789878', NULL)
GO

INSERT INTO tipomercadorias (codigo, nome)
VALUES                      (10001, 'Pães')
GO

INSERT INTO tipomercadorias (codigo, nome)
VALUES                      (10002, 'Frios')
GO

INSERT INTO tipomercadorias (codigo, nome)
VALUES                      (10003, 'Bolacha')
GO

INSERT INTO tipomercadorias (codigo, nome)
VALUES                      (10004, 'Clorados')
GO

INSERT INTO tipomercadorias (codigo, nome)
VALUES                      (10005, 'Frutas')
GO

INSERT INTO tipomercadorias (codigo, nome)
VALUES                      (10006, 'Esponjas')
GO

INSERT INTO tipomercadorias (codigo, nome)
VALUES                      (10007, 'Massas')
GO

INSERT INTO tipomercadorias (codigo, nome)
VALUES                      (10008, 'Molhos')
GO


INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES               (101, 10001, 'Padaria')
GO

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES               (102, 10002, 'Calçados')
GO

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES               (103, 10003, 'Biscoitos')
GO

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES               (104, 10004, 'Limpeza')
GO

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES               (105, NULL, NULL)
GO

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES               (106, NULL, NULL)
GO

INSERT INTO corredor (codigo, tipomercadorias_codigo, nome)
VALUES               (107, 10007, 'Congelados')
GO



INSERT INTO mercadoria VALUES
       (1001, 'Pão de Forma', 101, 10001, 3.5),
	   (1002, 'Presunto', 101, 10002, 2.0),
	   (1003, 'Cream Cracker', 103, 10003, 4.5),
	   (1004, 'Água Sanitária', 104, 10004, 6.5),
	   (1005, 'Maçã', 105, 10005, 0.9),
	   (1006, 'Palha de Aço', 106, 10006, 1.3),
	   (1007, 'Lasanha', 107, 10007, 9.7)
GO




INSERT INTO compra (nota_fiscal, codigo_cliente, valor)
VALUES             (1234, 2, 200)
GO

INSERT INTO compra (nota_fiscal, codigo_cliente, valor)
VALUES             (2345, 4, 156)
GO

INSERT INTO compra (nota_fiscal, codigo_cliente, valor)
VALUES             (3456, 6, 354)
GO

INSERT INTO compra (nota_fiscal, codigo_cliente, valor)
VALUES             (4567, 3, 19)
GO


--Valor da Compra de Luis Paulo
SELECT  valor

FROM compra
WHERE codigo_cliente IN (
                        SELECT codigo
						FROM cliente
						WHERE nome = 'Luis Paulo'
						)
GO

--Valor da Compra de Marcos Henrique
SELECT  valor

FROM compra
WHERE codigo_cliente IN (
                        SELECT codigo
						FROM cliente
						WHERE nome = 'Marcos Henrique'
						)
GO

--Endereço e telefone do comprador de Nota Fiscal = 4567

SELECT endereco,
       telefone
FROM cliente
WHERE codigo IN (
                SELECT codigo_cliente
				FROM compra
				WHERE nota_fiscal = 4567
				)
GO
--Valor da mercadoria cadastrada do tipo " Pães"

SELECT distinct m.valor
FROM mercadoria m, tipomercadorias tm
WHERE m.tipomercadorias_codigo = tm.codigo
      AND tm.nome = 'Pães'
GO

--Nome do corredor onde está a Lasanha

SELECT co.nome
FROM corredor co, tipomercadorias tm, mercadoria m
WHERE co.codigo = m.corredor_codigo
      AND m.tipomercadorias_codigo = tm.codigo
	  AND m.nome = 'Lasanha'
GO


--Nome do corredor onde estão os clorados

SELECT co.nome
FROM corredor co, tipomercadorias tm, mercadoria m
WHERE co.codigo = m.corredor_codigo
      AND m.tipomercadorias_codigo = tm.codigo
	  AND tm.nome = 'Clorados'