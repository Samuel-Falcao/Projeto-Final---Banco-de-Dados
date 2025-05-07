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

-- Funcão para calcular valor da consulta com desconto
DELIMITER //

CREATE FUNCTION calcular_valor_com_desconto(valor DECIMAL(10,2), desconto_percentual INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE valor_final DECIMAL(10,2);
    SET valor_final = valor - (valor * desconto_percentual / 100);
    RETURN valor_final;
END;
//

DELIMITER ;
SELECT calcular_valor_com_desconto(300.00, 20); #Exemplo