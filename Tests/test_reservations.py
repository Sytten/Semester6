from test_base import TestBase


class TestReservations(TestBase):
    def test_add_reservation(self):
        self.cur.execute(open("./SQL/test_add_reservation.sql", "r").read())

        self.cur.execute("""SELECT * FROM reservations""")

        result = self.cur.fetchall()

        self.assertEqual(len(result), 6)
