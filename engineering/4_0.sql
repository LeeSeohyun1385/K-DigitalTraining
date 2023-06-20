use sql_analyze;


# 과제 : 성별 구분을 T 말고 M, F를 이용해서 구하기
# 2023년 04월 기준 전국 주요 시/도의 연령대별 인구수 합계 
SELECT AGRDE_SE_CD,
		SUM(POPLTN_CNT) AS AGRDE_POPLTN_CNT

FROM TB_POPLTN
WHERE ADMINIST_ZONE_NO LIKE '__00000000' -- 시/도
	AND POPLTN_SE_CD = 'T' -- 전체 인구
	AND STD_MT = '202304'
GROUP BY AGRDE_SE_CD
ORDER BY AGRDE_SE_CD;


# 2023년 4월 기준 전국 주요 시/도의 연령대별 인구수 합계 구하고, 연령대별 인구 비율 구하기

# 정답
SELECT A.AGRDE_SE_CD,
		CONCAT(ROUND(A.AGRDE_POPLTN_CNT / A.SUM_AGRDE_POPLTN_CNT , 3), '%') AS '인구 비율'
FROM(
	SELECT A.AGRDE_SE_CD,
			A.AGRDE_POPLTN_CNT,
			SUM(A.AGRDE_POPLTN_CNT) OVER() AS SUM_AGRDE_POPLTN_CNT
			# OVER() : 원래 연산 결과 한 개의 값만 나오는데, 모든 행에 값을 뿌려줌
	FROM (
			SELECT A.AGRDE_SE_CD,
					SUM(A.POPLTN_CNT) AS AGRDE_POPLTN_CNT

			FROM TB_POPLTN A
			WHERE A.ADMINIST_ZONE_NO LIKE '__00000000' -- 시/도
				AND A.POPLTN_SE_CD = 'T' -- 전체 인구
				AND A.STD_MT = '202304'
			GROUP BY A.AGRDE_SE_CD
			ORDER BY A.AGRDE_SE_CD) A) A;
            
# 연령대별 인구가 가장 많은 지역 구하기(읍/면/동 : 뒤 다섯자리 포함 , 구 :administ_zone_no 뒤 다섯 자리가 00000)
SELECT A.AGRDE_SE_CD,
		A.ADMINIST_ZONE_NO,
        A.ADMINIST_ZONE_NM,
        A.POPLTN_CNT

FROM TB_POPLTN A

WHERE A.ADMINIST_ZONE_NO NOT LIKE '_____00000' -- 읍면동
	AND A.POPLTN_SE_CD = 'T'
    AND A.STD_MT = '202304'
    AND A.POPLTN_CNT > 0; # 인구 수 없을시 대비 

# 2023년 4월 기준 전국의 읍/면/동의 전체 인구수를 조회 후 연령대별 인구가 가장 많은 지역을 조회 
SELECT A.AGRDE_SE_CD,
	   A.ADMINIST_ZONE_NO,
	   A.ADMINIST_ZONE_NM,
	   A.POPLTN_CNT
FROM(
		SELECT A.AGRDE_SE_CD,
				A.ADMINIST_ZONE_NO,
				A.ADMINIST_ZONE_NM,
				A.POPLTN_CNT,
				ROW_NUMBER() OVER(PARTITION BY A.AGRDE_SE_CD ORDER BY A.POPLTN_CNT DESC) AS RNUM # 행번호 붙음
		# partition by : 결과물에서 파티션 만듬 / 그룹바이는 테이블 자체에서 그룹
		# 결과물에 로우넘버를 따로 부여하고 싶음 
		FROM (
				SELECT A.AGRDE_SE_CD,
						A.ADMINIST_ZONE_NO,
						A.ADMINIST_ZONE_NM,
						A.POPLTN_CNT

				FROM TB_POPLTN A

				WHERE A.ADMINIST_ZONE_NO NOT LIKE '_____00000' -- 읍면동
					AND A.POPLTN_SE_CD = 'T'
					AND A.STD_MT = '202304'
					AND A.POPLTN_CNT > 0 
				ORDER BY A.POPLTN_CNT DESC) A
	) A
WHERE A.RNUM = 1
ORDER BY A.AGRDE_SE_CD;

# 2023년 04월 기준 전국의 각 지역의 연령대별 인구수 비율이 높은 지역(읍/면/동) 
# 나의 답 
SELECT A.AGRDE_SE_CD,
		A.ADMINIST_ZONE_NM
FROM(
		SELECT A.AGRDE_SE_CD,
			   A.ADMINIST_ZONE_NM,
			   A.POPLTN_CNT, 
			   ROW_NUMBER() OVER(PARTITION BY A.AGRDE_SE_CD ORDER BY A.AGE_POP_SUM_P DESC) AS RNUM
		FROM ( 
				SELECT A.AGRDE_SE_CD,
								A.ADMINIST_ZONE_NM,
								A.POPLTN_CNT, 
								SUM(A.POPLTN_CNT) OVER(PARTITION BY A.AGRDE_SE_CD) AS AGE_POP_SUM,
								A.POPLTN_CNT / SUM(A.POPLTN_CNT) OVER(PARTITION BY A.ADMINIST_ZONE_NO) AS AGE_POP_SUM_P						
								
				FROM(
								SELECT A.AGRDE_SE_CD,
										A.ADMINIST_ZONE_NO,
										A.ADMINIST_ZONE_NM,
										A.POPLTN_CNT

								FROM TB_POPLTN A

								WHERE A.ADMINIST_ZONE_NO NOT LIKE '_____00000' 
									AND A.POPLTN_SE_CD = 'T'
									AND A.STD_MT = '202304'
									AND A.POPLTN_CNT > 0 
								ORDER BY A.POPLTN_CNT DESC) A) A) A
WHERE RNUM = 1;
                
# 정답
SELECT A.AGRDE_SE_CD, A.ADMINIST_ZONE_NO, A.ADMINIST_ZONE_NM, A.POPLTN_CNT, A.`행정구역번호별각연령대의인구수가차지하는비율`, A.RNUM
FROM
   (
    SELECT A.AGRDE_SE_CD
         , A.ADMINIST_ZONE_NO
         , A.ADMINIST_ZONE_NM
         , A.POPLTN_CNT
         , A.`행정구역번호별각연령대의인구수가차지하는비율`
         , ROW_NUMBER() OVER(PARTITION BY A.AGRDE_SE_CD ORDER BY A.`행정구역번호별각연령대의인구수가차지하는비율` DESC)
             AS RNUM
      FROM
         (
            SELECT
                   A.AGRDE_SE_CD
                 , A.ADMINIST_ZONE_NO
                 , A.ADMINIST_ZONE_NM
                 , A.POPLTN_CNT
                 , ROUND((POPLTN_CNT / SUM(A.POPLTN_CNT) OVER(PARTITION BY ADMINIST_ZONE_NO)) * 100, 2)
                     AS `행정구역번호별각연령대의인구수가차지하는비율`
              FROM
                 (
                    SELECT
                           A.AGRDE_SE_CD
                         , A.ADMINIST_ZONE_NO
                         , A.ADMINIST_ZONE_NM
                         , A.POPLTN_CNT
                      FROM TB_POPLTN A
                     WHERE A.ADMINIST_ZONE_NO NOT LIKE '_____00000'
                       AND A.POPLTN_SE_CD IN ('T')
                       AND A.POPLTN_CNT > 0
                       AND A.STD_MT = '202304'
                     ORDER BY POPLTN_CNT DESC
             ) A
        ) A
    ) A
 WHERE RNUM = 1; 