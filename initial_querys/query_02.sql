--Unir tablas (SPEDIDO_HEADER - TB_SEDE - TB_RUTA - TB_CANAL - TABLAS - CLIENTE)
--compania - sede - ruta - nro_pedido - cod_vendedor - desc_vendedor - canal - desc_cliente - direccion - condicion
SELECT *
FROM SPEDIDO_HEADER
WHERE ROWNUM < 50;
SELECT *
FROM TB_SEDE
WHERE ROWNUM < 50;
SELECT *
FROM TB_RUTA
WHERE ROWNUM < 50;
SELECT *
FROM TB_CANAL
WHERE ROWNUM < 50;
SELECT *
FROM TABLAS
WHERE ROWNUM < 50
  AND CATEGORIA IN ('001', '030');
SELECT *
FROM CLIENTE
WHERE ROWNUM < 50;
SELECT PH.COMPANIA_VENTA AS COD_COMPANIA,
  COMP.DESC1 AS DESC_EMPRESA,
  CD.DESCSEDE AS DESC_SEDE,
  RT.DESCRUTA AS DESC_RUTA,
  PH.NRO_PEDIDO AS NUM_PEDIDO,
  PH.COD_VENDEDOR AS COD_VENDEDOR,
  VEND.DESC1 AS VENDEDOR,
  CN.DESCCANAL AS CANAL,
  CLI.DESC_CLIENTE AS CLIENTE,
  CLI.DIRECCION_CLIENTE AS DIRECCION,
  PH.CONDICION_PAGO AS COD_CONDICION,
  COND.DESC1 AS DESC_CONDICION
FROM SPEDIDO_HEADER PH
  INNER JOIN TABLAS COMP ON COMP.CATEGORIA = '001'
  AND COMP.LLAVE = PH.COMPANIA_VENTA
  INNER JOIN TB_SEDE CD ON CD.CODSEDE = PH.CODSEDE
  INNER JOIN TB_RUTA RT ON RT.CODRUTA = PH.RUTA_DESPACHO
  INNER JOIN TABLAS VEND ON VEND.CATEGORIA = '030'
  AND VEND.LLAVE = PH.COD_VENDEDOR
  INNER JOIN TB_CANAL CN ON CN.CODCANAL = PH.CODCANAL
  INNER JOIN CLIENTE CLI ON CLI.COD_CLIENTE = PH.COD_CLIENTE
  INNER JOIN TABLAS COND ON COND.CATEGORIA = '008'
  AND COND.LLAVE = PH.CONDICION_PAGO
WHERE ROWNUM < 50
  AND PH.FECHA_PEDIDO = '01-07-2022'
  AND PH.CODSEDE = '001'