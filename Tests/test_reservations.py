import psycopg2

from test_base import TestBase


class TestReservations(TestBase):
    def test_add_reservation(self):
        self.run_sqlf("test_add_reservation.sql")

        self.cur.execute("""SELECT * FROM reservations""")

        result = self.cur.fetchall()

        self.assertEqual(len(result), 6)

    def test_reservation_conflict(self):
        with self.assertRaises(psycopg2.IntegrityError):
            self.run_sqlf("test_reservation_conflict.sql")

        self.cur.execute("""SELECT * FROM reservations""")

        result = self.cur.fetchall()

        self.assertEqual(len(result), 0)