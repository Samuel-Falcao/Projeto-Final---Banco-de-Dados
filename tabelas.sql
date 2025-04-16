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
