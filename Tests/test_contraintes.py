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
