CREATE DATABASE oficina;
USE oficina;

-- Tabelas base
CREATE TABLE Veiculo (
    idVeiculo INT PRIMARY KEY,
    marca_carro VARCHAR(45),
    servico_id INT
);

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    veiculo_id INT,
    nome VARCHAR(100),
    contato VARCHAR(45),
    FOREIGN KEY (veiculo_id) REFERENCES Veiculo(idVeiculo)
);

CREATE TABLE Tabela_cada_servico (
    idTabela INT PRIMARY KEY,
    tipo ENUM('conserto', 'revisao'),
    nome VARCHAR(45),
    valor DECIMAL(10,2)
);

CREATE TABLE Avaliacao_servico (
    idAvaliacao INT PRIMARY KEY
);

CREATE TABLE Equipe_especifica (
    idEquipe INT PRIMARY KEY,
    avaliacao_id INT,
    FOREIGN KEY (avaliacao_id) REFERENCES Avaliacao_servico(idAvaliacao)
);

CREATE TABLE Mecanico (
    idMecanico INT PRIMARY KEY,
    nome VARCHAR(100),
    especialidade VARCHAR(100),
    codigo VARCHAR(45),
    endereco VARCHAR(100)
);

CREATE TABLE Mecanico_em_Equipe (
    equipe_id INT,
    mecanico_id INT,
    PRIMARY KEY (equipe_id, mecanico_id),
    FOREIGN KEY (equipe_id) REFERENCES Equipe_especifica(idEquipe),
    FOREIGN KEY (mecanico_id) REFERENCES Mecanico(idMecanico)
);

CREATE TABLE Ordem_servico (
    idOrdem INT PRIMARY KEY,
    data_emissao DATE,
    status_valor DECIMAL(10,2),
    data_conclusao DATE,
    tabela_servico_id INT,
    equipe_id INT,
    autorizacao_entrega ENUM('sim', 'nao'),
    FOREIGN KEY (tabela_servico_id) REFERENCES Tabela_cada_servico(idTabela),
    FOREIGN KEY (equipe_id) REFERENCES Equipe_especifica(idEquipe)
);

CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(idCliente)
);

CREATE TABLE Execucao_servico (
    idExecucao INT PRIMARY KEY,
    entrega_id INT,
    equipe_id INT,
    ordem_id INT,
    FOREIGN KEY (entrega_id) REFERENCES Entrega(idEntrega),
    FOREIGN KEY (equipe_id) REFERENCES Equipe_especifica(idEquipe),
    FOREIGN KEY (ordem_id) REFERENCES Ordem_servico(idOrdem)
);

CREATE TABLE Servico (
    idServico INT PRIMARY KEY,
    tipo ENUM('conserto', 'revisao'),
    parte_carro VARCHAR(200),
    equipe_id INT,
    FOREIGN KEY (equipe_id) REFERENCES Equipe_especifica(idEquipe)
);

CREATE TABLE Estoque_pecas (
    idEstoque INT PRIMARY KEY,
    ordem_id INT,
    nome VARCHAR(45),
    valor DECIMAL(10,2),
    codigo_peca VARCHAR(45),
    data_movimentacao DATE,
    quantidade INT,
    tipo_movimentacao ENUM('entrada', 'saida'),
    FOREIGN KEY (ordem_id) REFERENCES Ordem_servico(idOrdem)
);



-- ------------------------------------
-- INSERÇÕES
-- ------------------------------------

-- Clientes e Veículos
INSERT INTO Veiculo VALUES (1, 'Ford Ka', 1);
INSERT INTO Cliente VALUES (1, 1, 'Carlos Souza', '83-99999-0000');

-- Tabela de Serviços
INSERT INTO Tabela_cada_servico VALUES (1, 'conserto', 'Freio', 300.00);

-- Avaliação e Equipe
INSERT INTO Avaliacao_servico VALUES (1);
INSERT INTO Equipe_especifica VALUES (1, 1);

-- Mecânicos
INSERT INTO Mecanico VALUES (1, 'João Lima', 'Elétrica', 'M001', 'Rua A');
INSERT INTO Mecanico VALUES (2, 'Ana Clara', 'Suspensão', 'M002', 'Rua B');

-- Associação Mecânico - Equipe
INSERT INTO Mecanico_em_Equipe VALUES (1, 1);
INSERT INTO Mecanico_em_Equipe VALUES (1, 2);

-- Ordem de Serviço
INSERT INTO Ordem_servico VALUES (1, '2025-04-01', 500.00, '2025-04-03', 1, 1, 'sim');

-- Entrega
INSERT INTO Entrega VALUES (1, 1);

-- Execução do serviço
INSERT INTO Execucao_servico VALUES (1, 1, 1, 1);

-- Serviço
INSERT INTO Servico VALUES (1, 'conserto', 'freio traseiro', 1);

-- Estoque
INSERT INTO Estoque_pecas VALUES (1, 1, 'Pastilha de freio', 200.00, 'P1234', '2025-04-01', 1, 'saida');