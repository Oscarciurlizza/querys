--Me agrupa por ruta la cantidad de pedidos y el total en soles que tuvo.

SELECT DISTINCT compañia,
  almacen,
  sede,
  nvl(sum(total_pedidos), 0) TOTAL_PEDIDOS,
  nvl(sum(total_soles), 0) TOTAL_SOLES,
  ruta
FROM (
    SELECT TBC.DESC1 COMPAÑIA,
      TBA.DESC1 ALMACEN,
      TBR.DESCRUTA RUTA,
      CASE
        WHEN ALD.RUTAS IN ('08-69', 'BT', 'C6', '39-OV', '63', '68-98-AG') THEN ALD.CANT_PEDIDOS
      END TOTAL_PEDIDOS,
      CASE
        WHEN ALD.RUTAS IN ('08-69', 'BT', 'C6', '39-OV', '63', '68-98-AG') THEN ALD.MONTO_TOTAL
      END TOTAL_SOLES,
      (
        SELECT TBS.DESCSEDE
        FROM TB_SEDE TBS
        WHERE TBS.CODSEDE = ALD.CODSEDE
      ) SEDE
    FROM ALM_DISTRIBUCION_PACKING ALD
      INNER JOIN TABLAS TBC ON TBC.CATEGORIA = '001'
      AND TBC.LLAVE = ALD.EMPRESA
      INNER JOIN TABLAS TBA ON TBA.CATEGORIA = '002'
      AND TBA.LLAVE = ALD.ALMACEN
      INNER JOIN TB_RUTA TBR ON TBR.CODRUTA = ALD.RUTAS
    WHERE ALD.FECHA_REPARTO >= '01-01-2022'
      AND ALD.CODSEDE = '001'
  )
GROUP BY compañia,
  almacen,
  sede,
  ruta
HAVING nvl(sum(total_pedidos), 0) > 0;