# CADASTRA UM NOVO USUÁRIO PODENDO DEFINIR QUAL O TIPO DO USUÁRIO SENDO PACIENTE, FUNCIONÁRIO OU MÉDICO  
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

# INSERIR UM NOVO EXAME, COM PARÂMETROS PARA OS DADOS PRINCIPAIS  
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

# CANCELAR AGENDAMENTO
DELIMITER $$
CREATE PROCEDURE cancelar_agendamento(IN p_id_agendamento INT)
BEGIN
    UPDATE agendamentos
    SET sts = 'Cancelado'
    WHERE id_agendamento = p_id_agendamento;
END $$

DELIMITER ;

# UMA PROCEDURE QUE RECEBE UM DIAGNÓSTICO E RETORNA AS RECEITAS RELACIONADAS A ELE.
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
-- EXEMPLO DE COMO CHAMAR: "CALL sp_receitas_por_diagnostico('asma');"
