# Atualiza status do médico após o delete
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
# Atualiza status do paciente após o delete
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
# Atualiza status do funcionário após o delete
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
