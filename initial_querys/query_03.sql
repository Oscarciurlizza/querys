--Traerme soles de productos de nuestra marca en una columna y en otra columna, el resto de productos del pedido.
SELECT *
FROM SPEDIDO_HEADER
WHERE ROWNUM < 50;
SELECT *
FROM SPEDIDO_DETALLE
WHERE ROWNUM < 50;
SELECT *
FROM TABLAS
WHERE ROWNUM < 50
  AND CATEGORIA IN ('008');
SELECT fecha,
  sede,
  compañia,
  pedido,
  nvl(sum(soles_monteverde), 0) SOLES_MONTEVERDE,
  nvl(sum(soles_otros), 0) SOLES_OTROS
FROM (
    SELECT SPH.FECHA_PEDIDO FECHA,
      SPH.CODSEDE SEDE,
      SPD.COMPANIA_VENTA COMPAÑIA,
      SPD.NRO_PEDIDO PEDIDO,
      CASE
        WHEN SPD.COD_ITEM IN ('280001', '280002', '280003', '280005') THEN VENTA_NETA
      END AS SOLES_MONTEVERDE,
      CASE
        WHEN SPD.COD_ITEM NOT IN ('280001', '280002', '280003', '280005') THEN VENTA_NETA
      END AS SOLES_OTROS
    FROM SPEDIDO_HEADER SPH
      INNER JOIN SPEDIDO_DETALLE SPD ON SPD.COMPANIA_VENTA = SPH.COMPANIA_VENTA
      AND SPD.NRO_PEDIDO = SPH.NRO_PEDIDO
    WHERE SPH.FECHA_PEDIDO = '01-07-2022'
  )
GROUP BY FECHA,
  SEDE,
  COMPAÑIA,
  PEDIDO
HAVING nvl(SUM(SOLES_MONTEVERDE), 0) > 0
  AND nvl(SUM(SOLES_OTROS), 0) > 0;