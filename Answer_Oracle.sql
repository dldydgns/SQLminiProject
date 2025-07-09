-- 1. 상반기 고용인원과 하반기 고용 인원을 각각 출력해라
-- 상반기 고용인원
SELECT *
FROM emp
WHERE EXTRACT(MONTH FROM hiredate) < 7;

-- 하반기 고용인원
SELECT *
FROM emp
WHERE EXTRACT(MONTH FROM hiredate) >= 7;


-- 2. 커미션 비율이 월급의 20% 초과인 직원의 이름, 직업, 급여, 커미션 비율을 출력하라
SELECT 
  ename AS 이름,
  empno AS 사번,
  sal AS "세전 급여",
  (sal - sal * 0.2) AS "세후 급여"
FROM emp
WHERE (sal - sal * 0.2) >= 2000
ORDER BY sal ASC;


-- 3. 세금이 20%일 때, 세후 월급여가 2000이 넘는 사람의 이름과 사번, 세후 급여를 오름차순으로 출력
SELECT
  ename AS 이름,
  job AS 직업,
  sal AS 급여,
  comm / sal AS "커미션 비율"
FROM emp
WHERE comm IS NOT NULL
  AND comm / sal > 0.2;


-- 4. 과세표준 구간이 8800만원 ~ 1억5000만원인 직원의 이름, 연봉, 초과금액, 산출세액을 구해라
SELECT
  ename AS 이름,
  sal * 12 + NVL(comm, 0) AS 연봉,
  (sal * 12 + NVL(comm, 0) - 8800) AS 초과금액,
  (sal * 12 + NVL(comm, 0) - 8800) * 0.35 + 1536 AS 산출세액
FROM emp
WHERE sal * 12 + NVL(comm, 0) BETWEEN 8800 AND 15000;

