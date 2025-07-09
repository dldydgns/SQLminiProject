# SQLminiProject
## 목차
[1. 팀원 소개](#👨‍💻-Team)
[2. 개발 기간](#📊-학습목적)
[3. 문제 해결](#🔧-트러블-슈팅)

## 👨‍💻Team
|<img src="https://avatars.githubusercontent.com/u/56614731?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/117507439?v=4" width="100" height="100"/>|<img src="https://github.com/user-attachments/assets/c2190400-6734-41d4-bdd9-377c569489a8" width="100" height="100"/>|
|:-:|:-:|:-:|
|[이용훈](https://github.com/dldydgns)|[김문석](https://github.com/moonstone0514)|[황지환](https://github.com/jihwan77)|<br/>[@](https://github.com/ddd)|
<br></br>


## 📊 학습목적
Oracle과 mysql의 문법 비교를 위한 프로젝트 입니다.
예제를 만들고 서로 풀어보며 학습하였습니다.
<br>
<br></br>


### 📅 상반기 고용인원과 하반기 고용 인원을 각각 출력해라


```sql
-- @MySQL
-- 상반기 입사자
SELECT *
FROM emp
WHERE MONTH(hiredate) < 7;

-- 하반기 입사자
SELECT *
FROM emp
WHERE MONTH(hiredate) >= 7;

-- @ORACLE
-- 상반기 입사자
SELECT *
FROM emp
WHERE EXTRACT(MONTH FROM hiredate) < 7;

-- 하반기 입사자
SELECT *
FROM emp
WHERE EXTRACT(MONTH FROM hiredate) >= 7;
```
![결과](https://github.com/user-attachments/assets/1d4ca370-1fa7-4244-af21-d70661397d45)
<br></br>


### 💼 월급 대비 커미션 비율이 20% 초과인 직원 조회
```sql
SELECT
  ename AS 이름,
  job AS 직업,
  sal AS 급여,
  comm / sal AS "커미션 비율"
FROM emp
WHERE comm IS NOT NULL
  AND comm / sal > 0.2;
  ```
![결과](https://github.com/user-attachments/assets/c8c61fea-f946-4506-8419-d82eff5ce3c9)
<br></br>


### 💰 세금이 20%일 때 세후 월급여가 2000 이상인 직원 조회

```sql
SELECT 
  ename AS 이름,
  empno AS 사번,
  sal AS "세전 급여",
  (sal - sal * 0.2) AS "세후 급여"
FROM emp
WHERE (sal - sal * 0.2) >= 2000
ORDER BY sal ASC;
```
![결과](https://github.com/user-attachments/assets/7e279d9a-b127-4523-bc58-ec971cd28ef6)
<br></br>


###  🧾과세표준 8000만원 ~ 1억 2천만원 구간인 직원 조회

>과세표준기본세율(단위 만원)<br>
>5,000 ~ 8,800 -> 624만원 + (5,000만원 초과금액의 24%)<br>
>8,800 ~ 15,000 -> 1,536만원 + (8,800만원 초과금액의 35%)<br>
>15,001 ~ 30,000 -> 3,706만원 + (1억5천만원 초과금액의 38%)

###  과세표준 계산 예시

과세표준이 1억 2천만원인 경우:

8,800만원 초과 구간 (35% 세율) 적용

초과금액: 1억2천 - 8,800만원 = 3,200만원 

산출세액 = 1,536만원 + (3,200만원 × 0.35) = 2,656만원

```sql
-- @MYSQL
SELECT
  ename AS 이름,
  sal * 12 + IFNULL(comm, 0) AS 연봉,
  (sal * 12 + IFNULL(comm, 0) - 8800) AS 초과금액,
  (sal * 12 + IFNULL(comm, 0) - 8800) * 0.35 + 1536 AS 산출세액
FROM emp
WHERE sal * 12 + IFNULL(comm, 0) BETWEEN 8800 AND 15000;

-- @ORACLE
SELECT
  ename AS 이름,
  sal * 12 + NVL(comm, 0) AS 연봉,
  (sal * 12 + NVL(comm, 0) - 8800) AS 초과금액,
  (sal * 12 + NVL(comm, 0) - 8800) * 0.35 + 1536 AS 산출세액
FROM emp
WHERE sal * 12 + NVL(comm, 0) BETWEEN 8800 AND 15000;

```
![결과](https://github.com/user-attachments/assets/9c7625d5-4051-4729-8ef7-9db18f672a4d)
<br></br>


## 🔧 트러블 슈팅
```sql
-- Mysql
SELECT ename, empno 
FROM emp 
WHERE hiredate = STR_TO_DATE('81/09/28','%y/%m/%d');

-- Oracle
SELECT
ename, empno 
FROM emp 
WHERE hiredate = TO_DATE('81/09/28','YY/MM/DD');
```
위 쿼리문이 mysql에서는 작동하지만, Oracle에서는 작동하지 않는다
	- Oracle에서는 20(현재세기)+81로 년도를 해석했다. 50의 값을 기준으로 유연하게 처리하려면 RR을 사용하자.
   	- mysql에서는 자동으로 70년도 기준으로 19 또는 20 처리를 한다.

