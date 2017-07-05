
CREATE TABLE public.produto (
                cod_produto VARCHAR(15) NOT NULL,
                rastreavel VARCHAR(1),
                patrimonio BOOLEAN,
                descricao VARCHAR(125),
                tipo VARCHAR(2),
                unidade VARCHAR(2),
                devobrig VARCHAR(1),
                CONSTRAINT produto_pk PRIMARY KEY (cod_produto)
);


CREATE TABLE public.funcao (
                cod_funcao VARCHAR(4) NOT NULL,
                descricao VARCHAR(256),
                CONSTRAINT funcao_pk PRIMARY KEY (cod_funcao)
);


CREATE TABLE public.area (
                cod_area BIGINT NOT NULL,
                descricao VARCHAR(50),
                CONSTRAINT area_pk PRIMARY KEY (cod_area)
);


CREATE TABLE public.funcionario (
                matricula BIGINT NOT NULL,
                cod_area BIGINT NOT NULL,
                cod_funcao VARCHAR(4) NOT NULL,
                nome VARCHAR(100),
                situacao VARCHAR(1),
                demissao TIMESTAMP,
                balconista VARCHAR(1),
                supervisor VARCHAR(1),
                CONSTRAINT funcionario_pk PRIMARY KEY (matricula)
);


CREATE TABLE public.almoxarifado (
                id_almox BIGINT NOT NULL,
                cod_filial_erp BIGINT,
                cod_almox BIGINT,
                descricao VARCHAR(30),
                dt_inicio TIMESTAMP,
                dt_fechamento BOOLEAN,
                CONSTRAINT almoxarifado_pk PRIMARY KEY (id_almox)
);


CREATE TABLE public.movimento (
                movid BIGINT NOT NULL,
                id_almox BIGINT NOT NULL,
                cod_produto VARCHAR(15) NOT NULL,
                mat_balconista BIGINT NOT NULL,
                mat_solicitante BIGINT NOT NULL,
                mat_supervisor BIGINT,
                datahora VARCHAR(16),
                qtde BIGINT,
                lote VARCHAR(10),
                dt_vencimento VARCHAR(16),
                es BIGINT,
                CONSTRAINT movimento_pk PRIMARY KEY (movid)
);


CREATE TABLE public.estoqueinicial (
                id_almox BIGINT NOT NULL,
                data_inicial VARCHAR(16) NOT NULL,
                cod_produto VARCHAR(15) NOT NULL,
                saldo BIGINT,
                CONSTRAINT estoqueinicial_pk PRIMARY KEY (id_almox, data_inicial, cod_produto)
);


CREATE TABLE public.estoque (
                id_almox BIGINT NOT NULL,
                cod_produto VARCHAR(15) NOT NULL,
                saldo REAL NOT NULL,
                CONSTRAINT estoque_pk PRIMARY KEY (id_almox, cod_produto)
);


ALTER TABLE public.estoque ADD CONSTRAINT produto_estoque_fk
FOREIGN KEY (cod_produto)
REFERENCES public.produto (cod_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoqueinicial ADD CONSTRAINT produto_estoqueinicial_fk
FOREIGN KEY (cod_produto)
REFERENCES public.produto (cod_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT produto_movimento_fk
FOREIGN KEY (cod_produto)
REFERENCES public.produto (cod_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.funcionario ADD CONSTRAINT funcao_funcionario_fk
FOREIGN KEY (cod_funcao)
REFERENCES public.funcao (cod_funcao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.funcionario ADD CONSTRAINT area_funcionario_fk
FOREIGN KEY (cod_area)
REFERENCES public.area (cod_area)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT funcionario_movimento_fk
FOREIGN KEY (mat_balconista)
REFERENCES public.funcionario (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT funcionario_movimento_fk1
FOREIGN KEY (mat_solicitante)
REFERENCES public.funcionario (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoque ADD CONSTRAINT almoxarifado_estoque_fk
FOREIGN KEY (id_almox)
REFERENCES public.almoxarifado (id_almox)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoqueinicial ADD CONSTRAINT almoxarifado_estoqueinicial_fk
FOREIGN KEY (id_almox)
REFERENCES public.almoxarifado (id_almox)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT almoxarifado_movimento_fk
FOREIGN KEY (id_almox)
REFERENCES public.almoxarifado (id_almox)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
