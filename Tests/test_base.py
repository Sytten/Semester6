import unittest
import psycopg2
import sys


class TestBase(unittest.TestCase):
    def setUp(self):
        # Create connection
        try:
            self.conn = psycopg2.connect("dbname='postgres' user='postgres' host='localhost' password='postgres'")
            self.conn.autocommit = True
            self.cur = self.conn.cursor()
        except:
            print("I am unable to connect to the database")
            sys.exit(-1)

        # Clean database
        self.cur.execute("""SELECT truncate_all_tables()""")
        self.cur.execute(open("../Seeding/insert_data.sql", "r").read())
        self.cur.execute(open("../Seeding/insert_membre.sql", "r").read())
        self.cur.execute(open("../Seeding/insert_timebloc.sql", "r").read())

    def tearDown(self):
        self.cur.close()
        self.conn.close()

    def run_sqlf(self, filename):
        self.cur.execute(open("./SQL/" + filename, "r").read())