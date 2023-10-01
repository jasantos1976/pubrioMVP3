/*
SCRIPT CRIADO PARA MONTAGEM DO DICIONÁRIO DE DADOS
*/

-- Obter informações dos campos das tabelas
SELECT 
    t.TABLE_NAME AS [Nome da Tabela],
    c.COLUMN_NAME AS [Nome da Coluna],
    c.DATA_TYPE AS [Tipo de Dado],
	CASE WHEN c.IS_NULLABLE = 'YES' THEN 'S' ELSE 'N' END AS [Permite Nulo],
    c.CHARACTER_MAXIMUM_LENGTH AS [Tamanho Máximo],
	c.COLUMN_DEFAULT,
	'' AS [Descrição]
FROM 
    INFORMATION_SCHEMA.TABLES AS t
INNER JOIN 
    INFORMATION_SCHEMA.COLUMNS AS c ON t.TABLE_NAME = c.TABLE_NAME
WHERE 
    t.TABLE_TYPE = 'BASE TABLE' 

-- *********************************************************************************************************

-- Obter informação sobre as chaves estrangeiras [Contraints e UniqueConstraints]
SELECT 
    ku.TABLE_NAME AS Tabela,
    ku.COLUMN_NAME AS [FK Nome da Coluna],
    kufk.TABLE_NAME AS [Tabela Referenciada],
    kufk.COLUMN_NAME AS [Coluna Referenciada]

	, ku.CONSTRAINT_NAME as [Nome da Constraint]
	, kufk.CONSTRAINT_NAME as [Nome da Unique Constraint]
FROM 
    INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS rc
INNER JOIN 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS ku ON rc.CONSTRAINT_NAME = ku.CONSTRAINT_NAME
INNER JOIN 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kufk ON rc.UNIQUE_CONSTRAINT_NAME = kufk.CONSTRAINT_NAME
ORDER BY KU.TABLE_NAME


--**********************************************************************************************************

	-- Obter informações sobre índices, incluindo chaves
SELECT 
    c.name AS [Nome da Coluna],
    i.name AS [Nome do Índice],
    i.type_desc AS [Tipo do Índice],
	CASE
		WHEN i.is_primary_key = 0 THEN 'N' ELSE 'S' END AS [É Chave Primária?],
    CASE
		WHEN i.is_unique = 0 THEN 'N' ELSE 'S' END AS [É Unique?],
	CASE
		WHEN i.is_unique_constraint = 0 THEN 'N' ELSE 'S' END AS [É UniqueConstraint],
    t.name AS TableName
FROM 
    sys.indexes i
INNER JOIN 
    sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN 
    sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
INNER JOIN 
    sys.tables t ON i.object_id = t.object_id
WHERE 
    t.type = 'U' -- U para tabelas de usuário
ORDER BY 
    t.name, i.name, i.index_id;
