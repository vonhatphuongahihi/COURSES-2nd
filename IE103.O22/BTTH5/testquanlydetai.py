from pymongo import MongoClient
import pprint

# Kết nối MongoDB
mongo_client = MongoClient("mongodb://localhost:27017/")
mongo_db = mongo_client["quanlydetai"]

# Kiểm tra collection sinhvien
sinhvien_collection = mongo_db.sinhvien
sinhvien_docs = sinhvien_collection.find()

print("Dữ liệu trong collection sinhvien:")
for doc in sinhvien_docs:
    pprint.pprint(doc)

# Kiểm tra collection detai
detai_collection = mongo_db.detai
detai_docs = detai_collection.find()

print("Dữ liệu trong collection detai:")
for doc in detai_docs:
    pprint.pprint(doc)

# Đóng kết nối MongoDB
mongo_client.close()
