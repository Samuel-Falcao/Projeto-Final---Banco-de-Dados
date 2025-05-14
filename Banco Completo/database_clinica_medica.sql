CREATE DATABASE clinica_medica;
USE clinica_medica;

CREATE TABLE usuarios (
	id_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome_completo VARCHAR(50) NOT NULL,
   	data_nascimento DATE NOT NULL,
    cpf CHAR(14) NOT NULL UNIQUE KEY,
    email VARCHAR(45) NOT NULL, 
    senha VARCHAR(45) NOT NULL,
    telefone CHAR(15),
    tipo_usuario ENUM('Médico', 'Paciente', 'Funcionário') NOT NULL,
    sts_usuario ENUM('Ativo','Inativo') DEFAULT 'Ativo'
);

CREATE TABLE medicos (
	id_medico INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    crm VARCHAR(30) NOT NULL UNIQUE KEY,
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
    id_usuario INT NOT NULL, 
    tipo_endereco ENUM('Residencial', 'Comercial') NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(10) NOT NULL,  
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE formas_de_pagamento(
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR (30) NOT NULL,
	sts ENUM('ativo', 'inativo') DEFAULT 'ativo'
);

CREATE TABLE exames (
	id_exame INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR (50) NOT NULL, 
	tp_exame ENUM('laboratorial', 'imagem', 'clínico') NOT NULL,
	valor DECIMAL (10,2) NOT NULL,
	instrucoes VARCHAR (100), 
	descricao VARCHAR (500),
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

CREATE TABLE agendamentos(
	id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
	dt_agendada DATETIME NOT NULL,
	sts VARCHAR(20) NOT NULL DEFAULT 'Agendado',
	descricao TEXT,
	id_paciente INT,
	id_medico INT,
    id_pagamento INT,
    id_convenio INT,
    id_exames INT,
	FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
	FOREIGN KEY (id_medico) REFERENCES medicos (id_medico),
    FOREIGN KEY (id_pagamento) REFERENCES formas_de_pagamento (id_pagamento),
	FOREIGN KEY (id_convenio) REFERENCES convenios (id_convenio),
    FOREIGN KEY (id_exames) REFERENCES exames (id_exame)
);

CREATE TABLE prontuarios (
	id_prontuario INT PRIMARY KEY AUTO_INCREMENT,
	id_paciente INT NOT NULL,
	id_medico INT NOT NULL,
	id_agendamento INT,
	dt_atendimento DATETIME NOT NULL,
	queixa_principal TEXT,
	historico_clinico TEXT,
	diagnostico TEXT,
	conduta TEXT,
	observacoes TEXT,
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
	FOREIGN KEY (id_medico) REFERENCES medicos(id_medico),
	FOREIGN KEY (id_agendamento) REFERENCES agendamentos(id_agendamento)
);

CREATE TABLE exames_prontuarios (
	id_exame_prontuario INT PRIMARY KEY AUTO_INCREMENT,
	id_prontuario INT NOT NULL,
	id_exame INT NOT NULL,
	resultado TEXT,
	data_resultado DATETIME,
	
	FOREIGN KEY (id_prontuario) REFERENCES prontuarios(id_prontuario),
	FOREIGN KEY (id_exame) REFERENCES exames(id_exame)
);

CREATE TABLE receitas_medicas (
	id_receita INT PRIMARY KEY AUTO_INCREMENT,
	id_prontuario INT NOT NULL,
	dt_receita DATETIME NOT NULL,
	medicamentos TEXT NOT NULL,
	bula TEXT,
	FOREIGN KEY (id_prontuario) REFERENCES prontuarios(id_prontuario)
);

INSERT INTO usuarios (id_usuario, nome_completo, data_nascimento, cpf, email, senha, telefone, tipo_usuario, sts_usuario)
VALUES
(1, 'Luis Alves Araújo', '2008-07-13', '80827000090', 'luis.arajo@example.com', 'M&di123', '11998765432', 'Médico', 'Ativo'),
(2, 'Vitor Cunha Martins', '1994-01-16', '85832525051', 'vitor.martins@example.com', 'M&di123', '21987654321', 'Médico', 'Ativo'),
(3, 'José Almeida Fernandes', '1975-10-21', '47891096074', 'jos.fernandes@example.com', 'M&di123', '31991234567', 'Médico', 'Ativo'),
(4, 'Carlos Araújo Martins', '1973-05-28', '53508580091', 'carlos.martins48@example.com', 'M&di123', '71992345678', 'Médico', 'Ativo'),
(5, 'André Santos Almeida', '2001-12-17', '58118858065', 'andr.almeida@example.com', 'M&di123', '41993456789', 'Médico', 'Ativo'),
(6, 'Leonardo Castro Souza', '2002-04-28', '04448544010', 'leonardo.souza_c@example.com', 'M&di123', '51994567890', 'Médico', 'Ativo'),
(7, 'Leonor Cavalcanti Silva', '1982-07-17', '99828256070', 'leonor.silva_c@example.com', 'M&di123', '85995678901', 'Médico', 'Ativo'),
(8, 'Cauã Martins Rodrigues', '2005-04-28', '88805485063', 'cau.rodrigues_m@example.com', 'M&di123', '81996789012', 'Médico', 'Ativo'),
(9, 'Nicole Araújo Carvalho', '2006-10-30', '50663704049', 'nicole.carvalho@example.com', 'M&di123', '67997890123', 'Médico', 'Ativo'),
(10, 'Julieta Correia Almeida', '1990-12-12', '24210161004', 'julieta.almeida@example.com', 'M&di123', '11998901234', 'Médico', 'Ativo'),
(11, 'Gabrielly Almeida Lima', '1983-06-23', '77243689027', 'gabrielly.lima@example.com', 'M&di123', '21991239876', 'Médico', 'Ativo'),
(12, 'Raissa Cardoso Rodrigues', '1983-12-06', '91347348050', 'raissa.rodrigues_c@example.com', 'M&di123', '31992345671', 'Médico', 'Ativo'),
(13, 'Fábio Pinto Gomes', '1992-04-25', '61905166028', 'fbio.gomes_p@example.com', 'M&di123', '71993459876', 'Médico', 'Ativo'),
(14, 'Fernanda Pereira Barros', '2000-11-04', '32209672058', 'fernanda.barros22@example.com', 'M&di123', '41994561234', 'Médico', 'Ativo'),
(15, 'Matilde Fernandes Silva', '1974-07-28', '73965038095', 'matilde.silva13@example.com', 'M&di123', '51995674567', 'Médico', 'Ativo'),
(16, 'Sofia Melo Araújo', '1979-05-31', '32527890008', 'sofia.arajo@example.com', 'M&di123', '85996782345', 'Médico', 'Ativo'),
(17, 'Sarah Azevedo Barros', '1971-08-17', '19363288013', 'sarah.barros@example.com', 'M&di123', '81997893456', 'Médico', 'Ativo'),
(18, 'Vitor Melo Barbosa', '2005-12-21', '13850657027', 'vitor.barbosa@example.com', 'M&di123', '67998904567', 'Médico', 'Ativo'),
(19, 'Bruna Costa Barbosa', '2009-05-18', '68871734092', 'bruna.barbosa_c@example.com', 'M&di123', '11999815678', 'Médico', 'Ativo'),
(20, 'Laura Fernandes Castro', '1970-12-01', '96247157002', 'laura.castro@example.com', 'M&di123', '21991234567', 'Médico', 'Ativo'),
(21, 'Thiago Costa Rocha', '1993-08-11', '50132752026', 'thiago.rocha@example.com', 'M&di123', '31992345678', 'Médico', 'Ativo'),
(22, 'Alice Ferreira Gomes', '1978-07-24', '09130172055', 'alice.gomes@example.com', 'M&di123', '71993456789', 'Médico', 'Ativo'),
(23, 'Eduarda Oliveira Souza', '2002-05-03', '88586157007', 'eduarda.souza22@example.com', 'M&di123', '41994567890', 'Médico', 'Ativo'),
(24, 'Gabrielly Carvalho Goncalves', '1999-03-23', '71680607081', 'gabrielly.goncalves@example.com', 'M&di123', '51995678901', 'Médico', 'Ativo'),
(25, 'Enzo Barros Ferreira', '1997-05-20', '96877347013', 'enzo.ferreira@example.com', 'M&di123', '85996789012', 'Médico', 'Ativo'),
(26, 'Gabrielle Oliveira Rodrigues', '1999-10-13', '89389102022', 'gabrielle.rodrigues_o@example.com', 'M&di123', '81997890123', 'Médico', 'Ativo'),
(27, 'Douglas Sousa Cavalcanti', '1982-11-01', '06219705068', 'douglas.cavalcanti60@example.com', 'M&di123', '67998901234', 'Médico', 'Ativo'),
(28, 'Anna Carvalho Castro', '1980-12-30', '07227631079', 'anna.castro@example.com', 'M&di123', '11999812345', 'Médico', 'Ativo'),
(29, 'Alex Rocha Goncalves', '1976-06-30', '76904249021', 'alex.goncalves44@example.com', 'M&di123', '21991233456', 'Médico', 'Ativo'),
(30, 'Eduardo Silva Costa', '1992-01-01', '41013411099', 'eduardo.costa_s@example.com', 'M&di123', '31992349876', 'Médico', 'Ativo'),
(31, 'Nicolas Cunha Ferreira', '1973-10-05', '38416002045', 'nicolas.ferreira@example.com', 'M&di123', '71993454321', 'Médico', 'Ativo'),
(32, 'Eduarda Barros Barbosa', '1995-04-29', '86305917060', 'eduarda.barbosa@example.com', 'M&di123', '41994561236', 'Médico', 'Ativo'),
(33, 'Kauã Pinto Gomes', '1993-11-17', '67925535067', 'kau.gomes@example.com', 'M&di123', '51995678903', 'Médico', 'Ativo'),
(34, 'Vinicius Araujo Souza', '1975-08-30', '71259392015', 'vinicius.souza_a@example.com', 'M&di123', '85996784567', 'Médico', 'Ativo'),
(35, 'Kauã Correia Goncalves', '1976-08-07', '50125342047', 'kau.goncalves_c@example.com', 'M&di123', '81997893478', 'Médico', 'Ativo'),
(36, 'Nicolas Cardoso Barbosa', '1984-11-08', '11363555022', 'nicolas.barbosa@example.com', 'M&di123', '67998901235', 'Médico', 'Ativo'),
(37, 'Emily Silva Costa', '1971-09-03', '32788602090', 'emily.costa_s@example.com', 'M&di123', '11999812346', 'Médico', 'Ativo'),
(38, 'Beatriz Pereira Ferreira', '1981-08-08', '05392230008', 'beatriz.ferreira@example.com', 'M&di123', '21991233457', 'Médico', 'Ativo'),
(39, 'Júlia Azevedo Ferreira', '1999-05-13', '28223496062', 'jlia.ferreira90@example.com', 'M&di123', '31992349877', 'Médico', 'Ativo'),
(40, 'Laura Martins Carvalho', '1994-01-11', '87611458078', 'laura.carvalho_m@example.com', 'M&di123', '71993454322', 'Médico', 'Ativo');

INSERT INTO usuarios (id_usuario, nome_completo, data_nascimento, cpf, email, senha, telefone, tipo_usuario, sts_usuario)
VALUES
(41, 'Martim Souza Rocha', '1978-03-20', '23839440335', 'MartimSouzaRocha@rhyta.com', 'P@c123', '63944457972', 'Paciente', 'Ativo'),
(42, 'Daniel Santos Cavalcanti', '2011-02-18', '12345678900', 'DanielSantosCavalcanti@armyspy.com', 'P@c123', '11972004699', 'Paciente', 'Ativo'),
(43, 'Breno Alves Melo', '1980-05-04', '42058643615', 'BrenoAlvesMelo@armyspy.com', 'P@c123', '6171333503', 'Paciente', 'Ativo'),
(44, 'Laura Costa Cavalcanti', '2013-08-22', '12736002407', 'LauraCostaCavalcanti@dayrep.com', 'P@c123', '8477258337', 'Paciente', 'Ativo'),
(45, 'Evelyn Dias Araujo', '2000-07-11', '59196143827', 'EvelynDiasAraujo@armyspy.com', 'P@c123', '4233117528', 'Paciente', 'Ativo'),
(46, 'Sofia Sousa Cunha', '1989-02-20', '82196176249', 'SofiaSousaCunha@teleworm.us', 'P@c123', '8576106569', 'Paciente', 'Ativo'),
(47, 'Estevan Lima Almeida', '1976-09-07', '55941235631', 'EstevanLimaAlmeida@armyspy.com', 'P@c123', '11991046788', 'Paciente', 'Ativo'),
(48, 'Leonor Lima Almeida', '1985-02-26', '51107950708', 'LeonorLimaAlmeida@dayrep.com', 'P@c123', '6829635098', 'Paciente', 'Ativo'),
(49, 'Giovanna Rodrigues Dias', '1974-01-17', '51452358010', 'GiovannaRodriguesDias@armyspy.com', 'P@c123', '2867319973', 'Paciente', 'Ativo'),
(50, 'Larissa Dias Fernandes', '1985-11-12', '61409954340', 'LarissaDiasFernandes@rhyta.com', 'P@c123', '8679634770', 'Paciente', 'Ativo'),
(51, 'Beatriz Rodrigues Barros', '1978-10-31', '67642945850', 'BeatrizRodriguesBarros@rhyta.com', 'P@c123', '2168553517', 'Paciente', 'Ativo'),
(52, 'Lavinia Carvalho Oliveira', '2009-09-10', '84323650680', 'LaviniaCarvalhoOliveira@teleworm.us', 'P@c123', '4884487923', 'Paciente', 'Ativo'),
(53, 'Fábio Correia Carvalho', '2006-06-21', '70075533383', 'FabioCorreiaCarvalho@armyspy.com', 'P@c123', '51996727430', 'Paciente', 'Ativo'),
(54, 'Camila Azevedo Gomes', '1970-07-09', '83056622921', 'CamilaAzevedoGomes@rhyta.com', 'P@c123', '2730917760', 'Paciente', 'Ativo'),
(55, 'Anna Araujo Sousa', '1971-12-07', '48109498930', 'AnnaAraujoSousa@rhyta.com', 'P@c123', '6175157016', 'Paciente', 'Ativo'),
(56, 'Lucas Ferreira Souza', '1989-01-03', '99498317097', 'LucasFerreiraSouza@armyspy.com', 'P@c123', '2194659171', 'Paciente', 'Ativo'),
(57, 'Breno Fernandes Lima', '2003-08-14', '38246986848', 'LFerreira@dayrep.com', 'P@c123', '3130102883', 'Paciente', 'Ativo'),
(58, 'Otávio Castro Azevedo', '1993-03-01', '15113226084', 'OtavioCastroAzevedo@dayrep.com', 'P@c123', '3468966720', 'Paciente', 'Ativo'),
(59, 'Thiago Ribeiro Cavalcanti', '1973-06-16', '94399447494', 'paciente19@example.com', 'P@c123', '1167514115', 'Paciente', 'Ativo'),
(60, 'Lucas Santos Cardoso', '1992-03-10', '15115458608', 'LucasSantosCardoso@dayrep.com', 'P@c123', '1245677339', 'Paciente', 'Ativo'),
(61, 'Fábio Cardoso Barbosa', '1990-10-10', '11828323349', 'FabioCardosoBarbosa@armyspy.com', 'P@c123', '1179014716', 'Paciente', 'Ativo'),
(62, 'Victor Goncalves Silva', '1984-06-09', '62892167590', 'VictorGoncalvesSilva@teleworm.us', 'P@c123', '1979978192', 'Paciente', 'Ativo'),
(63, 'Ryan Azevedo Cavalcanti', '1983-11-10', '38671889807', 'RyanAzevedoCavalcanti@dayrep.com', 'P@c123', '1491083143', 'Paciente', 'Ativo'),
(64, 'Isabela Almeida Gomes', '1986-02-13', '22740060327', 'IsabelaAlmeidaGomes@jourrapide.com', 'P@c123', '7173335940', 'Paciente', 'Ativo'),
(65, 'Estevan Fernandes Barbosa', '1989-09-11', '88751407400', 'EstevanFernandesBarbosa@armyspy.com', 'P@c123', '2774506241', 'Paciente', 'Ativo'),
(66, 'Clara Barros Costa', '1974-08-26', '34551752525', 'ClaraBarrosCosta@teleworm.us', 'P@c123', '7162537510', 'Paciente', 'Ativo'),
(67, 'Larissa Rodrigues Souza', '1970-02-10', '87856907835', 'LarissaRodriguesSouza@rhyta.com', 'P@c123', '1185222042', 'Paciente', 'Ativo'),
(68, 'Vitória Dias Santos', '2009-01-11', '83743651106', 'VitoriaDiasSantos@jourrapide.com', 'P@c123', '1125993295', 'Paciente', 'Ativo'),
(69, 'Julian Barbosa Silva', '1996-12-29', '13690608317', 'JulianBarbosaSilva@jourrapide.com', 'P@c123', '1291296431', 'Paciente', 'Ativo'),
(70, 'Gabrielle Martins Sousa', '1972-07-03', '21371602263', 'GabrielleMartinsSousa@jourrapide.com', 'P@c123', '8476595621', 'Paciente', 'Ativo'),
(71, 'Vitoria Gomes Cunha', '1991-04-25', '32931608599', 'VitoriaGomesCunha@rhyta.com', 'P@c123', '3248988457', 'Paciente', 'Ativo'),
(72, 'Arthur Correia Cunha', '1994-02-18', '68091797559', 'ArthurCorreiaCunha@teleworm.us', 'P@c123', '3845463132', 'Paciente', 'Ativo'),
(73, 'Tomás Silva Rodrigues', '1992-07-10', '67263853159', 'TomasSilvaRodrigues@jourrapide.com', 'P@c123', '9134826051', 'Paciente', 'Ativo'),
(74, 'Caio Martins Barros', '1976-05-17', '57458419318', 'CaioMartinsBarros@armyspy.com', 'P@c123', '6287016847', 'Paciente', 'Ativo'),
(75, 'Emilly Martins Barbosa', '2005-02-21', '68310652798', 'EmillyMartinsBarbosa@jourrapide.com', 'P@c123', '2170713993', 'Paciente', 'Ativo'),
(76, 'Anna Almeida Cunha', '1986-11-01', '16123498622', 'AnnaAlmeidaCunha@rhyta.com', 'P@c123', '8138183766', 'Paciente', 'Ativo'),
(77, 'Danilo Barbosa Costa', '2012-02-24', '13688450701', 'DaniloBarbosaCosta@teleworm.us', 'P@c123', '6225749344', 'Paciente', 'Ativo'),
(78, 'Enzo Ribeiro Cardoso', '1986-11-01', '94892064661', 'EnzoRibeiroCardoso@dayrep.com', 'P@c123', '7570564378', 'Paciente', 'Ativo'),
(79, 'Miguel Carvalho Alves', '2007-03-20', '58035951602', 'MiguelCarvalhoAlves@jourrapide.com', 'P@c123', '3146338494', 'Paciente', 'Ativo'),
(80, 'Livia Pinto Rodrigues', '1978-12-03', '57732304292', 'LiviaPintoRodrigues@teleworm.us', 'P@c123', '5578227515', 'Paciente', 'Ativo');

INSERT INTO usuarios (id_usuario, nome_completo, data_nascimento, cpf, email, senha, telefone, tipo_usuario, sts_usuario)
VALUES 
(81, 'Carlos Eduardo Ribeiro', '1985-06-11', '57389456123', 'CarlosEduardoRibeiro@teleworm.us', 'Fc#123', '1122334455', 'Funcionário', 'Ativo'),
(82, 'Amanda Souza Pereira', '1990-02-22', '31456789012', 'AmandaSouzaPereira@jourrapide.com', 'Fc#123', '11987654321', 'Funcionário', 'Ativo'),
(83, 'José Henrique Oliveira', '1982-11-15', '87654321098', 'JoseHenriqueOliveira@dayrep.com', 'Fc#123', '34987654321', 'Funcionário', 'Ativo'),
(84, 'Renata Costa Souza', '1993-09-10', '23456789021', 'RenataCostaSouza@rhyta.com', 'Fc#123', '21987654321', 'Funcionário', 'Ativo'),
(85, 'Lucas Felipe Martins', '1991-04-17', '94736214856', 'LucasFelipeMartins@teleworm.us', 'Fc#123', '1134567890', 'Funcionário', 'Ativo'),
(86, 'Fernanda Alves Rocha', '1987-03-23', '65847382654', 'FernandaAlvesRocha@jourrapide.com', 'Fc#123', '61987654321', 'Funcionário', 'Ativo'),
(87, 'Márcio José Lima', '1980-07-08', '34657657890', 'MarcioJoseLima@dayrep.com', 'Fc#123', '1132112233', 'Funcionário', 'Inativo'),
(88, 'Juliana Martins Ferreira', '1995-01-13', '43728564327', 'JulianaMartinsFerreira@rhyta.com', 'Fc#123', '1182334455', 'Funcionário', 'Ativo'),
(89, 'Eduardo Ribeiro Souza', '1983-12-03', '74639213458', 'EduardoRibeiroSouza@teleworm.us', 'Fc#123', '1179988776', 'Funcionário', 'Ativo'),
(90, 'Vanessa Costa Lima', '1992-05-30', '59843126789', 'VanessaCostaLima@jourrapide.com', 'Fc#123', '1145657889', 'Funcionário', 'Inativo'),
(91, 'Ricardo Souza Almeida', '1989-06-22', '47853926147', 'RicardoSouzaAlmeida@dayrep.com', 'Fc#123', '1152398745', 'Funcionário', 'Ativo'),
(92, 'Patrícia Silva Lima', '1994-10-10', '31928374659', 'PatriciaSilvaLima@rhyta.com', 'Fc#123', '1136789532', 'Funcionário', 'Ativo'),
(93, 'Thiago Costa Pereira', '1986-03-25', '72465185902', 'ThiagoCostaPereira@teleworm.us', 'Fc#123', '1169876543', 'Funcionário', 'Inativo'),
(94, 'Simone Souza Ribeiro', '1991-08-17', '31827364581', 'SimoneSouzaRibeiro@jourrapide.com', 'Fc#123', '1198754321', 'Funcionário', 'Ativo'),
(95, 'Ricardo Martins Alves', '1984-12-01', '49287410539', 'RicardoMartinsAlves@dayrep.com', 'Fc#123', '1276543872', 'Funcionário', 'Ativo'),
(96, 'Luana Costa Pereira', '1990-09-15', '48297457368', 'LuanaCostaPereira@rhyta.com', 'Fc#123', '6192335489', 'Funcionário', 'Ativo'),
(97, 'Daniela Ribeiro Costa', '1988-11-22', '75623459874', 'DanielaRibeiroCosta@teleworm.us', 'Fc#123', '1184327654', 'Funcionário', 'Ativo'),
(98, 'Rafael Lima Silva', '1985-05-19', '90783214651', 'RafaelLimaSilva@jourrapide.com', 'Fc#123', '1167423589', 'Funcionário', 'Inativo'),
(99, 'Andréia Silva Souza', '1993-01-07', '65728153090', 'AndreiaSilvaSouza@dayrep.com', 'Fc#123', '1187654321', 'Funcionário', 'Ativo'),
(100, 'Jéssica Oliveira Costa', '1990-10-13', '23847261939', 'JessicaOliveiraCosta@rhyta.com', 'Fc#123', '61987654321', 'Funcionário', 'Ativo'),
(101, 'Fernando Ribeiro Lima', '1992-02-03', '58263971029', 'FernandoRibeiroLima@teleworm.us', 'Fc#123', '1169786432', 'Funcionário', 'Ativo'),
(102, 'Luiz Felipe Costa', '1981-04-17', '39482750172', 'LuizFelipeCosta@jourrapide.com', 'Fc#123', '1134876543', 'Funcionário', 'Ativo'),
(103, 'Mariana Pereira Gomes', '1988-07-30', '86527310986', 'MarianaPereiraGomes@dayrep.com', 'Fc#123', '1178945261', 'Funcionário', 'Inativo'),
(104, 'Gustavo Silva Alves', '1995-06-10', '56473891028', 'GustavoSilvaAlves@rhyta.com', 'Fc#123', '1165221937', 'Funcionário', 'Ativo'),
(105, 'Patrícia Costa Martins', '1982-09-08', '51847263941', 'PatriciaCostaMartins@teleworm.us', 'Fc#123', '1134876321', 'Funcionário', 'Ativo'),
(106, 'Vinícius Souza Almeida', '1986-02-14', '49372856122', 'ViniciusSouzaAlmeida@jourrapide.com', 'Fc#123', '1195632147', 'Funcionário', 'Ativo'),
(107, 'Carla Costa Oliveira', '1987-12-29', '28647318291', 'CarlaCostaOliveira@dayrep.com', 'Fc#123', '1187538294', 'Funcionário', 'Ativo'),
(108, 'Felipe Martins Ribeiro', '1994-04-21', '60394785369', 'FelipeMartinsRibeiro@rhyta.com', 'Fc#123', '1165748390', 'Funcionário', 'Inativo'),
(109, 'Cláudia Souza Costa', '1982-11-12', '59384725058', 'ClaudiaSouzaCosta@teleworm.us', 'Fc#123', '1156543287', 'Funcionário', 'Ativo'),
(110, 'Roberta Silva Lima', '1983-03-08', '46532879104', 'RobertaSilvaLima@jourrapide.com', 'Fc#123', '1132145789', 'Funcionário', 'Ativo'),
(111, 'José Ricardo Ferreira', '1992-08-19', '54219875601', 'JoseRicardoFerreira@teleworm.us', 'Fc#123', '11982345678', 'Funcionário', 'Inativo'),
(112, 'Sandra Costa Lima', '1989-03-30', '46983217894', 'SandraCostaLima@jourrapide.com', 'Fc#123', '11896723548', 'Funcionário', 'Inativo'),
(113, 'Fábio Henrique Almeida', '1991-12-12', '36482951203', 'FabioHenriqueAlmeida@dayrep.com', 'Fc#123', '11323674852', 'Funcionário', 'Ativo'),
(114, 'Tânia Sousa Martins', '1988-11-22', '74829285747', 'TaniaSousaMartins@rhyta.com', 'Fc#123', '11956234854', 'Funcionário', 'Inativo'),
(115, 'Vítor Hugo Costa', '1985-09-11', '49283614856', 'VitorHugoCosta@teleworm.us', 'Fc#123', '11485297453', 'Funcionário', 'Inativo'),
(116, 'Júlia Ribeiro Oliveira', '1993-02-14', '34819264758', 'JuliaRibeiroOliveira@jourrapide.com', 'Fc#123', '11836458792', 'Funcionário', 'Inativo'),
(117, 'Gustavo Fernandes Rocha', '1987-07-29', '23746829812', 'GustavoFernandesRocha@dayrep.com', 'Fc#123', '11965823901', 'Funcionário', 'Inativo'),
(118, 'Paula Santos Lima', '1989-05-21', '65231876203', 'PaulaSantosLima@rhyta.com', 'Fc#123', '11743921503', 'Funcionário', 'Inativo'),
(119, 'Fernando Costa Almeida', '1990-04-01', '73682714934', 'FernandoCostaAlmeida@teleworm.us', 'Fc#123', '11897352468', 'Funcionário', 'Inativo'),
(120, 'Ana Cláudia Ribeiro', '1984-08-19', '49283756103', 'AnaClaudiaRibeiro@jourrapide.com', 'Fc#123', '11678423945', 'Funcionário', 'Ativo');

INSERT INTO medicos (id_usuario, crm, especialidade) 
VALUES 
(1, 'CRM|BA362520', 'Urologia'),
(2, 'CRM|BA600402', 'Psiquiatria'),
(3, 'CRM|BA178869', 'Oncologia'),
(4, 'CRM|BA698969', 'Ortopedia'),
(5, 'CRM|BA162568', 'Oftalmologia'),
(6, 'CRM|BA143725', 'Otorrinolaringologia'),
(7, 'CRM|BA339748', 'Dermatologia'),
(8, 'CRM|BA111778', 'Clinico Geral'),
(9, 'CRM|BA943195', 'Endocrinologia'),
(10, 'CRM|BA486802', 'Gastroenterologia'),
(11, 'CRM|BA122376', 'Cardiologia'),
(12, 'CRM|BA357783', 'Neurologia'),
(13, 'CRM|BA815023', 'Clinico Geral'),
(14, 'CRM|BA386828', 'Cardiologia'),
(15, 'CRM|BA409406', 'Urologia'),
(16, 'CRM|BA552975', 'Ginecologia'),
(17, 'CRM|BA487414', 'Oncologia'),
(18, 'CRM|BA349796', 'Ortopedia'),
(19, 'CRM|BA772952', 'Oftalmologia'),
(20, 'CRM|BA460060', 'Dermatologia'),
(21, 'CRM|BA964822', 'Endocrinologia'),
(22, 'CRM|BA114059', 'Gastroenterologia'),
(23, 'CRM|BA801726', 'Pneumologia'),
(24, 'CRM|BA924223', 'Neurologia'),
(25, 'CRM|BA1276543872', 'Mastologia'),
(26, 'CRM|BA1187538294', 'Angiologia'),
(27, 'CRM|BA451957', 'Cardiologia'),
(28, 'CRM|BA574681', 'Oncologia'),
(29, 'CRM|BA46532879104', 'Ginecologia'),
(30, 'CRM|BA73682714934', 'Urologia'),
(31, 'CRM|BA60394785369', 'Otorrinolaringologia'),
(32, 'CRM|BA49283756103', 'Dermatologia'),
(33, 'CRM|BA49372856122', 'Psiquiatria'),
(34, 'CRM|BA6012345678', 'Gastroenterologia'),
(35, 'CRM|BA040203', 'Cardiologia'),
(36, 'CRM|BA040204', 'Reumatologia'),
(37, 'CRM|BA040205', 'Hematologia'),
(38, 'CRM|BA040206', 'Infectologia'),
(39, 'CRM|BA040207', 'Neonatologia'),
(40, 'CRM|BA040208', 'Medicina do Trabalho');

INSERT INTO pacientes (id_usuario, plano_de_saude)
VALUES 
(41, 'Bradesco Saúde'),
(42, 'Amil'),
(43, 'Hapvida'),
(44, 'Blue Bahia'),
(45, 'Unimed Bahia'),
(46, 'Promédica'),
(47, 'SulAmérica Saúde'),
(48, 'Select Saúde'),
(49, 'Amil'),
(50, 'Blue Bahia'),
(51, 'Unimed Bahia'),
(52, 'Promédica'),
(53, 'Hapvida'),
(54, 'SulAmérica Saúde'),
(55, 'Bradesco Saúde'),
(56, 'Select Saúde'),
(57, 'Hapvida'),
(58, 'Amil'),
(59, 'Bradesco Saúde'),
(60, 'Blue Bahia'),
(61, 'Select Saúde'),
(62, 'SulAmérica Saúde'),
(63, 'Unimed Bahia'),
(64, 'Promédica'),
(65, 'Blue Bahia'),
(66, 'Amil'),
(67, 'SulAmérica Saúde'),
(68, 'Select Saúde'),
(69, 'Hapvida'),
(70, 'Bradesco Saúde'),
(71, 'Unimed Bahia'),
(72, 'Promédica'),
(73, 'Blue Bahia'),
(74, 'Select Saúde'),
(75, 'Amil'),
(76, 'Bradesco Saúde'),
(77, 'SulAmérica Saúde'),
(78, 'Promédica'),
(79, 'Unimed Bahia'),
(80, 'Hapvida');

INSERT INTO funcionarios (id_usuario, cargo, setor, salario)
VALUES 
(81, 'Recepcionista', 'Atendimento', 1650.00),
(82, 'Auxiliar de Limpeza', 'Serviços Gerais', 1400.00),
(83, 'Técnico de Enfermagem', 'Enfermagem', 2300.00),
(84, 'Enfermeiro', 'Enfermagem', 3300.00),
(85, 'Auxiliar Administrativo', 'Administrativo', 1800.00),
(86, 'Recepcionista', 'Atendimento', 1650.00),
(87, 'Auxiliar de Limpeza', 'Serviços Gerais', 1400.00),
(88, 'Enfermeiro', 'Enfermagem', 3400.00),
(89, 'Técnico de Enfermagem', 'Enfermagem', 2200.00),
(90, 'Auxiliar Administrativo', 'Administrativo', 1750.00),
(91, 'Técnico de Informática', 'TI', 2600.00),
(92, 'Recepcionista', 'Atendimento', 1650.00),
(93, 'Enfermeiro', 'Enfermagem', 3350.00),
(94, 'Técnico de Informática', 'TI', 2700.00),
(95, 'Técnico de Enfermagem', 'Enfermagem', 2250.00),
(96, 'Auxiliar de Limpeza', 'Serviços Gerais', 1450.00),
(97, 'Auxiliar Administrativo', 'Administrativo', 1850.00),
(98, 'Recepcionista', 'Atendimento', 1600.00),
(99, 'Enfermeiro', 'Enfermagem', 3450.00),
(100, 'Técnico de Informática', 'TI', 2550.00),
(101, 'Auxiliar de Limpeza', 'Serviços Gerais', 1400.00),
(102, 'Técnico de Enfermagem', 'Enfermagem', 2300.00),
(103, 'Recepcionista', 'Atendimento', 1650.00),
(104, 'Auxiliar Administrativo', 'Administrativo', 1800.00),
(105, 'Enfermeiro', 'Enfermagem', 3500.00),
(106, 'Técnico de Informática', 'TI', 2600.00),
(107, 'Auxiliar de Limpeza', 'Serviços Gerais', 1400.00),
(108, 'Técnico de Enfermagem', 'Enfermagem', 2350.00),
(109, 'Recepcionista', 'Atendimento', 1650.00),
(110, 'Auxiliar Administrativo', 'Administrativo', 1750.00),
(111, 'Técnico de Informática', 'TI', 2650.00),
(112, 'Enfermeiro', 'Enfermagem', 3400.00),
(113, 'Técnico de Enfermagem', 'Enfermagem', 2200.00),
(114, 'Auxiliar de Limpeza', 'Serviços Gerais', 1450.00),
(115, 'Recepcionista', 'Atendimento', 1600.00),
(116, 'Técnico de Informática', 'TI', 2550.00),
(117, 'Auxiliar Administrativo', 'Administrativo', 1850.00),
(118, 'Enfermeiro', 'Enfermagem', 3350.00),
(119, 'Auxiliar de Limpeza', 'Serviços Gerais', 1400.00),
(120, 'Técnico de Enfermagem', 'Enfermagem', 2250.00);

INSERT INTO enderecos (id_usuario, tipo_endereco, endereco, numero, complemento, bairro, cidade, estado, cep)
VALUES
(1, 'Comercial', 'Rua do Sol', '6153', 'Apartamento', 'Cabula', 'Salvador', 'BA', '43043-515'),
(2, 'Residencial', 'Travessa do Rosário', '4613', 'Casa', 'Mangabeira', 'Feira de Santana', 'BA', '42044-216'),
(3, 'Comercial', 'Rua do Sol', '6328', 'Apartamento', 'Campo Grande', 'Salvador', 'BA', '48604-783'),
(4, 'Comercial', 'Avenida Oceânica', '8257', 'Casa', 'Brotas', 'Salvador', 'BA', '43447-534'),
(5, 'Residencial', 'Rua das Palmeiras', '1149', 'Casa', 'Cidade Nova', 'Feira de Santana', 'BA', '48191-413'),
(6, 'Residencial', 'Alameda Santos', '2983', 'Apartamento', 'Kalilândia', 'Feira de Santana', 'BA', '44945-649'),
(7, 'Residencial', 'Avenida Brasil', '2150', 'Apartamento', 'Kalilândia', 'Feira de Santana', 'BA', '43255-917'),
(8, 'Residencial', 'Travessa das Flores', '4484', 'Apartamento', 'Centro', 'Feira de Santana', 'BA', '46295-274'),
(9, 'Residencial', 'Avenida Sete de Setembro', '8261', 'Casa', 'Centro', 'Feira de Santana', 'BA', '43653-781'),
(10, 'Residencial', 'Avenida Brasil', '5963', 'Apartamento', 'Barra', 'Salvador', 'BA', '40729-252'),
(11, 'Residencial', 'Rua Carlos Gomes', '7131', 'Apartamento', 'Mangabeira', 'Feira de Santana', 'BA', '45471-556'),
(12, 'Residencial', 'Rua das Palmeiras', '2094', 'Casa', 'Engenho Velho da Federação', 'Salvador', 'BA', '42218-512'),
(13, 'Comercial', 'Rua das Palmeiras', '6015', 'Casa', 'Gabriela', 'Feira de Santana', 'BA', '44979-646'),
(14, 'Residencial', 'Avenida Oceânica', '8536', 'Apartamento', 'Muchila', 'Feira de Santana', 'BA', '46668-735'),
(15, 'Comercial', 'Rua das Acácias', '8346', 'Casa', 'Muchila', 'Feira de Santana', 'BA', '45647-110'),
(16, 'Residencial', 'Rua das Acácias', '2099', 'Casa', 'Campo Grande', 'Salvador', 'BA', '47340-217'),
(17, 'Residencial', 'Rua Bela Vista', '9862', 'Apartamento', 'Rio Vermelho', 'Salvador', 'BA', '42383-089'),
(18, 'Comercial', 'Rua Chile', '5680', 'Casa', 'Conceição', 'Feira de Santana', 'BA', '44226-851'),
(19, 'Residencial', 'Avenida Oceânica', '4288', 'Apartamento', 'Brotas', 'Salvador', 'BA', '48354-234'),
(20, 'Residencial', 'Travessa das Flores', '4929', 'Apartamento', 'Tomba', 'Feira de Santana', 'BA', '44742-470'),
(21, 'Comercial', 'Avenida Brasil', '1099', 'Casa', 'Cidade Nova', 'Feira de Santana', 'BA', '47163-313'),
(22, 'Comercial', 'Rua da Alfazema', '3193', 'Casa', 'Kalilândia', 'Feira de Santana', 'BA', '42581-826'),
(23, 'Comercial', 'Rua Bela Vista', '6738', 'Apartamento', 'Cidade Nova', 'Feira de Santana', 'BA', '48290-414'),
(24, 'Comercial', 'Travessa do Rosário', '9156', 'Apartamento', 'Engenho Velho da Federação', 'Salvador', 'BA', '42208-991'),
(25, 'Residencial', 'Rua do Sol', '4484', 'Apartamento', 'Conceição', 'Feira de Santana', 'BA', '40182-611'),
(26, 'Comercial', 'Alameda Santos', '5316', 'Casa', 'Mangabeira', 'Feira de Santana', 'BA', '44155-037'),
(27, 'Comercial', 'Rua Chile', '2059', 'Casa', 'Conceição', 'Feira de Santana', 'BA', '43478-349'),
(28, 'Residencial', 'Travessa das Flores', '5733', 'Apartamento', 'Engenho Velho da Federação', 'Salvador', 'BA', '48430-577'),
(29, 'Comercial', 'Rua das Palmeiras', '78', 'Apartamento', 'Engenho Velho da Federação', 'Salvador', 'BA', '44170-703'),
(30, 'Residencial', 'Avenida Sete de Setembro', '3904', 'Apartamento', 'Cabula', 'Salvador', 'BA', '46918-716'),
(31, 'Residencial', 'Rua Chile', '5536', 'Apartamento', 'Amaralina', 'Salvador', 'BA', '47065-500'),
(32, 'Comercial', 'Travessa das Flores', '3748', 'Casa', 'Brotas', 'Salvador', 'BA', '43759-379'),
(33, 'Comercial', 'Rua Chile', '5355', 'Casa', 'Engenho Velho da Federação', 'Salvador', 'BA', '42287-827'),
(34, 'Residencial', 'Avenida Sete de Setembro', '3370', 'Apartamento', 'Tomba', 'Feira de Santana', 'BA', '45219-013'),
(35, 'Residencial', 'Travessa do Rosário', '4512', 'Apartamento', 'Cabula', 'Salvador', 'BA', '44934-336'),
(36, 'Comercial', 'Rua do Bispo', '2776', 'Casa', 'Muchila', 'Feira de Santana', 'BA', '43544-869'),
(37, 'Comercial', 'Avenida Oceânica', '9312', 'Apartamento', 'Parque Ipê', 'Feira de Santana', 'BA', '40272-426'),
(38, 'Comercial', 'Rua Chile', '3217', 'Apartamento', 'Pituba', 'Salvador', 'BA', '42001-263'),
(39, 'Comercial', 'Avenida Oceânica', '438', 'Casa', 'Pituba', 'Salvador', 'BA', '42236-819'),
(40, 'Residencial', 'Avenida Brasil', '857', 'Apartamento', 'Tomba', 'Feira de Santana', 'BA', '42925-550'),
(41, 'Comercial', 'Travessa do Rosário', '4446', 'Casa', 'Cidade Nova', 'Feira de Santana', 'BA', '45012-570'),
(42, 'Comercial', 'Rua das Palmeiras', '7552', 'Apartamento', 'Muchila', 'Feira de Santana', 'BA', '41052-920'),
(43, 'Comercial', 'Rua da Alfazema', '3270', 'Apartamento', 'Muchila', 'Feira de Santana', 'BA', '41627-235'),
(44, 'Residencial', 'Rua Chile', '5253', 'Apartamento', 'Campo Grande', 'Salvador', 'BA', '45590-328'),
(45, 'Comercial', 'Rua Direita do Santo Antônio', '196', 'Apartamento', 'Itaigara', 'Salvador', 'BA', '40773-771'),
(46, 'Residencial', 'Rua Bela Vista', '4433', 'Casa', 'Engenho Velho da Federação', 'Salvador', 'BA', '40765-597'),
(47, 'Residencial', 'Rua das Acácias', '1473', 'Apartamento', 'Gabriela', 'Feira de Santana', 'BA', '43224-720'),
(48, 'Residencial', 'Travessa do Rosário', '2284', 'Apartamento', 'Conceição', 'Feira de Santana', 'BA', '47693-048'),
(49, 'Comercial', 'Avenida Sete de Setembro', '9318', 'Casa', 'Centro', 'Feira de Santana', 'BA', '42232-277'),
(50, 'Comercial', 'Travessa do Rosário', '2448', 'Apartamento', 'Ondina', 'Salvador', 'BA', '47744-870'),
(51, 'Comercial', 'Rua das Acácias', '4999', 'Casa', 'Kalilândia', 'Feira de Santana', 'BA', '47544-063'),
(52, 'Residencial', 'Avenida Brasil', '1897', 'Casa', 'Cabula', 'Salvador', 'BA', '40502-139'),
(53, 'Comercial', 'Rua do Sol', '6184', 'Casa', 'Amaralina', 'Salvador', 'BA', '41806-639'),
(54, 'Residencial', 'Avenida Brasil', '2997', 'Casa', 'Barra', 'Salvador', 'BA', '47425-565'),
(55, 'Comercial', 'Rua das Acácias', '244', 'Casa', 'Campo Grande', 'Salvador', 'BA', '41582-402'),
(56, 'Residencial', 'Rua Direita do Santo Antônio', '8827', 'Casa', 'Barra', 'Salvador', 'BA', '42908-805'),
(57, 'Comercial', 'Travessa do Rosário', '516', 'Casa', 'Rio Vermelho', 'Salvador', 'BA', '40725-481'),
(58, 'Residencial', 'Avenida Oceânica', '1344', 'Apartamento', 'Parque Ipê', 'Feira de Santana', 'BA', '45780-516'),
(59, 'Comercial', 'Avenida Oceânica', '6472', 'Apartamento', 'Conceição', 'Feira de Santana', 'BA', '41849-380'),
(60, 'Comercial', 'Rua Bela Vista', '7538', 'Casa', 'Mangabeira', 'Feira de Santana', 'BA', '47831-625'),
(61, 'Residencial', 'Travessa do Rosário', '4499', 'Apartamento', 'SIM', 'Feira de Santana', 'BA', '40292-079'),
(62, 'Comercial', 'Avenida Brasil', '6931', 'Apartamento', 'Amaralina', 'Salvador', 'BA', '40685-778'),
(63, 'Comercial', 'Rua Direita do Santo Antônio', '3804', 'Casa', 'Amaralina', 'Salvador', 'BA', '44885-714'),
(64, 'Residencial', 'Avenida Sete de Setembro', '1693', 'Casa', 'Tomba', 'Feira de Santana', 'BA', '43531-351'),
(65, 'Comercial', 'Travessa do Rosário', '6432', 'Casa', 'Ondina', 'Salvador', 'BA', '47849-577'),
(66, 'Residencial', 'Rua Bela Vista', '7198', 'Apartamento', 'Cabula', 'Salvador', 'BA', '42506-493'),
(67, 'Comercial', 'Rua Direita do Santo Antônio', '4687', 'Apartamento', 'Campo Grande', 'Salvador', 'BA', '46897-628'),
(68, 'Comercial', 'Travessa das Flores', '2920', 'Apartamento', 'Conceição', 'Feira de Santana', 'BA', '44183-477'),
(69, 'Residencial', 'Avenida Sete de Setembro', '1817', 'Apartamento', 'Barra', 'Salvador', 'BA', '40665-433'),
(70, 'Residencial', 'Rua do Bispo', '998', 'Casa', 'Engenho Velho da Federação', 'Salvador', 'BA', '40948-237'),
(71, 'Comercial', 'Avenida Brasil', '7099', 'Casa', 'Tomba', 'Feira de Santana', 'BA', '46166-197'),
(72, 'Residencial', 'Rua das Palmeiras', '9203', 'Apartamento', 'Pituba', 'Salvador', 'BA', '48318-976'),
(73, 'Residencial', 'Rua da Alfazema', '647', 'Casa', 'Cabula', 'Salvador', 'BA', '45185-471'),
(74, 'Residencial', 'Rua Chile', '8601', 'Apartamento', 'SIM', 'Feira de Santana', 'BA', '45475-071'),
(75, 'Residencial', 'Alameda Santos', '5716', 'Casa', 'Rio Vermelho', 'Salvador', 'BA', '46268-305'),
(76, 'Comercial', 'Rua das Palmeiras', '6561', 'Apartamento', 'SIM', 'Feira de Santana', 'BA', '44730-074'),
(77, 'Comercial', 'Avenida Oceânica', '6607', 'Casa', 'Centro', 'Feira de Santana', 'BA', '46088-920'),
(78, 'Comercial', 'Rua Bela Vista', '512', 'Casa', 'SIM', 'Feira de Santana', 'BA', '43891-505'),
(79, 'Comercial', 'Rua Bela Vista', '7585', 'Apartamento', 'Tomba', 'Feira de Santana', 'BA', '40830-740'),
(80, 'Residencial', 'Rua Bela Vista', '7655', 'Apartamento', 'Parque Ipê', 'Feira de Santana', 'BA', '42212-159'),
(81, 'Comercial', 'Avenida Sete de Setembro', '3622', 'Apartamento', 'Barra', 'Salvador', 'BA', '43366-351'),
(82, 'Residencial', 'Rua das Palmeiras', '9692', 'Apartamento', 'Ondina', 'Salvador', 'BA', '43176-346'),
(83, 'Residencial', 'Avenida Brasil', '7958', 'Apartamento', 'Itaigara', 'Salvador', 'BA', '44017-935'),
(84, 'Comercial', 'Rua Direita do Santo Antônio', '2117', 'Casa', 'Ondina', 'Salvador', 'BA', '43147-744'),
(85, 'Comercial', 'Rua Bela Vista', '4501', 'Apartamento', 'Barra', 'Salvador', 'BA', '48176-823'),
(86, 'Comercial', 'Travessa do Rosário', '4688', 'Apartamento', 'Itaigara', 'Salvador', 'BA', '45558-981'),
(87, 'Comercial', 'Rua Chile', '7555', 'Apartamento', 'Amaralina', 'Salvador', 'BA', '42370-012'),
(88, 'Residencial', 'Travessa do Rosário', '7329', 'Apartamento', 'SIM', 'Feira de Santana', 'BA', '45733-979'),
(89, 'Residencial', 'Rua Chile', '7220', 'Apartamento', 'Tomba', 'Feira de Santana', 'BA', '48119-666'),
(90, 'Residencial', 'Rua do Bispo', '7110', 'Apartamento', 'Parque Ipê', 'Feira de Santana', 'BA', '44110-870'),
(91, 'Comercial', 'Rua do Sol', '7852', 'Apartamento', 'Amaralina', 'Salvador', 'BA', '40828-210'),
(92, 'Comercial', 'Avenida Oceânica', '86', 'Casa', 'Amaralina', 'Salvador', 'BA', '44899-990'),
(93, 'Comercial', 'Rua das Acácias', '2909', 'Apartamento', 'Amaralina', 'Salvador', 'BA', '41238-200'),
(94, 'Comercial', 'Avenida Oceânica', '1294', 'Casa', 'Parque Ipê', 'Feira de Santana', 'BA', '46797-368'),
(95, 'Comercial', 'Rua Chile', '7306', 'Casa', 'Gabriela', 'Feira de Santana', 'BA', '43369-129'),
(96, 'Residencial', 'Rua do Bispo', '7606', 'Apartamento', 'Cabula', 'Salvador', 'BA', '44359-906'),
(97, 'Comercial', 'Rua Carlos Gomes', '8954', 'Apartamento', 'Amaralina', 'Salvador', 'BA', '47730-430'),
(98, 'Residencial', 'Travessa do Rosário', '456', 'Apartamento', 'Kalilândia', 'Feira de Santana', 'BA', '48317-941'),
(99, 'Residencial', 'Travessa das Flores', '6858', 'Casa', 'Conceição', 'Feira de Santana', 'BA', '45944-358'),
(100, 'Comercial', 'Avenida Sete de Setembro', '1280', 'Casa', 'Parque Ipê', 'Feira de Santana', 'BA', '42474-172'),
(101, 'Comercial', 'Rua Carlos Gomes', '9091', 'Apartamento', 'Gabriela', 'Feira de Santana', 'BA', '46756-126'),
(102, 'Comercial', 'Rua Direita do Santo Antônio', '7421', 'Casa', 'SIM', 'Feira de Santana', 'BA', '43436-178'),
(103, 'Residencial', 'Rua Direita do Santo Antônio', '3310', 'Casa', 'Itaigara', 'Salvador', 'BA', '48630-458'),
(104, 'Comercial', 'Rua Carlos Gomes', '2456', 'Casa', 'Conceição', 'Feira de Santana', 'BA', '43020-352'),
(105, 'Residencial', 'Rua das Acácias', '2982', 'Apartamento', 'Engenho Velho da Federação', 'Salvador', 'BA', '44899-233'),
(106, 'Comercial', 'Rua das Palmeiras', '4035', 'Apartamento', 'Campo Grande', 'Salvador', 'BA', '45929-995'),
(107, 'Residencial', 'Travessa das Flores', '2291', 'Casa', 'Kalilândia', 'Feira de Santana', 'BA', '40598-467'),
(108, 'Residencial', 'Avenida Sete de Setembro', '5997', 'Casa', 'Centro', 'Feira de Santana', 'BA', '48188-041'),
(109, 'Residencial', 'Rua Chile', '1808', 'Apartamento', 'Itaigara', 'Salvador', 'BA', '45539-560'),
(110, 'Comercial', 'Rua da Alfazema', '9755', 'Casa', 'Centro', 'Feira de Santana', 'BA', '44138-402'),
(111, 'Comercial', 'Rua Carlos Gomes', '3474', 'Casa', 'Ondina', 'Salvador', 'BA', '45613-443'),
(112, 'Comercial', 'Travessa das Flores', '3560', 'Apartamento', 'Brotas', 'Salvador', 'BA', '45648-845'),
(113, 'Residencial', 'Rua do Bispo', '3750', 'Casa', 'Itaigara', 'Salvador', 'BA', '41528-230'),
(114, 'Residencial', 'Rua Carlos Gomes', '1534', 'Casa', 'Rio Vermelho', 'Salvador', 'BA', '43573-141'),
(115, 'Residencial', 'Rua da Alfazema', '2395', 'Casa', 'Amaralina', 'Salvador', 'BA', '48133-592'),
(116, 'Residencial', 'Avenida Brasil', '1219', 'Casa', 'Centro', 'Feira de Santana', 'BA', '42844-016'),
(117, 'Comercial', 'Rua Direita do Santo Antônio', '2119', 'Casa', 'Cidade Nova', 'Feira de Santana', 'BA', '46543-357'),
(118, 'Comercial', 'Rua das Acácias', '2308', 'Apartamento', 'Centro', 'Feira de Santana', 'BA', '43800-283'),
(119, 'Comercial', 'Travessa das Flores', '1399', 'Casa', 'Rio Vermelho', 'Salvador', 'BA', '46981-331'),
(120, 'Residencial', 'Alameda Santos', '4625', 'Casa', 'Pituba', 'Salvador', 'BA', '44546-502');

INSERT INTO exames
VALUES
(null, 'Hemograma completo', 'laboratorial', 50.00, 'Jejum não obrigatório', 'Avalia células do sangue (glóbulos vermelhos, brancos e plaquetas); detecta infecções, anemias, inflamações.', 'ativo'),
(null, 'Glicemia de jejum', 'laboratorial', 30.00, 'Jejum de 8 a 12 horas', 'Mede o nível de glicose no sangue; diagnóstico de diabetes.', 'ativo'),
(null, 'Colesterol total e frações (HDL, LDL, VLDL)', 'laboratorial', 60.00, 'Jejum de 12 horas', 'Avalia os níveis de gordura no sangue; risco cardiovascular.', 'ativo'),
(null, 'Triglicerídeos', 'laboratorial', 40.00, 'Jejum de 12 horas', 'Outro tipo de gordura no sangue; elevações aumentam risco cardíaco.', 'ativo'),
(null, 'TSH e T4 Livre', 'laboratorial', 80.00, 'Jejum opcional', 'Avaliam a função tireoidiana.', 'ativo'),
(null, 'Exame de urina tipo 1 (EAS)', 'laboratorial', 35.00, 'Coletar a primeira urina da manhã, com higiene prévia.', 'Detecta infecções urinárias, presença de proteínas, glicose etc.', 'ativo'),
(null, 'Parasitológico de fezes', 'laboratorial', 45.00, 'Amostra de fezes recente, armazenada em frasco limpo.', 'Identifica vermes e parasitas intestinais.', 'inativo'),
(null, 'Hemoglobina glicada (HbA1c)', 'laboratorial', 80.00, 'Jejum não obrigatório', 'Avalia o controle da glicemia nos últimos 2–3 meses. Importante no controle do diabetes.', 'ativo'),
(null, 'Insulina', 'laboratorial', 90.00, 'Jejum de 8 h', 'Avalia a produção de insulina e resistência à insulina.', 'ativo'),
(null, 'Ferritina', 'laboratorial', 90.00, 'Jejum opcional', 'Avalia os estoques de ferro do organismo. Útil em anemias.', 'inativo'),
(null, 'Vitamina D (25-OH)', 'laboratorial', 150.00, 'Jejum opcional', 'Avaliação dos níveis de vitamina D, relacionada à saúde óssea e imunidade.', 'ativo'),
(null, 'Vitamina B12', 'laboratorial', 120.00, 'Jejum de 8 h', 'Diagnóstico de deficiências vitamínicas ligadas à anemia e sintomas neurológicos.', 'ativo'),
(null, 'Ácido úrico', 'laboratorial', 40.00, 'Jejum de 4–8h', 'Relacionado à gota e distúrbios renais.', 'inativo'),
(null, 'Beta-HCG', 'laboratorial', 50.00, 'Jejum não obrigatório', 'Detecta gravidez nas mulheres. Também usado para rastrear algumas doenças.', 'ativo');

INSERT INTO exames
VALUES
(null, 'Raio-X de tórax', 'imagem', 150.00, 'Retirar objetos metálicos, jejum não necessário.', 'Avalia pulmões, coração e estrutura óssea torácica.', 'ativo'),
(null, 'Ultrassonografia abdominal total', 'imagem', 250.00, 'Jejum de 6 a 8 horas; bexiga cheia.', 'Visualiza fígado, rins, vesícula, baço, pâncreas etc.', 'ativo'),
(null, 'Ultrassonografia pélvica (mulheres)', 'imagem', 200.00, 'Bexiga cheia.', 'Avalia útero, ovários, trompas.', 'ativo'),
(null, 'Ultrassonografia da tireoide', 'imagem', 180.00, 'Sem preparo.', 'Avalia nódulos ou alterações da tireoide.', 'inativo'),
(null, 'Eletrocardiograma (ECG)', 'imagem', 120.00, 'Sem preparo específico.', 'Registra a atividade elétrica do coração.', 'ativo'),
(null, 'Ecodopplercardiograma', 'imagem', 50.00, 'Pode exigir jejum de 4 horas.', 'Avalia estruturas cardíacas e fluxo de sangue.', 'inativo'),
(null, 'Ultrassonografia transvaginal', 'imagem', 200.00, 'Bexiga vazia.', 'Avalia o útero e ovários de forma mais detalhada.', 'ativo'),
(null, 'Ultrassonografia de próstata (via abdominal)', 'imagem', 220.00, 'Bexiga cheia.', 'Avalia o tamanho e alterações da próstata.', 'inativo'),
(null, 'Ultrassonografia das mamas', 'imagem', 200.00, 'Sem preparo.', 'Avalia nódulos e alterações mamárias. Complementa a mamografia.', 'ativo'),
(null, 'Mamografia (mulheres)', 'imagem', 180.00, 'Não usar desodorante ou cremes no dia.', 'Rastreio do câncer de mama. Recomendado a partir dos 40 anos.', 'inativo'),
(null, 'Raio-X da coluna lombar', 'imagem', 180.00, 'Sem preparo.', 'Avaliação de dores nas costas, hérnias, problemas ósseos.', 'ativo'),
(null, 'Densitometria óssea', 'imagem', 300.00, 'Evitar roupas com metal.', 'Avaliação de osteoporose. Muito indicado após os 50 anos.', 'inativo');

INSERT INTO exames
VALUES
(null, 'Ausculta cardíaca', 'clínico', 0.00, 'Sem preparo', 'Uso do estetoscópio para avaliar sons do coração e pulmões.', 'ativo'),
(null, 'Ausculta pulmonar', 'clínico', 0.00, 'Sem preparo', 'Uso do estetoscópio para avaliar sons do coração e pulmões.', 'ativo'),
(null, 'Aferição da pressão arterial', 'clínico', 0.00, 'Em repouso, sentado, sem cafeína recente.', 'Mede a pressão nas artérias.', 'ativo'),
(null, 'Exame físico geral', 'clínico', 0.00, 'Sem preparo', 'Avaliação visual e palpação de diferentes regiões do corpo.', 'ativo'),
(null, 'Medida de IMC e circunferência abdominal', 'clínico', 0.00, 'Estar com roupas leves.', 'Avalia risco de doenças metabólicas.', 'ativo'),
(null, 'Exame neurológico básico', 'clínico', 0.00, 'Sem preparo', 'Teste de reflexos, coordenação, força muscular e sensibilidade.', 'ativo'),
(null, 'Teste ergométrico (esteira)', 'clínico', 250.00, 'Roupas confortáveis, evitar refeições pesadas antes', 'Avalia o coração sob esforço físico', 'inativo'),
(null, 'Espirometria', 'clínico', 120.00, 'Evitar broncodilatadores antes do teste', 'Avalia a função pulmonar', 'ativo'),
(null, 'MAPA 24h', 'clínico', 220.00, 'Usar aparelho por 24h, não remover', 'Mede a pressão arterial ao longo do dia', 'inativo'),
(null, 'Holter 24h', 'clínico', 250.00, 'Evitar molhar o aparelho', 'Registra o ritmo cardíaco por 24h', 'inativo'),
(null, 'Exame clínico ginecológico', 'clínico', 100.00, 'Higiene íntima', 'Avaliação ginecológica básica e coleta de Papanicolau', 'inativo'),
(null, 'Teste de glicemia capilar', 'clínico', 20.00, 'Realizar em jejum ou conforme orientação médica', 'Verifica o nível de glicose no sangue com amostra da ponta do dedo', 'ativo'),
(null, 'Exame oftalmológico básico', 'clínico', 100.00, 'Sem colírios ou lentes antes do exame', 'Avaliação da acuidade visual, pupilas e fundo de olho', 'inativo'),
(null, 'Avaliação postural e de marcha', 'clínico', 90.00, 'Sem preparo específico', 'Exame físico para avaliar equilíbrio, postura e padrão de caminhada', 'inativo');

INSERT INTO formas_de_pagamento
VALUES
(null, 'pix', 'ativo'),
(null, 'dinheiro', 'ativo'),
(null, 'cartão de crédito', 'ativo'),
(null, 'cartão de débito', 'ativo'),
(null, 'boleto', 'inativo');

INSERT INTO convenios
VALUES
(null, 'Saúde Total', 123456, 'Empresarial', '(11) 3333-4444', 'contato@saudetotal.com.br', 'http://www.saudetotal.com.br/', '2021-01-01', '2025-12-31', 'Ambulatorial + Hospitalar com Obstetrícia (consultas, exames, internações e parto)', 'ativo'),
(null, 'Vida Médica', 789012, 'Individual', '(21) 9999-8888', 'atendimento@vidamedica.com.br', 'http://www.vidamedica.com.br', '2023-05-10', '2026-05-09', 'Hospitalar com Obstetrícia (internações, cirurgias, parto, sem consultas ambulatoriais)', 'ativo'),
(null, 'Bem Viver Saúde', 345678, 'Coletivo por Adesão', '(31) 4002-8922', 'suporte@bemviver.com.br', 'www.bemviver.com.br', '2022-03-15', '2025-03-14', 'Ambulatorial (consultas, exames, sem internação ou parto)', 'ativo'),
(null, 'Plena Saúde Integrada', 901234, 'Empresarial', '(41) 3344-5566', 'contato@plenasaude.com.br', 'www.plenasaude.com.br', '2020-07-01', '2025-07-01', 'Ambulatorial + Hospitalar sem Obstetrícia (sem cobertura de parto)', 'inativo'),
(null, 'Mais Vida Planos', 567890, 'Individual', '(51) 3555-7788', 'maisvida@planos.com.br', 'www.maisvidaplanos.com.br', '2021-10-20', '2026-10-19', 'Odontológico + Ambulatorial (consultas, exames e atendimento odontológico)', 'ativo'),
(null, 'Amparo Saúde', 112233, 'Individual', '(11) 3020-5566', 'contato@amparosaude.com.br', 'www.amparosaude.com.br', '2022-02-01', '2026-02-01', 'Ambulatorial + Hospitalar com Obstetrícia (consultas, exames, internações, parto)', 'inativo'),
(null, 'Uniclin Saúde', 223344, 'Empresarial', '(21) 4004-7788', 'atendimento@uniclin.com.br', 'www.uniclin.com.br', '2021-06-15', '2025-06-14', 'Hospitalar sem Obstetrícia (cirurgias, UTI, internações, sem parto)', 'inativo'),
(null, 'NovaVida Assistência Médica', 334455, 'Coletivo por Adesão', '(31) 3456-7890', 'suporte@novavida.med.br', 'http://www.novavida.med.br', '2023-09-10', '2026-09-09', 'Ambulatorial (consultas com especialistas, exames simples e complexos)', 'ativo'),
(null, 'MedPrime Saúde', 445566, 'Individual', '(41) 3222-3344', 'contato@medprime.com.br', 'www.medprime.com.br', '2020-11-20', '2025-11-19', 'Ambulatorial + Hospitalar com Obstetrícia (cobertura total conforme Rol ANS)', 'inativo'),
(null, 'BrasilVida Planos de Saúde', 556677, 'Empresarial', '(51) 3900-4455', 'empresa@brasilvida.com.br', 'www.brasilvida.com.br', '2022-04-05', '2026-04-04', 'Hospitalar com Obstetrícia + Odontológico (internações, parto e dentista)', 'ativo'),
(null, 'Vida Plena Saúde', 100001, 'Individual', '(11) 3100-2000', 'contato@vidaplena.com.br', 'www.vidaplena.com.br', '2022-01-15', '2026-01-14', 'Ambulatorial + Hospitalar com Obstetrícia', 'inativo'),
(null, 'Saúde Brasil', 100002, 'Empresarial', '(21) 4002-8922', 'empresarial@saudebrasil.com.br', 'www.saudebrasil.com.br', '2021-08-01', '2025-07-31', 'Hospitalar com Obstetrícia', 'inativo'),
(null, 'Bem Cuidar Saúde', 100003, 'Coletivo por Adesão', '(31) 3221-4455', 'info@bemcuidar.com.br', 'www.bemcuidar.com.br', '2023-05-10', '2026-05-09', 'Ambulatorial', 'ativo'),
(null, 'TotalMed Assistência', 100004, 'Individual', '(41) 3040-9988', 'suporte@totalmed.com.br', 'www.totalmed.com.br', '2022-03-20', '2026-03-19', 'Ambulatorial + Hospitalar sem Obstetrícia', 'ativo'),
(null, 'UniSaúde Integral', 100005, 'Empresarial', '(51) 3901-2233', 'empresarial@unisaude.com.br', 'www.unisaude.com.br', '2020-09-01', '2025-08-31', 'Hospitalar com Obstetrícia', 'ativo'),
(null, 'MedVida Brasil', 100006, 'Individual', '(61) 3210-4455', 'atendimento@medvidabrasil.com.br', 'www.medvidabrasil.com.br', '2023-01-01', '2026-12-31', 'Ambulatorial + Hospitalar com Obstetrícia', 'inativo'),
(null, 'Saúde Premier', 100007, 'Empresarial', '(62) 3344-5566', 'contato@saudepremier.com.br', 'www.saudepremier.com.br', '2021-06-10', '2025-06-09', 'Hospitalar sem Obstetrícia', 'inativo'),
(null, 'Aliança Saúde', 100008, 'Coletivo por Adesão', '(81) 3111-2233', 'suporte@aliancasaude.com.br', 'www.aliancasaude.com.br', '2022-10-05', '2025-10-04', 'Ambulatorial + Odontológico', 'ativo'),
(null, 'Vita Mais Saúde', 100009, 'Individual', '(71) 3222-7788', 'vendas@vitamaissaude.com.br', 'www.vitamaissaude.com.br', '2020-04-01', '2025-03-31', 'Ambulatorial + Hospitalar com Obstetrícia', 'ativo'),
(null, 'SaúdeNova', 100010, 'Empresarial', '(85) 4003-5500', 'contato@saudenova.com.br', 'www.saudenova.com.br', '2023-07-01', '2026-06-30', 'Hospitalar com Obstetrícia', 'ativo'),
(null, 'PrimeVida Saúde', 100011, 'Individual', '(95) 3311-0099', 'cliente@primevida.com.br', 'www.primevida.com.br', '2021-02-20', '2025-02-19', 'Ambulatorial + Hospitalar com Obstetrícia', 'inativo'),
(null, 'Ideal Saúde', 100012, 'Coletivo por Adesão', '(82) 3900-3344', 'relacionamento@idealsaude.com.br', 'www.idealsaude.com.br', '2022-08-15', '2025-08-14', 'Ambulatorial', 'ativo'),
(null, 'EssencialMed', 100013, 'Individual', '(92) 3123-4567', 'suporte@essencialmed.com.br', 'www.essencialmed.com.br', '2023-03-01', '2026-02-28', 'Ambulatorial + Hospitalar sem Obstetrícia', 'ativo'),
(null, 'VivaBem Saúde', 100014, 'Empresarial', '(98) 3300-4400', 'corporativo@vivabem.com.br', 'www.vivabem.com.br', '2021-11-11', '2025-11-10', 'Hospitalar com Obstetrícia + Odontológico', 'ativo'),
(null, 'AmpliVida', 100015, 'Individual', '(84) 4002-2244', 'contato@amplivida.com.br', 'www.amplivida.com.br', '2022-06-30', '2026-06-29', 'Odontológico + Ambulatorial', 'inativo'),
(null, 'ClinMais Saúde', 200001, 'Individual', '(11) 3300-1010', 'contato@clinmais.com.br', 'www.clinmais.com.br', '2023-01-01', '2026-12-31', 'Ambulatorial com cobertura clínica e exames', 'ativo'),
(null, 'CentroVida Saúde', 200002, 'Empresarial', '(21) 4004-5678', 'empresa@centrovida.com.br', 'www.centrovida.com.br', '2022-05-10', '2025-05-09', 'Ambulatorial + Hospitalar com atendimento clínico e emergencial', 'inativo'),
(null, 'ClinCare Saúde Integrada', 200003, 'Coletivo por Adesão', '(31) 3222-9988', 'suporte@clincare.com.br', 'www.clincare.com.br', '2021-10-01', '2025-09-30', 'Ambulatorial com clínicas credenciadas e exames laboratoriais', 'ativo'),
(null, 'Saúde Ativa', 200004, 'Individual', '(41) 3030-2020', 'atendimento@saudeativa.com.br', 'www.saudeativa.com.br', '2022-03-01', '2026-02-28', 'Cobertura clínica ambulatorial e odontológica', 'inativo'),
(null, 'ClinViva Saúde', 200005, 'Empresarial', '(51) 3901-5566', 'corporativo@clinviva.com.br', 'www.clinviva.com.br', '2023-04-15', '2026-04-14', 'Clínica geral, consultas ambulatoriais e pronto atendimento', 'ativo'),
(null, 'Essencial Saúde Clínica', 200006, 'Individual', '(61) 3212-3344', 'cliente@essencialclinica.com.br', 'www.essencialclinica.com.br', '2021-07-01', '2025-06-30', 'Atendimento em clínica médica e especialidades ambulatoriais', 'ativo'),
(null, 'ClinNova Saúde', 200007, 'Empresarial', '(62) 3344-4433', 'vendas@clinnova.com.br', 'www.clinnova.com.br', '2022-02-01', '2025-01-31', 'Clínica médica, exames e internação hospitalar', 'ativo'),
(null, 'Saúde e Vida Clínica', 200008, 'Coletivo por Adesão', '(81) 3999-1122', 'adesao@saudevida.com.br', 'www.saudevida.com.br', '2023-06-10', '2026-06-09', 'Ambulatorial com ampla cobertura em clínicas e laboratórios', 'ativo'),
(null, 'VitaClin Assistência', 200009, 'Individual', '(71) 3003-3344', 'suporte@vitaclin.com.br', 'www.vitaclin.com.br', '2020-09-15', '2025-09-14', 'Consultas clínicas, exames e pronto atendimento ambulatorial', 'inativo'),
(null, 'MediFácil Saúde', 200010, 'Empresarial', '(85) 4002-2233', 'contato@medifacil.com.br', 'www.medifacil.com.br', '2021-12-01', '2025-11-30', 'Atendimento clínico ambulatorial e hospitalar com obstetrícia', 'inativo'),
(null, 'CliniCenter Brasil', 200011, 'Individual', '(95) 3222-5566', 'info@clinicenbrasil.com.br', 'www.clinicenter.com.br', '2022-08-01', '2026-07-31', 'Cobertura clínica e hospitalar com rede nacional', 'inativo'),
(null, 'UniClin Saúde Familiar', 200012, 'Empresarial', '(82) 3900-7788', 'corporativo@uniclin.com.br', 'www.uniclinfamiliar.com.br', '2023-02-15', '2026-02-14', 'Clínica geral, pediatria e atendimento domiciliar', 'ativo'),
(null, 'Planovida Clínicas', 200013, 'Individual', '(92) 3111-8877', 'contato@planovida.com.br', 'www.planovidaclinicas.com.br', '2021-06-20', '2025-06-19', 'Cobertura ambulatorial em clínicas e emergências', 'inativo'),
(null, 'AtivaClinic Saúde', 200014, 'Coletivo por Adesão', '(98) 3000-9090', 'suporte@ativaclinic.com.br', 'www.ativaclinic.com.br', '2022-11-01', '2025-10-31', 'Ambulatorial com cobertura em clínicas e consultórios médicos', 'inativo'),
(null, 'BemClin Planos Médicos', 200015, 'Individual', '(84) 4001-6655', 'relacionamento@bemclin.com.br', 'www.bemclin.com.br', '2023-03-05', '2026-03-04', 'Consultas clínicas, especialidades e exames de rotina', 'inativo');

INSERT INTO agendamentos (dt_agendada, sts, descricao, id_paciente, id_medico, id_exames, id_pagamento, id_convenio)
VALUES
('2025-05-02 21:30', 'Agendado', 'Consulta com urologista - Exame de ácido úrico', 1, 1, 13, 3, 1),
('2025-05-12 11:30', 'Agendado', 'Consulta com urologista - Exame de urina tipo 1 (EAS)', 4, 1, 6, 1, 2),
('2025-05-16 09:10', 'Agendado', 'Consulta com psiquiátrica - Exame de vitamina B12', 2, 2, 12, 4, 5),
('2025-05-17 12:30', 'Agendado', 'Consulta com Oncologista -  Hemograma completo', 7, 3, 1, 4, 12),
('2025-05-17 13:45', 'Agendado', 'Consulta com Ortopedista - Raio-X da coluna lombar', 9, 4, 25, 1, 23),
('2025-05-19 16:50', 'Agendado', 'Consulta com Ortopedista - Exame de densitometria óssea', 10, 4, 26, 1, 6),
('2025-05-20 10:20', 'Agendado', 'Consulta com Otorrinolaringologista - Exame físico geral', 11, 6, 30, 1, 6),
('2025-05-20 11:25', 'Agendado', 'Consulta com Oftalmologista - Exame oftalmológico básico', 15, 5, 39, 3, 31),
('2025-05-22 09:40', 'Agendado', 'Consulta com Oftalmologista - Exame de glicemia em jejum', 26, 5, 2, 3, 39),
('2025-05-23 15:25', 'Agendado', 'Consulta com Clínico Geral - Aferição da pressão arterial', 20, 8, 29, 3, 2),
('2025-05-23 18:15', 'Agendado', 'Consulta com Gastroenterologista - Exame de triglicerídeos', 14, 10, 4, 3, 16),
('2025-05-24 07:05', 'Agendado', 'Consulta com Cardiologista - Eletrocardiograma (ECG)', 12, 11, 19, 2, 11),
('2025-05-24 19:00', 'Agendado', 'Consulta com Neurologista - Exame neurológico básico', 37, 12, 32, 4, 9),
('2025-05-25 09:20', 'Agendado', 'Consulta com Pneumologista - Exame de espirometria', 30, 23, 34, 2, 30),
('2025-05-24 14:30', 'Agendado', 'Consulta com Gastroenterologista - Exame de ferritina', 40, 22, 10, 1, 38),
('2025-05-25 20:30', 'Agendado', 'Consulta com Oncologista - Exame de vitamina D (25-OH)', 32, 30, 11, 1, 40),
('2025-06-01 09:30', 'Agendado', 'Consulta com Cardiologista - Ecodopplercardiograma', 26, 40, 20, 2, 35),
('2025-06-03 10:10', 'Agendado', 'Consulta com Mastologista - Exame de mamografia', 8, 25, 24, 4, 40),
('2025-06-03 14:00', 'Agendado', 'Consulta com Neurologista - Exame de hemoglobina glicada (HbA1c)', 15, 12, 8, 4, 26),
('2025-06-06 12:00', 'Agendado', 'Consulta com Otorrinolaringologista - Hemograma Completo', 16, 6, 1, 3, 22),
('2025-06-06 16:45', 'Agendado', 'Consulta com Endócrinologista - Exame de TSH e T4 livre', 26, 9, 5, 3, 21),
('2025-06-07 18:20', 'Agendado', 'Consulta com Dermatologista - Exame de vitamina B12', 18, 20, 12, 3, 18),
('2025-06-09 07:45', 'Agendado', 'Consulta com Ginecologista - Ultrassonografia transvaginal', 21, 31, 21, 2, 13),
('2025-06-09 15:25', 'Agendado', 'Consulta com Otorrinolaringologista - Hemograma Completo', 33, 33, 1, 2, 19),
('2025-06-10 07:10', 'Agendado', 'Consulta com Pneumologista - Exame de ausculta pulmonar', 38, 23, 28, 1, 4),
('2025-06-12 17:45', 'Agendado', 'Consulta com Cardiologista - Exame de colesterol total e frações (HDL, LDL, VLDL)', 34, 27, 3, 4, 29),
('2025-06-12 16:30', 'Agendado', 'Consulta com Oncologista - Exame de vitamina D (25-OH)', 35, 3, 11, 3, 10),
('2025-06-12 09:35', 'Agendado', 'Consulta com Oftamologista - Exame oftalmológico básico', 25, 5, 39, 3, 14),
('2025-06-14 20:00', 'Agendado', 'Consulta com Oftamologista - Exame de glicemia de jejum', 24, 5, 2, 4, 23),
('2025-06-14 19:40', 'Agendado', 'Consulta com Cardiologista - Exame de triglicerídios', 12, 14, 4, 2, 24),
('2025-06-16 18:10', 'Agendado', 'Consulta com Neurologista - Avaliação postural e de marcha', 1, 24, 40, 1, 27),
('2025-06-16 13:05', 'Agendado', 'Consulta com Urologista - Ultrassonografia da próstata', 39, 15, 22, 1, 17),
('2025-06-18 07:10', 'Agendado', 'Consulta com Oftamologista - Exame de hemoglobina glicada (HbA1c)', 37, 19, 8, 4, 6),
('2025-06-18 10:30', 'Agendado', 'Consulta com Oftamologista - Exame oftalmológico básico', 28, 19, 39, 3, 8),
('2025-06-19 13:50', 'Agendado', 'Consulta com Ortopedista - Exame de densitometria óssea', 11, 18, 26, 3, 9),
('2025-06-20 20:20', 'Agendado', 'Consulta com Cardiologista - Exame de MAPA 24h', 10, 11, 35, 2, 20),
('2025-06-20 15:40', 'Agendado', 'Consulta com Endócrinologista - Exame de colesterol total e frações (HDL, LDL, VLDL)', 4, 21, 3, 2, 9),
('2025-06-21 14:55', 'Agendado', 'Consulta com Angiologista - Exame físico geral', 30, 26, 30, 4, 28),
('2025-06-22 10:50', 'Agendado', 'Consulta com Cardiologista - Exame de ausculta cardíaca', 10, 37, 27, 4, 26),
('2025-06-24 19:00', 'Agendado', 'Consulta com Gastroenterologista - Exame de glicemia de jejum', 24, 22, 2, 3, 3);

INSERT INTO prontuarios (id_paciente, id_medico, id_agendamento, dt_atendimento, queixa_principal, historico_clinico, diagnostico, conduta, observacoes)
VALUES
(1, 1, 1, '2025-03-10 08:30:00', 'Dor de cabeça intensa', 'Paciente com histórico de enxaqueca', 'Enxaqueca', 'Prescrito analgésico', 'Acompanhar evolução.'),
(2, 2, 2, '2025-03-11 09:00:00', 'Tosse seca persistente', 'Tabagista há 10 anos', 'Bronquite', 'Receitado xarope expectorante', 'Evitar ambientes poluídos.'),
(3, 3, 3, '2025-03-12 10:15:00', 'Febre alta e dor no corpo', 'Nenhum histórico relevante', 'Infecção viral', 'Repouso e hidratação', 'Retorno se febre persistir.'),
(4, 4, 4, '2025-03-13 14:45:00', 'Dores lombares', 'Atividade física intensa', 'Distensão muscular', 'Prescrito anti-inflamatório', 'Evitar esforços por 1 semana.'),
(5, 5, 5, '2025-03-14 11:30:00', 'Dor abdominal', 'Paciente com gastrite', 'Crise de gastrite', 'Receitado omeprazol', 'Retornar em 7 dias.'),
(6, 6, 6, '2025-03-15 08:00:00', 'Falta de ar leve', 'Histórico de asma', 'Asma leve', 'Uso de bombinha prescrito', 'Evitar gatilhos.'),
(7, 7, 7, '2025-03-16 13:00:00', 'Dor nas articulações', 'Histórico de artrite reumatoide', 'Artrite em atividade', 'Iniciar corticoterapia', 'Encaminhado para reumatologia.'),
(8, 8, 8, '2025-03-17 10:45:00', 'Coceira na pele', 'Alergia a poeira', 'Dermatite alérgica', 'Uso de anti-histamínico', 'Evitar contato com alérgenos.'),
(9, 9, 9, '2025-03-18 15:30:00', 'Dor torácica', 'Paciente ansioso', 'Dor muscular', 'Orientação sobre estresse', 'Agendado psicólogo.'),
(10, 10, 10, '2025-03-19 16:20:00', 'Tontura ao levantar', 'Paciente hipertenso', 'Hipotensão postural', 'Ajuste de medicação', 'Acompanhamento semanal.'),
(11, 11, 11, '2025-03-20 08:30:00', 'Náuseas frequentes', 'Sem histórico', 'Refluxo gastroesofágico', 'Prescrição de antiácido', 'Revisão em 10 dias.'),
(12, 12, 12, '2025-03-21 08:30:00', 'Queda de cabelo', 'Histórico familiar', 'Alopecia androgênica', 'Indicado minoxidil', 'Acompanhar dermatologia.'),
(13, 13, 13, '2025-03-22 08:30:00', 'Cansaço constante', 'Anemia prévia', 'Anemia ferropriva', 'Suplementação de ferro', 'Retorno com hemograma.'),
(14, 14, 14, '2025-03-23 08:30:00', 'Inchaço nas pernas', 'Sedentarismo', 'Má circulação', 'Meias compressoras prescritas', 'Evitar longos períodos sentado.'),
(15, 15, 15, '2025-03-24 08:30:00', 'Dor no ouvido', 'Otites recorrentes', 'Otite média aguda', 'Antibiótico e analgésico', 'Retorno em 5 dias.'),
(16, 16, 16, '2025-03-25 08:30:00', 'Alteração visual súbita', 'Miopia', 'Descolamento de retina', 'Encaminhado ao oftalmologista', 'Urgência detectada.'),
(17, 17, 17, '2025-03-26 08:30:00', 'Formigamento nas mãos', 'Trabalha com digitação', 'Síndrome do túnel do carpo', 'Uso de tala e repouso', 'Encaminhar para ortopedia.'),
(18, 18, 18, '2025-03-27 08:30:00', 'Manchas roxas', 'Histórico de plaquetopenia', 'Trombocitopenia', 'Encaminhado hematologia', 'Realizar exames urgentes.'),
(19, 19, 19, '2025-03-28 08:30:00', 'Gânglio inchado no pescoço', 'Infecção anterior', 'Linfadenopatia', 'Observação clínica', 'Sem sinais de malignidade.'),
(20, 20, 20, '2025-03-29 08:30:00', 'Rouquidão persistente', 'Fumante ativo', 'Laringite crônica', 'Cessar tabagismo', 'Encaminhar otorrino.'),
(21, 21, 21,'2025-04-01 08:30:00','Dor nas costas','Má postura','Lombalgia','Fisioterapia indicada','Rever ergonomia.'),
(22, 22, 22,'2025-04-02 08:30:00','Azia constante','Sem histórico','Dispepsia','Omeprazol 40mg','Evitar alimentos ácidos.'),
(23, 23, 23,'2025-04-03 08:30:00','Fadiga muscular','Atividade física recente','Miopatia leve','Reposição eletrolítica','Reavaliar esforço físico.'),
(24, 24, 24,'2025-04-04 08:30:00','Palpitações','Estresse recente','Taquicardia sinusal','Controle de ansiedade','Exames adicionais requisitados.'),
(25, 25, 25,'2025-04-05 08:30:00','Infecção urinária','Episódio anterior','Cistite','Antibiótico por 7 dias','Beber bastante líquido.'),
(26, 26, 26,'2025-04-06 08:30:00','Ferida que não cicatriza','Diabetes tipo 2','Úlcera cutânea','Pomada antibiótica','Encaminhar enfermagem.'),
(27, 27, 27,'2025-04-07 08:30:00','Sensação de desmaio','Hipoglicemia anterior','Hipoglicemia','Revisar insulina','Orientado quanto à alimentação.'),
(28, 28, 28,'2025-04-08 08:30:00','Batimento irregular','Uso de estimulantes','Arritmia leve','Suspender cafeína','Encaminhar cardiologista.'),
(29, 29, 29,'2025-04-09 08:30:00','Nervosismo','Prova próxima','Ansiedade','Prescrito ansiolítico leve','Revisão psicológica.'),
(30, 30, 30,'2025-04-10 08:30:00','Sangramento nasal','Tempo seco','Rinite alérgica','Hidratar narinas','Umidificador recomendado.'),
(31, 31, 31,'2025-04-11 08:30:00','Tosse com catarro','Tabagismo crônico','Bronquite crônica','Broncodilatador','Parar de fumar.'),
(32, 32, 32,'2025-04-12 08:30:00','Falta de apetite','Recente luto','Depressão leve','Encaminhamento psiquiatra','Iniciar acompanhamento.'),
(33, 33, 33,'2025-04-13 08:30:00','Calafrios à noite','Viagem recente','Dengue','Exame NS1 solicitado','Hidratação intensa.'),
(34, 34, 34,'2025-04-14 08:30:00','Cólica menstrual intensa','Uso de anticoncepcional','Dismenorreia','Analgésico e repouso','Ginecologista agendado.'),
(35, 35, 35,'2025-04-15 08:30:00','Pé inchado','Uso de sapatos apertados','Entorse leve','Gelo e anti-inflamatório','Radiografia solicitada.'),
(36, 36, 36,'2025-04-16 08:30:00','Dor no joelho','Corrida intensa','Lesão ligamentar','Imobilização e repouso','Fisioterapia após 7 dias.'),
(37, 37, 37,'2025-04-17 08:30:00','Infecção de garganta','Histórico de amigdalite','Amigdalite','Amoxicilina prescrita','Retorno em 5 dias.'),
(38, 38, 38,'2025-04-18 08:30:00','Dificuldade para dormir','Estresse no trabalho','Insônia','Higiene do sono orientada','Consulta com psicólogo.'),
(39, 39, 39,'2025-04-19 08:30:00','Pele ressecada','Tempo seco','Dermatite','Hidratante prescrito','Evitar sabonetes agressivos.'),
(40, 40, 40,'2025-04-20 08:30:00','Tremores nas mãos','Café em excesso','Excesso de cafeína','Reduzir consumo','Agendado clínico geral.');

INSERT INTO exames_prontuarios (id_prontuario, id_exame, resultado, data_resultado)
VALUES
(1, 1, 'Sem alterações significativas.', '2025-03-01 14:10:00'),
(2, 2, 'Inflamação leve observada.', '2025-03-02 14:20:00'),
(3, 3, 'Resultado dentro dos parâmetros.', '2025-03-03 14:30:00'),
(4, 4, 'Lesão detectada no exame de imagem.', '2025-03-04 15:00:00'),
(5, 5, 'Sinais de infecção presentes.', '2025-03-05 13:50:00'),
(6, 6, 'Ausência de alterações clínicas.', '2025-03-06 12:45:00'),
(7, 7, 'Exame positivo para bactéria.', '2025-03-07 13:20:00'),
(8, 8, 'Leucócitos elevados.', '2025-03-08 14:15:00'),
(9, 9, 'Imagem confirma suspeita inicial.', '2025-03-09 14:45:00'),
(10, 10, 'Presença de secreção nasal.', '2025-03-10 11:30:00'),
(11, 11, 'Pulmões com padrão compatível com bronquite.', '2025-03-11 14:00:00'),
(12, 12, 'Níveis hormonais dentro do normal.', '2025-03-12 15:30:00'),
(13, 13, 'Vestígios de infecção viral.', '2025-03-13 12:10:00'),
(14, 14, 'Sinusite moderada identificada.', '2025-03-14 13:50:00'),
(15, 15, 'Eletrocardiograma sem alterações.', '2025-03-15 11:00:00'),
(16, 16, 'Lesão óssea confirmada.', '2025-03-16 15:10:00'),
(17, 17, 'Exame negativo para infecção.', '2025-03-17 14:40:00'),
(18, 18, 'Resultados normais.', '2025-03-18 14:25:00'),
(19, 19, 'Arritmia discreta identificada.', '2025-03-19 13:00:00'),
(20, 20, 'Imagem compatível com pneumonia.', '2025-03-20 14:05:00'),
(21, 21, 'Presença de secreção purulenta.', '2025-03-21 12:20:00'),
(22, 22, 'Exame dentro do esperado.', '2025-03-22 13:10:00'),
(23, 23, 'Traçado normal no ECG.', '2025-03-23 14:30:00'),
(24, 24, 'Fratura identificada no tornozelo.', '2025-03-24 13:40:00'),
(25, 25, 'Exame negativo.', '2025-03-25 11:50:00'),
(26, 26, 'Infecção leve detectada.', '2025-03-26 14:20:00'),
(27, 27, 'Raio-x confirma congestão nasal.', '2025-03-27 12:35:00'),
(28, 28, 'Mancha escura observada em imagem.', '2025-03-28 13:25:00'),
(29, 29, 'Resultado inconclusivo. Repetir exame.', '2025-03-29 14:10:00'),
(30, 30, 'Função cardíaca preservada.', '2025-03-30 12:45:00'),
(31, 31, 'Sinais de sinusite crônica.', '2025-03-31 13:10:00'),
(32, 32, 'Análise negativa para bactérias.', '2025-04-01 15:00:00'),
(33, 33, 'Tomografia revela inflamação.', '2025-04-02 14:35:00'),
(34, 34, 'Exame normal.', '2025-04-03 12:00:00'),
(35, 35, 'Dengue confirmada por sorologia.', '2025-04-04 14:25:00'),
(36, 36, 'Infiltrado pulmonar observado.', '2025-04-05 15:40:00'),
(37, 37, 'Imagem de seios da face com opacidade.', '2025-04-06 13:55:00'),
(38, 38, 'Hemograma alterado.', '2025-04-07 14:15:00'),
(39, 39, 'Resíduo de infecção anterior.', '2025-04-08 14:45:00'),
(40, 40, 'Sem anormalidades detectadas.', '2025-04-09 14:30:00');

INSERT INTO receitas_medicas (id_prontuario, dt_receita, medicamentos, bula)
VALUES
(1, '2025-04-01 10:15:00', 'Paracetamol 500mg, 1 comprimido a cada 8h por 5 dias.', 'https://bula.paracetamol.com'),
(2, '2025-04-02 09:00:00', 'Amoxicilina 500mg, 1 cápsula a cada 8h por 7 dias.', 'https://bula.amoxicilina.com'),
(3, '2025-04-03 11:20:00', 'Dipirona 1g/ml, 20 gotas a cada 6h em caso de dor.', 'https://bula.dipirona.com'),
(4, '2025-04-04 08:45:00', 'Ibuprofeno 600mg, 1 comprimido após refeições por 5 dias.', 'https://bula.ibuprofeno.com'),
(5, '2025-04-05 13:30:00', 'Azitromicina 500mg, 1 comprimido por dia por 3 dias.', 'https://bula.azitromicina.com'),
(6, '2025-04-06 14:00:00', 'Loratadina 10mg, 1 comprimido ao dia por 10 dias.', 'https://bula.loratadina.com'),
(7, '2025-04-07 12:10:00', 'Cetoprofeno 100mg, 1 comprimido a cada 12h.', 'https://bula.cetoprofeno.com'),
(8, '2025-04-08 15:00:00', 'Omeprazol 20mg, 1 cápsula em jejum por 14 dias.', 'https://bula.omeprazol.com'),
(9, '2025-04-09 09:30:00', 'Prednisona 20mg, 1 comprimido por dia por 5 dias.', 'https://bula.prednisona.com'),
(10, '2025-04-10 10:40:00', 'Desloratadina 5mg, 1 comprimido ao dia.', 'https://bula.desloratadina.com'),
(11, '2025-04-11 11:00:00', 'Clavulin 875mg, 1 comprimido a cada 12h por 7 dias.', 'https://bula.clavulin.com'),
(12, '2025-04-12 14:20:00', 'Xarope de ambroxol, 5ml a cada 8h.', 'https://bula.ambroxol.com'),
(13, '2025-04-13 16:30:00', 'Cetirizina 10mg, 1 comprimido ao dia.', 'https://bula.cetirizina.com'),
(14, '2025-04-14 08:10:00', 'Diclofenaco sódico 50mg, 1 comprimido a cada 8h.', 'https://bula.diclofenaco.com'),
(15, '2025-04-15 13:00:00', 'Metformina 850mg, 1 comprimido após o almoço.', 'https://bula.metformina.com'),
(16, '2025-04-16 10:50:00', 'Gliclazida 30mg, 1 comprimido antes do jantar.', 'https://bula.gliclazida.com'),
(17, '2025-04-17 09:40:00', 'Enalapril 10mg, 1 comprimido ao dia.', 'https://bula.enalapril.com'),
(18, '2025-04-18 12:15:00', 'Losartana 50mg, 1 comprimido de manhã.', 'https://bula.losartana.com'),
(19, '2025-04-19 15:25:00', 'Simeticona 125mg, 1 cápsula após refeições.', 'https://bula.simeticona.com'),
(20, '2025-04-20 11:05:00', 'Fluconazol 150mg, dose única.', 'https://bula.fluconazol.com'),
(21, '2025-04-21 14:35:00', 'Albendazol 400mg, 1 comprimido por 5 dias.', 'https://bula.albendazol.com'),
(22, '2025-04-22 10:25:00', 'Levofloxacino 500mg, 1 comprimido ao dia por 7 dias.', 'https://bula.levofloxacino.com'),
(23, '2025-04-23 13:45:00', 'Hidroxicloroquina 400mg, 1 ao dia.', 'https://bula.hidroxicloroquina.com'),
(24, '2025-04-24 09:55:00', 'Tiamina 300mg, 1 comprimido ao dia.', 'https://bula.tiamina.com'),
(25, '2025-04-25 12:00:00', 'Vitamina D 50.000 UI, 1 cápsula por semana.', 'https://bula.vitaminaD.com'),
(26, '2025-04-26 11:10:00', 'Complexo B, 1 comprimido ao dia.', 'https://bula.complexoB.com'),
(27, '2025-04-27 10:30:00', 'Ranitidina 150mg, 1 comprimido antes de dormir.', 'https://bula.ranitidina.com'),
(28, '2025-04-28 15:10:00', 'Espinheira-santa, 20 gotas antes das refeições.', 'https://bula.espinheira.com'),
(29, '2025-04-29 13:20:00', 'Bromoprida 10mg, 1 comprimido antes das refeições.', 'https://bula.bromoprida.com'),
(30, '2025-04-30 12:40:00', 'Propranolol 40mg, 1 comprimido a cada 12h.', 'https://bula.propranolol.com'),
(31, '2025-05-01 08:30:00', 'Clonazepam 0.5mg, 1 comprimido à noite.', 'https://bula.clonazepam.com'),
(32, '2025-05-02 09:15:00', 'Sertralina 50mg, 1 comprimido ao dia.', 'https://bula.sertralina.com'),
(33, '2025-05-03 14:45:00', 'Lorazepam 2mg, 1 comprimido antes de dormir.', 'https://bula.lorazepam.com'),
(34, '2025-05-04 10:05:00', 'Fluoxetina 20mg, 1 cápsula pela manhã.', 'https://bula.fluoxetina.com'),
(35, '2025-05-05 13:35:00', 'Clorpromazina 25mg, 1 comprimido após o almoço.', 'https://bula.clorpromazina.com'),
(36, '2025-05-06 11:50:00', 'Diazepam 5mg, 1 comprimido ao deitar.', 'https://bula.diazepam.com'),
(37, '2025-05-07 10:00:00', 'Haloperidol 1mg, 1 comprimido 2x ao dia.', 'https://bula.haloperidol.com'),
(38, '2025-05-08 12:15:00', 'Quetiapina 100mg, 1 comprimido ao dia.', 'https://bula.quetiapina.com'),
(39, '2025-05-09 09:35:00', 'Risperidona 2mg, 1 comprimido à noite.', 'https://bula.risperidona.com'),
(40, '2025-05-10 08:50:00', 'Clonazepam 0.25mg, 1 comprimido antes de dormir.', 'https://bula.clonazepam.com');

ALTER TABLE exames ADD COLUMN data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP;
 
DELIMITER $$
CREATE TRIGGER t_atualizar_status_medico_ao_deletar
BEFORE DELETE ON medicos
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM usuarios WHERE id_usuario = OLD.id_usuario AND sts_usuario = 'Ativo') THEN
        UPDATE usuarios
        SET sts_usuario = 'Inativo'
        WHERE id_usuario = OLD.id_usuario;
    END IF;
END $$
DELIMITER ;
 
DELIMITER $$
CREATE TRIGGER t_atualizar_status_paciente_ao_deletar
BEFORE DELETE ON pacientes
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM usuarios WHERE id_usuario = OLD.id_usuario AND sts_usuario = 'Ativo') THEN
        UPDATE usuarios
        SET sts_usuario = 'Inativo'
        WHERE id_usuario = OLD.id_usuario;
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER t_atualizar_status_funcionario_ao_deletar
BEFORE DELETE ON funcionarios
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM usuarios WHERE id_usuario = OLD.id_usuario AND sts_usuario = 'Ativo') THEN
        UPDATE usuarios
        SET sts_usuario = 'Inativo'
        WHERE id_usuario = OLD.id_usuario;
    END IF;
