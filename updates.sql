UPDATE usuarios
SET 
    data_nascimento = CASE
        WHEN id_usuario = 1 THEN '1990-08-05'  -- Ajuste para 35 anos
        WHEN id_usuario = 19 THEN '1972-11-05'  -- Ajuste para 41 anos
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