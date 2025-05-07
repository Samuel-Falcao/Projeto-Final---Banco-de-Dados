-- FUNÇÃO PARA CONTAR AGENDAMENTOS COM BASE NO ID DO MÉDICO
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
# Exemplo de uso:
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
END//
DELIMITER ;
#Exemplo de uso:
SELECT calcular_valor_com_desconto(300.00, 20); 

-- Função para buscar nome do usuario pelo id 
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
#Exemplo de uso:
SELECT buscar_nome_usuario(1) AS nome_usuario;