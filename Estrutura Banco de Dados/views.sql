# VERIFICA OS USUÁRIOS MAIORES DE IDADE  
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
# VERIFICA OS USUÁRIOS MENORES DE IDADE (MESMA ESTRUTURA DA ANTERIOR, ALTERANDO APENAS O OPERADOR LÓGICO PARA QUESTÃO DE CONTROLE INTERNO)
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
# EXIBE O TOTAL DE AGENDAMENTOS POR MÉDICOS COM O STATUS DE USUÁRIO 'ATIVO', RETORNANDO O ID DO MÉDICO, SEU NOME, E O NÚMERO TOTAL DE AGENDAMENTOS FEITOS POR ELE 
# FILTRANDO APENAS OS MÉDICOS QUE TÊM MAIS DE 3 AGENDAMENTOS E ORDENA OS RESULTADOS DE FORMA DECRESCENTE COM BASE NO NÚMERO DE AGENDAMENTOS  
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

# NÚMERO DE CONSULTAS POR MÉDICO
CREATE VIEW vw_consultas_por_medico AS
SELECT id_medico, COUNT(*) AS total_consultas
FROM agendamentos
GROUP BY id_medico;

# AGENDAMENTOS FUTUROS
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

# ORDENA OS AGENDAMENTOS DOS MAIS ANTIGOS AOS MAIS RECENTES
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

# TRARÁ O NÚMERO TOTAL DE EXAMES REALIZADOS POR FORMA DE PAGAMENTO E O VALOR TOTAL GASTO  
CREATE OR REPLACE VIEW vw_exames_por_forma_pagamento AS 
SELECT 
    fp.nome AS forma_pagamento, 
    COUNT(a.id_exames) AS total_exames_realizados, 
    SUM(e.valor) AS valor_total_exames
FROM 
    agendamentos a
JOIN 
    formas_de_pagamento fp ON a.id_pagamento = fp.id_pagamento
JOIN 
    exames e ON a.id_exames = e.id_exame
WHERE 
    e.sts = 'ativo'  
GROUP BY 
    fp.nome
HAVING 
    COUNT(a.id_exames) > 0  
ORDER BY 
    valor_total_exames DESC;
    
# AGRUPA OS EXAMES PELO TIPO (TP_EXAME) E MOSTRA A QUANTIDADE TOTAL E O VALOR TOTAL DE EXAMES REALIZADOS POR CADA TIPO   
CREATE VIEW exames_por_tipo AS
SELECT
    tp_exame AS tipo_exame,
    COUNT(id_exame) AS total_exames,
    SUM(valor) AS valor_total_exames
FROM
    exames
WHERE
    sts = 'ativo' 
GROUP BY
    tp_exame;

# MOSTRAR O TOTAL DE PRONTUÁRIOS POR MÉDICO E PACIENTE, AGRUPANDO OS ATENDIMENTOS.
CREATE OR REPLACE VIEW vw_resumo_prontuarios AS
SELECT 
    u_pac.nome_completo AS nome_paciente,
    u_med.nome_completo AS nome_medico,
    COUNT(p.id_prontuario) AS total_prontuarios,
    MAX(p.dt_atendimento) AS ultimo_atendimento
FROM prontuarios p
JOIN pacientes pac ON pac.id_paciente = p.id_paciente
JOIN medicos med ON med.id_medico = p.id_medico
JOIN usuarios u_pac ON u_pac.id_usuario = pac.id_usuario
JOIN usuarios u_med ON u_med.id_usuario = med.id_usuario
GROUP BY u_pac.nome_completo, u_med.nome_completo
ORDER BY total_prontuarios DESC;

# MOSTRAR A QUANTIDADE DE EXAMES POR PRONTUÁRIO, AGRUPADO PELO TIPO DE EXAME E ORDENADO PELA DATA MAIS RECENTE.
CREATE OR REPLACE VIEW vw_exames_por_prontuario AS
SELECT 
    ep.id_prontuario,
    e.tp_exame,
    COUNT(e.id_exame) AS total_exames,
    MAX(ep.data_resultado) AS ultima_data_resultado
FROM exames_prontuarios ep
JOIN exames e ON e.id_exame = ep.id_exame
GROUP BY ep.id_prontuario, e.tp_exame
ORDER BY ultima_data_resultado DESC;


# MOSTRAR DIAGNÓSTICOS QUE MAIS GERARAM RECEITAS, AGRUPADOS E ORDENADOS PELA QUANTIDADE DE RECEITAS.
CREATE OR REPLACE VIEW vw_receitas_com_diagnostico AS
SELECT 
    p.diagnostico,
    COUNT(r.id_receita) AS total_receitas,
    MIN(r.dt_receita) AS primeira_receita,
    MAX(r.dt_receita) AS ultima_receita
FROM receitas_medicas r
JOIN prontuarios p ON p.id_prontuario = r.id_prontuario
GROUP BY p.diagnostico
ORDER BY total_receitas DESC;
