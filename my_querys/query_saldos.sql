--Me agrupa por documento en dos columnas el total en soles de productos internos y procutos externos.
SELECT empresa,
  tipo_doc,
  serie,
  preimpreso,
  fecha_emision,
  nvl(sum(total_art), 0) total_art,
  nvl(sum(total_art_otrs), 0) total_art_otrs,
  saldo,
  sede
from (
    SELECT DOCUMENTO_CXC.CDCC_COMPANIA EMPRESA,
      DOCUMENTO_CXC.CDCC_TIPODOC TIPO_DOC,
      DOCUMENTO_CXC.NDCC_SERIE SERIE,
      DOCUMENTO_CXC.NDCC_PREIMPRESO PREIMPRESO,
      FDCC_EMISION FECHA_EMISION,
      case
        when cdemo_itemart in ('280001', '280002', '280003', '280005') then MDEMO_TOTALBASE
      end TOTAL_art,
      case
        when cdemo_itemart not in ('280001', '280002', '280003', '280005') then MDEMO_TOTALBASE
      end TOTAL_art_otrs,
      MDCC_SALDO SALDO,
      (
        SELECT TS.descsede
        from TB_SEDE TS
        where TS.codsede = DOCUMENTO_CXC.codsede
      ) SEDE
    FROM sysadm.DOCUMENTO_CXC
      INNER JOIN sysadm.DOCCXC_MOTIVO on DOCUMENTO_CXC.CDCC_COMPANIA = DOCCXC_MOTIVO.CDEMO_COMPANIADCC
      and DOCUMENTO_CXC.CDCC_TIPODOC = DOCCXC_MOTIVO.CDEMO_TIPODOCDCC
      and DOCUMENTO_CXC.CDCC_SECUENCIA = DOCCXC_MOTIVO.CDEMO_SECUENCIADCC
      and DOCUMENTO_CXC.FDCC_EMISION >= '01-09-2022'
      and mdcc_saldo > 0
  )
GROUP BY empresa,
  tipo_doc,
  serie,
  preimpreso,
  fecha_emision,
  saldo,
  sede
HAVING nvl(sum(total_art), 0) > 0