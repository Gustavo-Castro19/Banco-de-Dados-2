CREATE DATABASE bankEX;
USE bankEX;

CREATE TABLE usuario(
    Id_usuario INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    CPF VARCHAR(15) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(18),
    tipo_usuario VARCHAR(30)
);

CREATE TABLE funcionario(
    id_funcionario INTEGER PRIMARY KEY AUTO_INCREMENT,
    Id_usuario INTEGER,
    codigo_funcionario INTEGER NOT NULL UNIQUE,
    cargo VARCHAR(50) NOT NULL,
    id_supervisor INTEGER, 
    FOREIGN KEY(Id_usuario) REFERENCES usuario(Id_usuario),
    FOREIGN KEY(id_supervisor) REFERENCES funcionario(id_funcionario)  
);

CREATE TABLE endereco(
    id_endereco INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_usuario INTEGER,
    bairro VARCHAR(50),
    cep VARCHAR(20),
    rua VARCHAR(50), 
    cidade VARCHAR(25),
    estado VARCHAR(30),
    local_t VARCHAR(20), 
    complemento VARCHAR(50), 
    Numero_Casa INTEGER,
    FOREIGN KEY(id_usuario) REFERENCES usuario(Id_usuario)
);

CREATE TABLE agencia(
    id_agencia INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_endereco INTEGER, 
    nome VARCHAR(50),
    codigo_agencia INTEGER NOT NULL UNIQUE,
    FOREIGN KEY(id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE clientes(
    id_cliente INTEGER PRIMARY KEY AUTO_INCREMENT, 
    id_funcionario INTEGER,
    id_usuario INTEGER,
    score_credito INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(Id_usuario),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE auditoria(
    id_auditoria INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_usuario INTEGER,
    acao VARCHAR(50),
    data_hora DATETIME NOT NULL,
    detalhes TEXT, 
    FOREIGN KEY(id_usuario) REFERENCES usuario(Id_usuario)
);

CREATE TABLE relatorios(
    id_relatorios INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_funcionario INTEGER,
    tipo_relatorio VARCHAR(50) NOT NULL,
    data_geracao DATE NOT NULL,
    conteudo TEXT NOT NULL, 
    FOREIGN KEY(id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE conta(
    id_conta INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_usuario INTEGER,
    id_cliente INTEGER,
    id_agencia INTEGER, 
    numero_conta INTEGER NOT NULL UNIQUE,
    saldo DECIMAL(15,2), 
    data_abertura DATETIME NOT NULL,
    status_conta BOOLEAN NOT NULL,
    FOREIGN KEY(id_usuario) REFERENCES usuario(Id_usuario),
    FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente), 
    FOREIGN KEY(id_agencia) REFERENCES agencia(id_agencia) 
);

CREATE TABLE conta_investimento(
    id_conta_investimento INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_conta INTEGER,
    perfil_risco VARCHAR(25),
    valor_minimo DECIMAL(15,2), 
    taxa_rendimento_base DECIMAL(5,4), 
    FOREIGN KEY(id_conta) REFERENCES conta(id_conta)
);

CREATE TABLE conta_poupanca(
    id_conta_poupanca INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_conta INTEGER,
    taxa_rendimento DECIMAL(5,4), 
    ultimo_rendimento DECIMAL(15,2), 
    FOREIGN KEY(id_conta) REFERENCES conta(id_conta)
);

CREATE TABLE conta_corrente(
    id_conta_corrente INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_conta INTEGER,
    limite DECIMAL(15,2), 
    data_de_vencimento DATE, 
    taxa_manutencao DECIMAL(5,4), 
    FOREIGN KEY(id_conta) REFERENCES conta(id_conta)
);

CREATE TABLE transacao(
    id_transacao INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_conta_origem INTEGER,
    id_conta_destino INTEGER,
    tipo_transacao VARCHAR(20),
    valor DECIMAL(15,2), 
    data_hora DATETIME,
    detalhes TEXT, 
    FOREIGN KEY (id_conta_origem) REFERENCES conta(id_conta),
    FOREIGN KEY (id_conta_destino) REFERENCES conta(id_conta)
);
