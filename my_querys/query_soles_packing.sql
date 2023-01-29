--FECHA - PLACA - S/.CONTADO - S/.CREDITO - S/.TOTAL - NRO_PACKING 
--Me agrupa los nros_packing y me arroba en dos columnas el total de documentos contado y credito.

SELECT fecha,
  placa,
  nvl(sum(contado), 0) contado,
  nvl(sum(credito), 0) credito,
  nvl(sum(total_pedidos), 0) total_pedidos,
  LISTAGG(DISTINCT nro_packing, '; ') WITHIN GROUP (
    ORDER BY nro_packing
  ) NRO_PACKING
FROM (
    SELECT GUIAS_HEADER.FECHA_ASIGNACION FECHA,
      GUIAS_HEADER.NUMERO_PLACA PLACA,
      CASE
        WHEN TBC.FLAG1 = 1 THEN GUIAS_HEADER.MONTO_NETO_GUIA
      END CONTADO,
      CASE
        WHEN TBC.FLAG1 = 0 THEN GUIAS_HEADER.MONTO_NETO_GUIA
      END CREDITO,
      GUIAS_HEADER.MONTO_NETO_GUIA MONTO_TOTAL,
      GUIAS_HEADER.NRO_ASIG_TRANSP NRO_PACKING,
      GUIAS_HEADER.MONTO_NETO_GUIA total_pedidos
    FROM GUIAS_HEADER
      INNER JOIN TABLAS TBC ON TBC.CATEGORIA = '008'
      AND TBC.LLAVE = GUIAS_HEADER.CONDICION_PAGO_2
    WHERE GUIAS_HEADER.FECHA_ASIGNACION = '01-08-2022'
      AND GUIAS_HEADER.NUMERO_PLACA = 'M6O-917'
      AND GUIAS_HEADER.COD_SEDE = '001'
  )
GROUP BY fecha,
  placa
HAVING nvl(sum(total_pedidos), 0) > 0;