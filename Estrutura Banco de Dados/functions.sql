# FUNÇÃO PARA CONTAR AGENDAMENTOS COM BASE NO ID DO MÉDICO
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
# EXEMPLO DE USO:
SELECT contar_agendamentos_medico() AS total_agendamentos;

# FUNÇÃO PARA CALCULAR VALOR DA CONSULTA COM DESCONTO 
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
# EXEMPLO DE USO:
SELECT calcular_valor_com_desconto(300.00, 20); 

# BUSCAR NOME DO USUÁRIO PELO ID   
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
# EXEMPLO DE USO:
SELECT buscar_nome_usuario(1) AS nome_usuario;

#RETORNA QUANTOS EXAMES ESTÃO ASSOCIADOS A UM DETERMINADO PRONTUÁRIO.
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
