from pyspark.sql import SparkSession
from pyspark.ml.recommendation import ALS
from pyspark.ml.evaluation import RegressionEvaluator
from pyspark.sql.types import IntegerType

# 데이터가 매우 큰 경우 강제로 사용할 메모리의 용량을 설정
MAX_MEMORY = '4g' #mb:메가바이트 경우

spark = SparkSession.builder.appName("movie-recommendation")\
    .config("spark.executor.memory", MAX_MEMORY)\
    .config("spark.driver.memory", MAX_MEMORY).getOrCreate()
#task 실행시켜주는 메모리 2기가 까지
# drive 실행시켜주는 메모리

filepath = "/home/ubuntu/working/spark-examples/data/MovieLens/ratings.csv"
ratings_df = spark.read.csv(f"file://{filepath}", inferSchema=True, header=True)

#spark-submit 15-MovieRecommend.py

# timestamp 는 빼고 선택
ratings_df = ratings_df.select(['userId','movieId','rating'])
#ratings_df.printSchema()

# 통계 정보 확인
ratings_df.select('rating').describe().show()

# train_df, test_df 데이터 세트 분리
train_df, test_df = ratings_df.randomSplit([0.8, 0.2], seed=42)

# 모델 생성 - Transformer
als = ALS(
    maxIter=5,
    regParam=0.1, # 학습률

    userCol="userId", # 사용자 컬럼
    itemCol="movieId", # 아이템 컬럼(여기서는 영화)
    ratingCol="rating", # 평점 정보

    coldStartStrategy="drop" # 학습하지 못한 데이터에 대한 처리(삭제) , 옵션임
)

# 모델 훈련
als_model = als.fit(train_df)
# 훈련을 하고 나서 모델이 됨

# print(type(als))
# print(type(als_model))

# 예측(test_df) - transform
# "이 유저가 이 영화에 몇점을 줄거야" 라는 것이 예측되는 것
predictions = als_model.transform(test_df)
predictions.show() # Action
# rating 실제 점수 , 예측된 점수

# 평가
evaluator = RegressionEvaluator(
    metricName="rmse",
    labelCol="rating",
    predictionCol="prediction"
)

# 예측된 데이터프레임 넣어주기
rmse = evaluator.evaluate(predictions)
print(rmse)
# 추천시스템에 대한 평가는 rmse 같은 점수가 절대적이지는 않음, 사용자 평가가 사실상 가장 중요한 비즈니스
# 0.88은 딱히 좋아보이지는 않음

# 추천하기
# 1. 각 user에게 top3 아이템을 추천
# [{영화 id, 예상 평점}, {영화 id, 예상 평점}, {영화 id, 예상 평점}]

#als_model.recommendForAllUsers(3).show()

# "5.8점을 줄것이다" 가 아닌 이만큼 점수를 높게 줄것이다로 해석

# 2. 각 영화에 어울리는 top3 유저를 추천
#als_model.recommendForAllItems(3).show()


# 사용자 목록을 만들어서 추천
user_list = [276, 53, 393]
users_df = spark.createDataFrame(user_list, IntegerType()).toDF("userId")

user_recommend = als_model.recommendForUserSubset(users_df, 5)
user_recommend.show()


# 개인화
# 특정 user를 위한 추천(한명,유저를 직접 지정)
movies_list = user_recommend.filter("userId = 393").select("recommendations")
#movies_list.show()

# 데이터프레임으로 조회해서 가져오는 것이 아닌, 실제 데이터를 가져와야 하기 때문에 collect()같은 것들을 사용하는 것이 좋다. 
movies_list = movies_list.select("recommendations").collect()[0].recommendations
#print(movies_list)

recommend_df = spark.createDataFrame(movies_list)
recommend_df.show()

movie_filepath = "/home/ubuntu/working/spark-examples/data/MovieLens/movies.csv"
movies_df = spark.read.csv(f"file://{movie_filepath}", inferSchema=True, header=True)

# SQL 활용을 위해 TempView 등록
recommend_df.createOrReplaceTempView("rec")
movies_df.createOrReplaceTempView('movies')

query = """
select *
from movies
join rec on movies.movieId = rec.movieId
order by rating desc
"""

spark.sql(query).show()