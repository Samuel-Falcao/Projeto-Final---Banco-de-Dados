# Apaga os endereços referente aos 2 ultimos pacientes 
DELETE FROM enderecos
WHERE id_endereco IN (79, 80);
# Apaga os pacientes da tabela pacientes dos 2 ultimos pacientes
DELETE FROM pacientes 
WHERE id_paciente IN (39, 40);
# Apaga de vez o usuario após ser deletado anteriormente os dados de relacionamento apagando agora de fato os 2 ultimos usuários do tipo paciente
DELETE FROM usuarios
WHERE id_usuario IN (79, 80) AND tipo_usuario = 'Paciente';