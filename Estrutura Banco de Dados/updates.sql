# ATUALIZA DATA DE NASCIMENTO, STATUS, TELEFONE E E-MAIL DE USUÁRIOS ESPECÍFICOS 
UPDATE usuarios
SET 
    data_nascimento = CASE
        WHEN id_usuario = 1 THEN '1990-08-05'  
        WHEN id_usuario = 19 THEN '1972-11-05'  
        ELSE data_nascimento
    END,
    sts_usuario = CASE 
        WHEN id_usuario IN (11, 21, 57, 66) THEN 'Inativo'
        ELSE sts_usuario
    END,
    telefone = CASE
        WHEN id_usuario = 46 THEN '21991234567'
        ELSE telefone
    END,
    email = CASE
        WHEN id_usuario = 59 THEN 'ThiagoRibeiroCavalcanti@rhyta.com'
        ELSE email
    END
WHERE id_usuario IN (1, 19, 11, 21, 46, 57, 59, 66);
# ATUALIZA STATUS PARA 'ATIVO' DE EXAMES ESPECÍFICOS POR ID  
UPDATE exames
SET sts = 'ativo'
WHERE id_exame IN (7,10,33);

UPDATE exames
SET sts = 'ativo'
WHERE id_exame IN (
  SELECT id_exame
  FROM exames
  WHERE valor > 200 AND tp_exame = 'imagem'
);
# ATUALIZA STATUS PARA 'CONCLUÍDO' DO AGENDAMENTO COM ID 1 
UPDATE agendamentos
SET sts = 'Concluído'
WHERE id_agendamento = 1;
# ATUALIZA DATA AGENDADA NO AGENDAMENTO COM ID 5  
UPDATE agendamentos
SET dt_agendada = '2025-06-30 08:00:00'
WHERE id_agendamento = 5;
# ATUALIZA STATUS PARA 'REMARCADO' NO AGENDAMENTO COM ID 5 
UPDATE agendamentos
SET sts = 'Remarcado'
WHERE id_agendamento = 5;
# ATUALIZA A CONDUTA DE UM PACIENTE NO PRONTUARIO APÓS UM ERRO DE RELATAÇÃO DO PACIÊNTE
UPDATE prontuarios
SET conduta = 'Paciente orientado a manter repouso e hidratação'
WHERE id_prontuario = 5;