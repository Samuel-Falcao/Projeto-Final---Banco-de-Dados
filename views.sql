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

#VIEW DE NÚMERO DE CONSULTAS POR MÉDICO
CREATE VIEW vw_consultas_por_medico AS
SELECT id_medico, COUNT(*) AS total_consultas
FROM agendamentos
GROUP BY id_medico;

#VIEWS DE AGENDAMENTOS FUTUROS
CREATE VIEW vw_agendamentos_futuros AS
SELECT 
    a.id_agendamento,
    a.dt_agendada,
    a.sts,
    a.descricao,
    u.nome_completo AS nome_paciente,
    um.nome_completo AS nome_medico,
    e.nome AS nome_exame,
    c.nome AS nome_convenio,
    pg.nome AS tipo_pagamento
FROM agendamentos a
JOIN pacientes p ON a.id_paciente = p.id_paciente
JOIN usuarios u ON p.id_usuario = u.id_usuario
JOIN medicos m ON a.id_medico = m.id_medico
JOIN usuarios um ON m.id_usuario = um.id_usuario
JOIN exames e ON a.id_exames = e.id_exame
JOIN convenios c ON a.id_convenio = c.id_convenio
JOIN formas_de_pagamento pg ON a.id_pagamento = pg.id_pagamento
WHERE a.dt_agendada > NOW();

#VIEW QUE ORDENA OS AGENDAMENTOS DOS MAIS ANTIGOS AOS MAIS RECENTES
CREATE VIEW vw_agendamentos_ordenados AS
SELECT 
    id_agendamento,
    descricao,
    dt_agendada,
    sts,
    id_paciente,
    id_medico,
    id_pagamento,
    id_convenio,
    id_exames
FROM agendamentos
ORDER BY dt_agendada ASC;