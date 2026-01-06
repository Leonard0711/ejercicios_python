
import pandas as pd
from sqlalchemy import create_engine
import kagglehub #type: ignore
import os

def load_datasets_to_mysql():
    path_kaggle_players = kagglehub.dataset_download("davidcariboo/player-scores/versions/585")

    clubs_csv = os.path.join(path_kaggle_players, "clubs.csv")
    clubs_df = pd.read_csv(clubs_csv)

    players_csv = os.path.join(path_kaggle_players, "players.csv")
    players_df = pd.read_csv(players_csv)

    password = os.getenv("MYSQL_PASSWORD")
    engine_mysql = create_engine(f"mysql+pymysql://root:{password}@127.0.0.1:3306/TERCERA")

    with engine_mysql.begin() as connection:
        clubs_df.to_sql("clubs", connection, if_exists="append", index=False, chunksize=1000)
        players_df.to_sql("players", connection, if_exists="append", index=False, chunksize=1000)

if __name__ == "__main__":
    load_datasets_to_mysql()
    print("datasets cargadas en MySQL database 'Players'")

