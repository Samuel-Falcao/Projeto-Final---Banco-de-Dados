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

CREATE TABLE funcionarios(
	id_funcionario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    cargo VARCHAR(60) NOT NULL,
    setor VARCHAR(40) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE pacientes(
	id_paciente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    plano_de_saude VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

ALTER TABLE usuarios
ADD COLUMN idade INT NOT NULL;

CREATE TABLE agendamentos(
	id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
	dt_agendada DATETIME NOT NULL,
	sts VARCHAR(20) NOT NULL DEFAULT 'Agendado',
	descricao TEXT,
	id_pacientes INT,
	id_medicos INT,
	FOREIGN KEY (id_pacientes) REFERENCES pacientes (id_pacientes),
	FOREIGN KEY (id_medicos) REFERENCES medicos (id_medicos)	
);

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
