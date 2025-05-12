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
# REGISTRAR DATA E HORA DE UM AGENDAMENTO
DELIMITER $$

CREATE TRIGGER trg_update_data_alteracao
BEFORE UPDATE ON agendamentos
FOR EACH ROW
BEGIN
    SET NEW.data_alteracao = CURRENT_TIMESTAMP;
END $$

DELIMITER ;