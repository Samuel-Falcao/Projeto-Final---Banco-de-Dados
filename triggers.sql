DELIMITER $$
CREATE TRIGGER t_finaliza_agendamento
AFTER INSERT ON prontuarios
FOR EACH ROW
BEGIN
	UPDATE agendamentos
	SET sts = 'Concluído'
	WHERE id_agendamento = NEW.id_agendamento;
END $$
DELIMITER ;
