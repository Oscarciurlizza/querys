--Me agrupa por canal (MAYORISTA) su venta en soles en un rango de fechas.
SELECT DISTINCT compañia,
  vendedor,
  nvl(sum(total_soles), 0) total_soles,
  sede,
  'MAYORISTA' CANAL
FROM (
    SELECT TBC.DESC1 COMPAÑIA,
      TBV.DESC1 VENDEDOR,
      CASE
        WHEN SPD.CODCANAL = '8' THEN DCC.MDCC_MONTO
      END TOTAL_SOLES,
      (
        SELECT TBS.DESCSEDE
        FROM TB_SEDE TBS
        WHERE TBS.CODSEDE = SPD.CODSEDE
      ) SEDE
    FROM DOCUMENTO_CXC DCC
      INNER JOIN SPEDIDO_HEADER SPD ON SPD.NRO_PEDIDO = DCC.NDCC_PEDIDOOIH
      INNER JOIN TABLAS TBC ON TBC.CATEGORIA = '001'
      AND TBC.LLAVE = DCC.CDCC_COMPANIA
      INNER JOIN TABLAS TBV ON TBV.CATEGORIA = '030'
      AND TBV.LLAVE = SPD.COD_VENDEDOR
    WHERE DCC.FDCC_EMISION BETWEEN '01-07-2022' AND '31-07-2022'
      AND SPD.CODSEDE = '001'
  )
GROUP BY compañia,
  vendedor,
  sede
HAVING nvl(sum(total_soles), 0) > 0;