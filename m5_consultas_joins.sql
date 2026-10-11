-- =====================================================================
-- PROYECTO RETAILPRO - MÓDULO 5: CONSULTAS CON JOINs Y UNIONs
-- Autor: Santiago Martin
-- =====================================================================

-- ---------------------------------------------------------------------
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Combina ventas con clientes y productos para obtener una vista enriquecida.
-- ---------------------------------------------------------------------
SELECT 
    v.fecha_venta AS fecha,
    c.Id_cliente AS identificacion_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS ciudad_cliente,               
    p.nombre_producto AS descripcion_producto,
    cat.nombre_categoria AS categoria_producto, 
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM 
    ventas v
INNER JOIN 
    clientes c ON v.id_cliente = c.Id_cliente
INNER JOIN 
    productos p ON v.id_producto = p.id_producto
INNER JOIN 
    categorias cat ON p.id_categoria = cat.id_categorias;


-- ---------------------------------------------------------------------
-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Área de CRM: Identifica clientes registrados que nunca han comprado.
-- ---------------------------------------------------------------------

SELECT 
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM 
    clientes c
LEFT JOIN 
    ventas v ON c.Id_cliente = v.id_cliente
WHERE 
    v.id_venta IS NULL;

    -- ---------------------------------------------------------------------
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Área de Producto: Identifica artículos del catálogo sin movimiento.
-- ---------------------------------------------------------------------

SELECT 
    p.nombre_producto AS nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM 
    productos p
INNER JOIN 
    categorias cat ON p.id_categoria = cat.id_categorias
LEFT JOIN 
    ventas v ON p.id_producto = v.id_producto
WHERE 
    v.id_venta IS NULL;

-- ---------------------------------------------------------------------
-- Consulta 4 — Consolidado por canal (UNION ALL)
-- Combina transacciones de diferentes canales usando literales de texto.
-- ---------------------------------------------------------------------

SELECT 
    canal, 
    SUM(total) AS total_canal
FROM (
    -- Primer subconjunto: Canal Online (Ventas con ID del 1 al 5)
    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total, 
        'Online' AS canal
    FROM 
        ventas 
    WHERE 
        id_venta <= 5
    
    UNION ALL
    
    -- Segundo subconjunto: Canal Presencial (Ventas con ID mayores a 5)
    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total, 
        'Presencial' AS canal
    FROM 
        ventas 
    WHERE 
        id_venta > 5
) AS consolidado
GROUP BY 
    canal;