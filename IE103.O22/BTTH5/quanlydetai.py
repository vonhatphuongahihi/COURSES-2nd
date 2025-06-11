import pyodbc
from pymongo import MongoClient
import logging

# Cấu hình logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Thông tin kết nối SQL Server
server = r'LAPTOP-6DLULQIM\SQLEXPRESS'  # Dùng raw string để tránh lỗi escape sequence
database = 'QUANLYDETAIBTTTH2' 
username = 'sa' 
password = ''  # Đảm bảo rằng mật khẩu đúng, nếu không có mật khẩu, cần kiểm tra lại quyền truy cập

# Chuỗi kết nối
conn_str = (
    'DRIVER={ODBC Driver 17 for SQL Server};'
    f'SERVER={server};'
    f'DATABASE={database};'
    f'UID={username};'
    f'PWD={password}'
)

try:
    # Kết nối SQL Server
    sql_conn = pyodbc.connect(conn_str)
    sql_cursor = sql_conn.cursor()
    logging.info("Kết nối SQL Server thành công")

    # Kết nối MongoDB
    mongo_client = MongoClient("mongodb://localhost:27017/")
    mongo_db = mongo_client["quanlydetai"]
    logging.info("Kết nối MongoDB thành công")

    # Chuyển đổi bảng SINHVIEN
    sql_cursor.execute("SELECT * FROM SINHVIEN")
    columns = [column[0] for column in sql_cursor.description]
    sinhvien_records = [dict(zip(columns, row)) for row in sql_cursor.fetchall()]
    mongo_db.sinhvien.insert_many(sinhvien_records)
    logging.info("Chuyển đổi bảng SINHVIEN thành công")

    # Chuyển đổi bảng DETAI
    sql_cursor.execute("SELECT * FROM DETAI")
    columns = [column[0] for column in sql_cursor.description]
    detai_records = [dict(zip(columns, row)) for row in sql_cursor.fetchall()]
    mongo_db.detai.insert_many(detai_records)
    logging.info("Chuyển đổi bảng DETAI thành công")

except pyodbc.Error as e:
    logging.error(f"Lỗi SQL Server: {e}")
except Exception as e:
    logging.error(f"Lỗi: {e}")
finally:
    if 'sql_cursor' in locals():
        sql_cursor.close()
    if 'sql_conn' in locals():
        sql_conn.close()
    if 'mongo_client' in locals():
        mongo_client.close()
    logging.info("Đóng kết nối thành công")
