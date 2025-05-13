# ATUALIZA STATUS DO MÉDICO APÓS O DELETE  
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
# ATUALIZA STATUS DO PACIENTE APÓS O DELETE  
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
# ATUALIZA STATUS DO FUNCIONÁRIO APÓS O DELETE  
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
# TRIGGER PARA ATUALIZAR DATA DE ATUALIZAÇÃO DOS EXAMES  
DELIMITER //
CREATE TRIGGER atualiza_data_alteracao
BEFORE UPDATE ON exames
FOR EACH ROW
BEGIN
    SET NEW.data_alteracao = NOW();
END//
DELIMITER ;
#TRIGGER QUE IMPEDE A INSERÇÃO DE AGENDAMENTOS NO PASSADO
DELIMITER $$
CREATE TRIGGER prevent_past_appointments
BEFORE INSERT ON agendamentos
FOR EACH ROW
BEGIN
  IF NEW.dt_agendada < NOW() THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Não é possível agendar consultas no passado.';
  END IF;
END;

DELIMITER ;

#TRIGGER QUE VERIFICA SE A DATA DO EXAME É POSTERIOR À DO PRONTUÁRIO.
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
