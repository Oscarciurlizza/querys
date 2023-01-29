--Me agrupa por nro_packing la cantidad de pedidos que contienen.
SELECT sede,
  TO_CHAR(fecha, 'DD/MM/YYYY') FECHA,
  nro_packing,
  nvl(COUNT(cantidad_pedidos), 0) CANTIDAD_PEDIDOS
FROM (
    SELECT GUIAS_HEADER.NRO_ASIG_TRANSP NRO_PACKING,
      GUIAS_HEADER.FECHA_ASIGNACION FECHA,
      GUIAS_HEADER.NRO_PEDIDO CANTIDAD_PEDIDOS,
      (
        SELECT TBS.DESCSEDE
        FROM TB_SEDE TBS
        WHERE TBS.CODSEDE = GUIAS_HEADER.COD_SEDE
      ) SEDE
    FROM GUIAS_HEADER
    WHERE GUIAS_HEADER.FECHA_ASIGNACION = '01-07-2022'
      AND GUIAS_HEADER.COD_SEDE = '001'
  )
GROUP BY sede,
  fecha,
  nro_packing
HAVING nvl(count(cantidad_pedidos), 0) > 0;