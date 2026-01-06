
from sqlalchemy import create_engine, text
import pandas as pd
import os

password = os.getenv("MYSQL_PASSWORD")
engine_mysql = create_engine(f"mysql+pymysql://root:{password}@127.0.0.1:3306/TERCERA")

def make_query(query):
    with engine_mysql.connect() as conn:
        df_query = pd.read_sql(query, conn)
        return df_query

if __name__ == "__main__":
    # Equipos de fútbol con mas jugadores
    query_top = make_query(text("""SELECT c.name AS club_name, COUNT(p.player_id) AS total_players
                               FROM clubs c
                               JOIN players p ON c.club_id = p.current_club_id
                               GROUP BY c.name
                               ORDER BY total_players DESC LIMIT 10;"""))
    # Exportar los resultados de la consulta en formato csv
    # query_top.to_csv("top_teams.csv", index=False)
