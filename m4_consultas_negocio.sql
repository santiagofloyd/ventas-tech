-- CONSULTAS REUNIÓN DE DIRECTORIO DÍA LUNES 05/10/2026 --

-- CONSULTA 1: Resumen ejecutivo mensual: --

SELECT 
    MONTH(fecha_venta) AS mes,
    COUNT(id_venta) AS cantidad_ventas,
    SUM(cantidad * precio_unitario) AS total_ventas,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;



-- CONSULTA 2: Ranking de productos: --

Select
id_producto,
sum (cantidad) as unidades_vendidas,
sum (cantidad*precio_unitario) as total_facturado
from ventas
group by id_producto
order by total_facturado desc;

-- CONSULTA 3: Clientes recurrentes: --

SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_pedidos DESC;

-- CONSULTA 4: Meses por encima/ debajo del promedio: --

WITH FacturacionMensual AS (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
),
PromedioGeneral AS (
    SELECT AVG(total_facturado) AS promedio_mensual
    FROM FacturacionMensual
)
SELECT 
    f.mes,
    f.total_facturado,
    CASE 
        WHEN f.total_facturado >= p.promedio_mensual THEN 'Por encima'
        ELSE 'Por debajo'
    END AS estado_promedio
FROM FacturacionMensual f
CROSS JOIN PromedioGeneral p
ORDER BY f.mes;

-- PUNTOS DESTACADOS: Hallasgos de este este análisis: --
-- 1) El producto 2 es el de más cantidades vendidas, pero uno de los menores en facturación total.
-- 2) El producto 1 es el de mayor facturación, básicamente porque tiene uno de los precios unitarios más altos.
-- 3) El cliente 1 es el que más ventas tuvo, porque compró dos unidades del producto 1, el cual es uno de los más caros.

