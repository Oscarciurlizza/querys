--Premios a vendedores de acuerdo a la compra de cierto producto.
DECLARE CANT NUMBER =: 0 BEGIN FOR CUR IN (
    SELECT compañia,
      pedido,
      vendedor,
      nvl(sum(total_promo), 0) TOTAL_PROMO,
      sede,
      'PRODET22' CONDICION
    FROM (
        SELECT SPEDIDO_HEADER.COMPANIA_VENTA COMPAÑIA,
          SPEDIDO_HEADER.NRO_PEDIDO PEDIDO,
          SPEDIDO_HEADER.COD_VENDEDOR VENDEDOR,
          CASE
            WHEN COD_ITEM IN ('530812', '703012', '530402', '860117') THEN VALOR_VENTA
          END TOTAL_PROMO,
          (
            SELECT TBS.descsede
            FROM TB_SEDE TBS
            WHERE TBS.CODSEDE = SPEDIDO_HEADER.CODSEDE
          ) SEDE
        FROM SPEDIDO_HEADER
          INNER JOIN SPEDIDO_DETALLE ON SPEDIDO_DETALLE.COMPANIA_VENTA = SPEDIDO_HEADER.COMPANIA_VENTA
          AND SPEDIDO_DETALLE.NRO_PEDIDO = SPEDIDO_HEADER.NRO_PEDIDO
          AND SPEDIDO_HEADER.FECHA_PEDIDO >= '01-07-2022'
          AND SPEDIDO_HEADER.CODSEDE = '001'
      )
    GROUP BY compañia,
      pedido,
      vendedor,
      sede
    HAVING nvl(sum(total_promo), 0) > 50;
) LOOP
UPDATE TABLAS
SET RELLENO2 = CUR.CONDICION
WHERE CATEGORIA = '30'
  AND LLAVE = CUR.VENDEDOR;
CANT := CANT + 1;
END LOOP;
DBMS_OUTPUT.PUT_LINE (CANT);
END;