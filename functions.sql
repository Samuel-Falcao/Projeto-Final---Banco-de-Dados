-- FUNÇÃO PARA CONTAR AGENDAMENTOS COM BASE NO ID DO MÉDICO
DELIMITER $
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

SELECT contar_agendamentos_medico() AS total_agendamentos;