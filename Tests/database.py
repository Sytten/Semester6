import sys
import psycopg2


class Database(object):
    def __init__(self):
        try:
            self.conn = psycopg2.connect("dbname='postgres' user='postgres' host='localhost' password='postgres'")
            self.conn.autocommit = True
            self.cur = self.conn.cursor()
        except:
            print("I am unable to connect to the database")
            sys.exit(-1)

    def run_sqlf(self, folder, filename):
        with open("../" + folder + "/" + filename, "r") as f:
            self.cur.execute(f.read())
            f.close()

    def setup(self):
        print("DROP THEN CREATE tables")
        self.run_sqlf("Creation", "create_database.sql")
        print("ALTER DATABASE")
        self.run_sqlf("Creation", "alter_database.sql")
        print("CREATE TRIGGERS, FUNCTIONS and VIEWS")
        self.run_sqlf("Creation", "logs.sql")
        self.run_sqlf("Creation", "reservations.sql")
        self.run_sqlf("Creation", "tableau.sql")

    def truncate_all_data(self):
        # print("TRUNCATE ALL DATA")
        self.cur.execute("""SELECT truncate_all_tables()""")

    def insert_data(self):
        # print("INSERT BASE DATA")
        self.run_sqlf("Seeding", "insert_data.sql")
        # print("INSERT MEMBRES")
        self.run_sqlf("Seeding", "insert_membre.sql")

    def execute(self, sql):
        self.cur.execute(sql)
        return self.cur.fetchall()

    def cur(self):
        return self.cur

    def close(self):
        self.cur.close()
        self.conn.close()
