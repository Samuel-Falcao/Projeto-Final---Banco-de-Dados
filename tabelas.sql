CREATE DATABASE clinica_medica;
USE clinica_medica;

CREATE TABLE usuarios (
	id_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome_completo VARCHAR(50) NOT NULL,
   	data_nascimento DATE NOT NULL,
    cpf CHAR(14) NOT NULL UNIQUE KEY,
    email VARCHAR(45) NOT NULL, 
    senha VARCHAR(45) NOT NULL,
    tipo_usuario ENUM('Médico', 'Paciente', 'Funcionário') NOT NULL,
    sts_usuario ENUM('Ativo','Inativo') DEFAULT 'Ativo'
);

CREATE TABLE medicos (
	id_medico INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    crm VARCHAR(15) NOT NULL UNIQUE KEY,
    especialidade VARCHAR(60) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    cargo VARCHAR(60) NOT NULL,
    setor VARCHAR(40) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE pacientes(
	id_paciente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    plano_de_saude VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE enderecos (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,  -- A coluna 'id_usuario' será a chave estrangeira
    tipo_endereco ENUM('Residencial', 'Comercial', 'Correspondência') NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(10) NOT NULL,  
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE agendamentos(
	id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
	dt_agendada DATETIME NOT NULL,
	sts VARCHAR(20) NOT NULL DEFAULT 'Agendado',
	descricao TEXT,
	id_paciente INT,
	id_medico INT,
<<<<<<< HEAD
    id_pagamento INT,
    id_convenio INT,
    id_exames INT,
	FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
	FOREIGN KEY (id_medico) REFERENCES medicos (id_medico),
    FOREIGN KEY (id_pagamento) REFERENCES formas_de_pagamento (id_pagamento),
	FOREIGN KEY (id_convenio) REFERENCES convenios (id_convenio),
    FOREIGN KEY (id_exame) REFERENCES exame (id_exame)
);
=======
    id_exames INT,
    id_formas_de_pagamento INT,
    id_convenios INT,
	FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
	FOREIGN KEY (id_medico) REFERENCES medicos (id_medico),
    FOREIGN KEY (id_exames) REFERENCES exames (exames),
    FOREIGN KEY (id_formas_de_pagamento) REFERENCES formas_de_pagamento (id_formas_de_pagamento),
    FOREIGN KEY (id_convenios) REFERENCES convenios (id_convenios)
    );
>>>>>>> 1e30a1b32b4f5e6b12087c8cb99e771dbbcdf0fd

CREATE TABLE prontuarios (
	id_prontuario INT PRIMARY KEY AUTO_INCREMENT,
	id_paciente INT NOT NULL,
	id_medico INT NOT NULL,
	id_agendamento INT,
	dt_atendimento DATETIME NOT NULL,
	queixa_principal TEXT,
	historico_clinico TEXT,
	exame_fisico TEXT,
	diagnostico TEXT,
	conduta TEXT,
	observacoes TEXT,
	
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
	FOREIGN KEY (id_medico) REFERENCES medicos(id_medico),
	FOREIGN KEY (id_agendamento) REFERENCES agendamentos(id_agendamento)
);

CREATE TABLE receitas_medicas (
	id_receita INT PRIMARY KEY AUTO_INCREMENT,
	id_prontuario INT NOT NULL,
	dt_receita DATETIME NOT NULL,
	medicamentos TEXT NOT NULL,
	bula TEXT,
	
	FOREIGN KEY (id_prontuario) REFERENCES prontuarios(id_prontuario)
);

CREATE TABLE exames (
	id_exame INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR (50) NOT NULL, 
	tp_exame ENUM('laboratorial', 'imagem', 'clínico') NOT NULL,
	valor DECIMAL (10,2) NOT NULL,
	instrucoes VARCHAR (100), #preparo para fazr o exame (ex:jejum medicação)
	descricao VARCHAR (100),
	sts ENUM('ativo', 'inativo') DEFAULT 'ativo'
);

CREATE TABLE formas_de_pagamento(
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR (30) NOT NULL,
	sts ENUM('ativo', 'inativo') DEFAULT 'ativo'
);

CREATE TABLE convenios (
	id_convenio INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR (50) NOT NULL,
	cod_ANS INT NOT NULL,
	tipo VARCHAR (100),
	telefone CHAR (14),
   	email VARCHAR (50),
	site VARCHAR (50),
	dt_inicio DATE NOT NULL,
	dt_fim DATE NOT NULL,
	cobertura TEXT,
	sts ENUM('ativo', 'inativo') DEFAULT 'ativo'
);

