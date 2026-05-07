SELECT meno,
UPPER(stredne_meno) AS stredne,
priezvisko,
EXTRACT(YEAR FROM datum_narodenia) AS vek
FROM bezec
WHERE stredne > 6 
ORDER BY id_krajina, priezvisko, stredne, meno DESC;


SELECT 
nazov AS pretek,
dlzka_v_metroch AS dlzka
FROM pretek
WHERE dlzka_v_metroch > 20000
ORDER BY dlzka DESC, nazov ASC;

SELECT
nazov AS pretek,
datum AS datum,
dlzka_v_metroch AS dlzka
FROM pretek
WHERE datum >= "2020-1-1"
ORDER BY datum ASC, dlzka_v_metroch DESC, nazov ASC;

SELECT
kr.nazov AS krajina,
COUNT(DISTINCT b.id_bezec) AS pocet_bezcov,
AVG(bp.cas_v_milisekundach)/1000.0 AS priemer,
COUNT(bp.id_pretek) AS pocet_pretekov
FROM krajina kr
JOIN bezec b ON kr.id_krajina = b.id_krajina
JOIN bezec_pretek bp ON b.id_bezec = bp.id_bezec
JOIN pretek pr ON bp.id_pretek = pr.id_pretek 
WHERE kr.kontinent = 'Europa' AND NOT pr.nazov = "Taliansky polmaraton"
GROUP BY kr.nazov
HAVING COUNT(DISTINCT b.id_bezec) >=2
ORDER BY priemer ASC, pocet_pretekov DESC, krajina ASC, pocet_bezcov ASC

SELECT
    kr.nazov AS krajina,
    COUNT(DISTINCT b.id_bezec) AS pocet_bezcov,
    AVG(bp.cas_v_milisekundach) / 1000.0 AS priemer,
    COUNT(bp.id_pretek) AS pocet_pretekov
FROM krajina kr
JOIN bezec b ON kr.id_krajina = b.id_krajina
JOIN bezec_pretek bp ON b.id_bezec = bp.id_bezec
JOIN pretek pr ON bp.id_pretek = pr.id_pretek 
WHERE kr.kontinent = 'Europa' 
  AND pr.nazov != 'Taliansky polmaraton'
GROUP BY kr.nazov
HAVING COUNT(DISTINCT b.id_bezec) >= 2
ORDER BY 
    priemer ASC, 
    pocet_pretekov DESC, 
    krajina ASC, 
    pocet_bezcov ASC;

SELECT
    b.meno || ' ' || b.priezvisko AS meno,
    ROUND(AVG(bp.cas_v_milisekundach)/1000.0, 2) AS cas,
    COUNT(bp.id_pretek) AS pocet
FROM bezec b
JOIN bezec_pretek bp ON b.id_bezec = bp.id_bezec
JOIN pretek p ON p.id_pretek = bp.id_pretek
WHERE p.dlzka_v_metroch > 42000
GROUP BY b.id_bezec, b.meno, b.priezvisko
HAVING COUNT(bp.id_pretek) >= 2
ORDER BY pocet DESC, cas ASC, meno ASC

SELECT 
    k.nazov AS stat,
    AVG(bp.cas_v_milisekundach) / 1000.0 AS priemer,
    COUNT(bp.id_pretek) AS pocet
FROM krajina k
JOIN bezec b ON k.id_krajina = b.id_krajina
JOIN bezec_pretek bp ON b.id_bezec = bp.id_bezec
JOIN pretek p ON bp.id_pretek = p.id_pretek
WHERE k.kontinent = 'Europa' 
  AND p.nazov != 'Maraton v Berline'
GROUP BY k.nazov
ORDER BY priemer ASC, stat ASC, pocet ASC;
