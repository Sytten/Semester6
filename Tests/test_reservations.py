import psycopg2

from test_base import TestBase


class TestReservations(TestBase):
    def test_add_reservation(self):
        self.run_sqlf_test("test_add_reservation.sql")

        result = self.db.execute("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 6)

    def test_reservation_conflict(self):
        with self.assertRaisesRegex(psycopg2.IntegrityError, "update or delete on table \"evenements\" violates foreign key"):
            self.run_sqlf_test("test_reservation_conflict.sql")

        result = self.db.execute("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 0)

    def test_reservation_out_plage_horaire_avant(self):
        with self.assertRaisesRegex(psycopg2.InternalError, "Reservation en dehors de la plage de la categorie"):
            self.run_sqlf_test("test_reservation_out_plage_horaire_avant.sql")

        result = self.db.execute("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 0)

    def test_reservation_out_plage_horaire_apres(self):
        with self.assertRaisesRegex(psycopg2.InternalError, "Reservation en dehors de la plage de la categorie"):
            self.run_sqlf_test("test_reservation_out_plage_horaire_apres.sql")

        result = self.db.execute("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 0)