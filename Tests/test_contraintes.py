import psycopg2

from test_base import TestBase


class TestContraintes(TestBase):
    def test_categorie_bloc_out_0_and_95(self):
        with self.assertRaisesRegex(psycopg2.IntegrityError, "value for domain blocdomain violates check constraint \"blocdomain_check\""):
            self.db.execute("""INSERT INTO categories VALUES(9999, 'nom de local', 0, 96)""")

        with self.assertRaisesRegex(psycopg2.IntegrityError, "value for domain blocdomain violates check constraint \"blocdomain_check\""):
            self.db.execute("""INSERT INTO categories VALUES(9999, 'nom de local', 0, -1)""")

        with self.assertRaisesRegex(psycopg2.IntegrityError, "value for domain blocdomain violates check constraint \"blocdomain_check\""):
            self.db.execute("""INSERT INTO categories VALUES(9999, 'nom de local', -1, 0)""")

        with self.assertRaisesRegex(psycopg2.IntegrityError, "value for domain blocdomain violates check constraint \"blocdomain_check\""):
            self.db.execute("""INSERT INTO categories VALUES(9999, 'nom de local', 96, 0)""")

    def test_categorie_bloc_between_0_and_95(self):
        self.db.execute("""INSERT INTO categories VALUES(9999, 'nom de local', 0, 95)""")

    def test_bloc_possible_out_0_95(self):
        self.db.execute("""TRUNCATE TABLE blocTempsPossible""")
        with self.assertRaisesRegex(psycopg2.IntegrityError, "value for domain blocdomain violates check constraint \"blocdomain_check\""):
            self.db.execute("""INSERT INTO bloctempspossible VALUES(-1, 'ninenine')""")

        with self.assertRaisesRegex(psycopg2.IntegrityError, "value for domain blocdomain violates check constraint \"blocdomain_check\""):
            self.db.execute("""INSERT INTO bloctempspossible VALUES(96, 'sixxxsix')""")

    def test_bloc_possible_between_0_95(self):
        self.db.execute("""TRUNCATE TABLE blocTempsPossible""")
        self.db.execute("""INSERT INTO bloctempspossible VALUES(0, 'zero')""")
        self.db.execute("""INSERT INTO bloctempspossible VALUES(95, 'ninetofive')""")

    def test_reservation_bloc_out_0_95(self):
        self.db.execute("""INSERT INTO evenements VALUES (0,'hi')""")
        with self.assertRaisesRegex(psycopg2.IntegrityError, "value for domain blocdomain violates check constraint \"blocdomain_check\""):
            self.db.execute("""INSERT INTO reservations VALUES ('D7',3020,'2200-04-05',-1,0,'girp2705')""")

        with self.assertRaisesRegex(psycopg2.IntegrityError, "value for domain blocdomain violates check constraint \"blocdomain_check\""):
            self.db.execute("""INSERT INTO reservations VALUES ('D7',3020,'2200-04-05',96,0,'girp2705')""")

    def test_reservation_bloc_between_0_95(self):
        self.db.execute("""INSERT INTO evenements VALUES (0,'hi')""")
        self.db.execute("""INSERT INTO reservations VALUES ('D7',3020,'2200-04-05',0,0,'girp2705')""")
        self.db.execute("""INSERT INTO reservations VALUES ('D7',3020,'2200-04-05',95,0,'girp2705')""")