END $$
DELIMITER ;

DELIMITER //
CREATE TRIGGER atualiza_data_alteracao
BEFORE UPDATE ON exames
FOR EACH ROW
BEGIN
    SET NEW.data_alteracao = NOW();
END//
DELIMITER ;
DELIMITER //

CREATE TRIGGER atualiza_status_apos_data
BEFORE UPDATE ON agendamentos
FOR EACH ROW
BEGIN
    IF NEW.dt_agendada < NOW() AND NEW.sts = 'Agendado' THEN
        SET NEW.sts = 'Não compareceu';
    END IF;
END;
//

DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_validar_data_exame
BEFORE INSERT ON exames_prontuarios
FOR EACH ROW
BEGIN
    DECLARE data_atendimento DATETIME;

    SELECT dt_atendimento INTO data_atendimento
    FROM prontuarios
    WHERE id_prontuario = NEW.id_prontuario;

    IF NEW.data_resultado < data_atendimento THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A data do exame não pode ser anterior à data do atendimento';
    END IF;
END;
//
DELIMITER ;

DELIMITER $$
CREATE FUNCTION contar_agendamentos_medico(p_id_medico INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM agendamentos
        WHERE id_medico = p_id_medico
    );
END $$
DELIMITER ;

DELIMITER //
CREATE FUNCTION calcular_valor_com_desconto(valor DECIMAL(10,2), desconto_percentual INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE valor_final DECIMAL(10,2);
    SET valor_final = valor - (valor * desconto_percentual / 100);
    RETURN valor_final;
END//
DELIMITER ;

DELIMITER $$
CREATE FUNCTION buscar_nome_usuario(p_id_usuario INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    RETURN (
        SELECT nome_completo
        FROM usuarios
        WHERE id_usuario = p_id_usuario
    );
END$$
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_total_exames_por_prontuario (id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM exames_prontuarios
    WHERE id_prontuario = id;

    RETURN total;
END;
//
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE cadastrar_usuario (
    IN p_nome_completo VARCHAR(50),
    IN p_data_nascimento DATE,
    IN p_cpf CHAR(14),
    IN p_email VARCHAR(45),
    IN p_senha VARCHAR(45),
    IN p_telefone CHAR(15),
    IN p_tipo_usuario ENUM('Médico', 'Paciente', 'Funcionário'),
    IN p_crm VARCHAR(30),       
    IN p_especialidade VARCHAR(60), 
    IN p_cargo VARCHAR(60),     
    IN p_setor VARCHAR(40),     
    IN p_salario DECIMAL(10,2), 
    IN p_plano_de_saude VARCHAR(100), 
    IN p_sts_usuario ENUM('Ativo', 'Inativo') 
)
BEGIN
    DECLARE novo_id_usuario INT;

    INSERT INTO usuarios (
        nome_completo, data_nascimento, cpf, email, senha, telefone, tipo_usuario, sts_usuario
    ) VALUES (
        p_nome_completo, p_data_nascimento, p_cpf, p_email, p_senha, p_telefone, p_tipo_usuario, p_sts_usuario
    );

    SET novo_id_usuario = LAST_INSERT_ID();

    IF p_tipo_usuario = 'Médico' THEN
        INSERT INTO medicos (
            id_usuario, crm, especialidade
        ) VALUES (
            novo_id_usuario, p_crm, p_especialidade
        );

    ELSEIF p_tipo_usuario = 'Funcionário' THEN
        INSERT INTO funcionarios (
            id_usuario, cargo, setor, salario
        ) VALUES (
            novo_id_usuario, p_cargo, p_setor, p_salario
        );

    ELSEIF p_tipo_usuario = 'Paciente' THEN
        INSERT INTO pacientes (
            id_usuario, plano_de_saude
        ) VALUES (
            novo_id_usuario, p_plano_de_saude
        );
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE inserir_exame(
    IN p_nome VARCHAR(100),
    IN p_tp_exame ENUM('laboratorial', 'imagem', 'clínico'),
    IN p_descricao TEXT,
    IN p_instrucoes VARCHAR(500),
    IN p_valor DECIMAL(10,2),
    IN p_status ENUM('ativo', 'inativo')
)
BEGIN
    INSERT INTO exames (
        nome,
        tp_exame,
        descricao,
        instrucoes,
        valor,
        sts
    )
    VALUES (
        p_nome,
        p_tp_exame,
        p_descricao,
        p_instrucoes,
        p_valor,
        p_status
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE cancelar_agendamento(IN p_id_agendamento INT)
BEGIN
    UPDATE agendamentos
    SET sts = 'Cancelado'
    WHERE id_agendamento = p_id_agendamento;
END $$

DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_receitas_por_diagnostico (IN diag TEXT)
BEGIN
    SELECT 
        r.id_receita,
        r.dt_receita,
        r.medicamentos,
        r.bula,
        p.diagnostico
    FROM receitas_medicas r
    JOIN prontuarios p ON p.id_prontuario = r.id_prontuario
    WHERE p.diagnostico LIKE CONCAT('%', diag, '%')
    ORDER BY r.dt_receita DESC;
END;
//
DELIMITER ;

UPDATE usuarios
SET 
    data_nascimento = CASE
        WHEN id_usuario = 1 THEN '1990-08-05'  
        WHEN id_usuario = 19 THEN '1972-11-05'  
        ELSE data_nascimento
    END,
    sts_usuario = CASE 
        WHEN id_usuario IN (11, 21, 57, 66) THEN 'Inativo'
        ELSE sts_usuario
    END,
    telefone = CASE
        WHEN id_usuario = 46 THEN '21991234567'
        ELSE telefone
    END,
    email = CASE
        WHEN id_usuario = 59 THEN 'ThiagoRibeiroCavalcanti@rhyta.com'
        ELSE email
    END
WHERE id_usuario IN (1, 19, 11, 21, 46, 57, 59, 66);

UPDATE exames
SET sts = 'ativo'
WHERE id_exame IN (7,10,33);
### VERIFICAR ARQUIVO ORIGINAL ###
UPDATE exames AS e
JOIN (
    SELECT id_exame
    FROM exames
    WHERE valor > 200 AND tp_exame = 'imagem'
) AS filtro ON e.id_exame = filtro.id_exame
SET e.sts = 'ativo';

UPDATE agendamentos
SET sts = 'Concluído'
WHERE id_agendamento = 1;

UPDATE agendamentos
SET dt_agendada = '2025-06-30 08:00:00'
WHERE id_agendamento = 5;

UPDATE agendamentos
SET sts = 'Remarcado'
WHERE id_agendamento = 5;

UPDATE prontuarios
SET conduta = 'Paciente orientado a manter repouso e hidratação'
WHERE id_prontuario = 5;
###  VERIFICAR ### 
DELETE FROM enderecos
WHERE id_endereco IN (79, 80);

DELETE FROM pacientes 
WHERE id_paciente IN (39, 40);

DELETE FROM usuarios
WHERE id_usuario IN (79, 80) AND tipo_usuario = 'Paciente';

DELETE FROM convenios 
WHERE id_convenio IN (39,40);

DELETE FROM agendamentos
WHERE id_agendamento = 32;

DELETE FROM receitas_medicas
WHERE id_receita = 40;
##########################################################
CREATE VIEW vw_usuarios_maiores_18 AS
SELECT 
    u.id_usuario,
    u.nome_completo,
    u.data_nascimento,
    TIMESTAMPDIFF(YEAR, u.data_nascimento, CURDATE()) AS idade,
    u.tipo_usuario
FROM 
    usuarios u
WHERE 
    TIMESTAMPDIFF(YEAR, u.data_nascimento, CURDATE()) >= 18;

CREATE VIEW vw_usuarios_menores_18 AS
SELECT 
    u.id_usuario,
    u.nome_completo,
    u.data_nascimento,
    TIMESTAMPDIFF(YEAR, u.data_nascimento, CURDATE()) AS idade,
    u.tipo_usuario
FROM 
    usuarios u
WHERE 
    TIMESTAMPDIFF(YEAR, u.data_nascimento, CURDATE()) < 18;

DELIMITER $$
CREATE VIEW vw_agendamentos_por_medico AS
SELECT 
    m.id_medico,
    buscar_nome_usuario(m.id_usuario) AS nome_medico,
    COUNT(a.id_agendamento) AS total_agendamentos
FROM 
    medicos m
JOIN 
    agendamentos a ON m.id_medico = a.id_medico
JOIN
    usuarios u ON m.id_usuario = u.id_usuario 
WHERE 
    u.sts_usuario = 'Ativo' 
GROUP BY 
    m.id_medico, m.id_usuario
HAVING 
    COUNT(a.id_agendamento) > 3
ORDER BY 
    total_agendamentos DESC; 
$$
DELIMITER ;

CREATE VIEW vw_consultas_por_medico AS
SELECT id_medico, COUNT(*) AS total_consultas
FROM agendamentos
GROUP BY id_medico;

CREATE VIEW vw_agendamentos_futuros AS
SELECT 
    a.id_agendamento,
    a.dt_agendada,
    a.sts,
    a.descricao,
    u.nome_completo AS nome_paciente,
    um.nome_completo AS nome_medico,
    e.nome AS nome_exame,
    c.nome AS nome_convenio,
    pg.nome AS tipo_pagamento
FROM agendamentos a
JOIN pacientes p ON a.id_paciente = p.id_paciente
JOIN usuarios u ON p.id_usuario = u.id_usuario
JOIN medicos m ON a.id_medico = m.id_medico
JOIN usuarios um ON m.id_usuario = um.id_usuario
JOIN exames e ON a.id_exames = e.id_exame
JOIN convenios c ON a.id_convenio = c.id_convenio
JOIN formas_de_pagamento pg ON a.id_pagamento = pg.id_pagamento
WHERE a.dt_agendada > NOW();

CREATE VIEW vw_agendamentos_ordenados AS
SELECT 
    id_agendamento,
    descricao,
    dt_agendada,
    sts,
    id_paciente,
    id_medico,
    id_pagamento,
    id_convenio,
    id_exames
FROM agendamentos
ORDER BY dt_agendada ASC;

CREATE VIEW vw_exames_por_forma_pagamento AS 
SELECT 
    fp.nome AS forma_pagamento, 
    COUNT(e.id_exame) AS total_exames_realizados, 
    SUM(e.valor) AS valor_total_exames
FROM 
    exames e
JOIN 
    formas_de_pagamento fp ON e.id_exame = fp.id_pagamento  
WHERE 
    e.sts = 'ativo'  
GROUP BY 
    fp.nome
HAVING 
    COUNT(e.id_exame) > 0  
ORDER BY 
    valor_total_exames DESC;

CREATE VIEW vw_exames_por_tipo AS
SELECT
    tp_exame AS tipo_exame,
    COUNT(id_exame) AS total_exames,
    SUM(valor) AS valor_total_exames
FROM
    exames
WHERE
    sts = 'ativo' 
GROUP BY
    tp_exame;

CREATE OR REPLACE VIEW vw_resumo_prontuarios AS
SELECT 
    u_pac.nome_completo AS nome_paciente,
    u_med.nome_completo AS nome_medico,
    COUNT(p.id_prontuario) AS total_prontuarios,
    MAX(p.dt_atendimento) AS ultimo_atendimento
FROM prontuarios p
JOIN pacientes pac ON pac.id_paciente = p.id_paciente
JOIN medicos med ON med.id_medico = p.id_medico
JOIN usuarios u_pac ON u_pac.id_usuario = pac.id_usuario
JOIN usuarios u_med ON u_med.id_usuario = med.id_usuario
GROUP BY u_pac.nome_completo, u_med.nome_completo
ORDER BY total_prontuarios DESC;

CREATE OR REPLACE VIEW vw_exames_por_prontuario AS
SELECT 
    ep.id_prontuario,
    e.tp_exame,
    COUNT(e.id_exame) AS total_exames,
    MAX(ep.data_resultado) AS ultima_data_resultado
FROM exames_prontuarios ep
JOIN exames e ON e.id_exame = ep.id_exame
GROUP BY ep.id_prontuario, e.tp_exame
ORDER BY ultima_data_resultado DESC;

CREATE OR REPLACE VIEW vw_receitas_com_diagnostico AS
SELECT 
    p.diagnostico,
    COUNT(r.id_receita) AS total_receitas,
    MIN(r.dt_receita) AS primeira_receita,
    MAX(r.dt_receita) AS ultima_receita
FROM receitas_medicas r
JOIN prontuarios p ON p.id_prontuario = r.id_prontuario
GROUP BY p.diagnostico
ORDER BY total_receitas DESC;

