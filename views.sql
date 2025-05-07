# Verifica os usuarios maiores de idade
CREATE VIEW v_usuarios_maiores_18 AS
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
# Verifica os usuarios menores de idade ( Mesma estrutura da anterior alterando apenas o operador lógico para questão de controle interno )
CREATE VIEW v_usuarios_menores_18 AS
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
# Exibe o total de agendamentos por médicos com o status de usuário 'Ativo' retorna o ID do médico, seu nome, e o número total de agendamentos feitos por ele
# filtrando apenas os médicos que tem mais de 3 agendamentos e ordena os resultados de forma decrescente com base no número de agendamentos.
DELIMITER $$
CREATE VIEW agendamentos_por_medico AS
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
