# DELETA O FUNCIONÁRIO VINCULADO AO USUÁRIO DE ID 85
DELETE FROM funcionarios
WHERE id_usuario = 85;
# DELETA A RECEITA MÉDICA COM ID 42
DELETE FROM receitas_medicas
WHERE id_receita = 42;
# DELETA OS EXAMES ASSOCIADOS AO PRONTUÁRIO DE ID 12
DELETE FROM exames_prontuarios
WHERE id_prontuario = 12;
# DELETA O ENDEREÇO VINCULADO AO USUÁRIO DE ID 91
DELETE FROM enderecos
WHERE id_usuario = 91;
# DELETA O PRONTUÁRIO COM ID 50
DELETE FROM prontuarios
WHERE id_prontuario = 50;
# DELETA OS ENDEREÇOS COM ID_ENDERECO 79 E 80
DELETE FROM enderecos
WHERE id_endereco IN (79, 80);
# REMOVE A RECEITA MÉDICA COM ID 40 (A MAIS ANTIGA)
DELETE FROM receitas_medicas
WHERE id_receita = 40;
