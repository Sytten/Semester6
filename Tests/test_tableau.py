import psycopg2

from test_base import TestBase


class TestReservations(TestBase):
    def test_tableau(self):
        self.run_sqlf("test_tableau.sql")