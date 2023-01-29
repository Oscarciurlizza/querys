--Me agrupa por la placa del vehiculo la cantidad de packings que cargo y el total en soles de un producto.
SELECT DISTINCT sede,
  TO_CHAR(fecha, 'DD/MM/YYYY') FECHA,
  nvl(count(DISTINCT total_packings), 0) total_packings,
  nvl(sum(soles_articulo), 0) soles_articulo,
  movil
FROM (
    SELECT GUIAS_HEADER.FECHA_ASIGNACION FECHA,
      CASE
        WHEN GUIAS_HEADER.FLAG_LIQUIDADA = 1 THEN NRO_ASIG_TRANSP
      END TOTAL_PACKINGS,
      CASE
        WHEN GUIAS_DETALLE.COD_ITEM_2 = '000000' THEN GUIAS_DETALLE.VALOR_NETO
      END SOLES_ARTICULO,
      GUIAS_HEADER.NUMERO_PLACA MOVIL,
      (
        SELECT TBS.DESCSEDE
        FROM TB_SEDE TBS
        WHERE TBS.CODSEDE = GUIAS_HEADER.COD_SEDE
      ) SEDE
    FROM GUIAS_HEADER
      INNER JOIN GUIAS_DETALLE ON GUIAS_DETALLE.COMPANIA_VENTA_3 = GUIAS_HEADER.COMPANIA_VENTA_3
      AND GUIAS_DETALLE.NRO_INTERNO_GUIA = GUIAS_HEADER.NRO_INTERNO_GUIA
    WHERE GUIAS_HEADER.FECHA_ASIGNACION = '01-07-2022'
      AND GUIAS_HEADER.COD_SEDE = '001'
  )
GROUP BY sede,
  fecha,
  movil
HAVING nvl(count(total_packings), 0) > 0
  AND nvl(sum(soles_articulo), 0) > 0;