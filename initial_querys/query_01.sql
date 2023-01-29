--Unir tablas (TABLAS - SPEDIDO_HEADER) para poder traerme descripciones.
--compania - nro_pedido - cod_vendedor - desc_vendedor - condicion_pago - desc_pago
SELECT *
FROM SPEDIDO_HEADER
WHERE ROWNUM < 50;
SELECT *
FROM TABLAS
WHERE CATEGORIA = '001';
--EMPRESAS
SELECT *
FROM TABLAS
WHERE CATEGORIA = '030';
--VENDEDORES
SELECT *
FROM TABLAS
WHERE CATEGORIA = '008';
--CONDICIONES_PAGO
SELECT COMP.DESC1 AS DESC_EMPRESA,
  PH.NRO_PEDIDO AS NUM_PEDIDO,
  VEND.DESC1 AS VENDEDOR,
  COND.DESC1 AS DESC_CONDICION
FROM SPEDIDO_HEADER PH
  INNER JOIN TABLAS COMP ON COMP.CATEGORIA = '001'
  AND COMP.LLAVE = PH.COMPANIA_VENTA
  INNER JOIN TABLAS VEND ON VEND.CATEGORIA = '030'
  AND VEND.LLAVE = PH.COD_VENDEDOR
  INNER join TABLAS COND ON COND.CATEGORIA = '008'
  AND COND.LLAVE = PH.CONDICION_PAGO
WHERE ROWNUM < 2;