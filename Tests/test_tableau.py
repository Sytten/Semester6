import psycopg2

from test_base import TestBase


class TestReservations(TestBase):
    def test_tableau(self):
        self.db.execute("select * from reservations LIMIT 1")
