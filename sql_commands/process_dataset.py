
from sqlalchemy import create_engine
import pandas as pd
import os

password = os.getenv("MYSQL_PASSWORD")
engine_mysql = create_engine(f"mysql+pymysql://root:{password}@127.0.0.1:3306/Players")

def extract_data(table_name, conn):
    query = f"SELECT * FROM {table_name}"
    df = pd.read_sql(query, conn)
    return df

def avg_age_players_club(conn):
    query = f"""SELECT 
                    c.name AS club_name,
                    ROUND(AVG(TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()))) AS avg_age
                FROM clubs c
                JOIN players p ON c.club_id = p.current_club_id
                GROUP BY c.name;"""
    df = pd.read_sql(query, conn)
    return df

if __name__ == "__main__":
    # print(extract_data("players", engine_mysql))
    print(avg_age_players_club(engine_mysql))
    