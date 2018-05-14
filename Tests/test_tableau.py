import psycopg2

from test_base import TestBase


class TestReservations(TestBase):
    def test_tableau(self):
        self.run_sqlf_test("test_tableau.sql")
