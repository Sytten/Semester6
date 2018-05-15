import psycopg2

from test_base import TestBase


class TestReservations(TestBase):
    
    def test_add_reservation(self):
        self.run_sqlf_test("test_add_reservation.sql")

        result = self.db.execute("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 6)

    def test_add_reservation_without_write_right(self):
        with self.assertRaisesRegex(psycopg2.InternalError, "Vous ne pouvez pas reserver ce local"):
            self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2200-04-12','fuge2701','toto',30,35)""")

    def test_add_reservation_temps_avant_reservation_exceeded(self):
        with self.assertRaisesRegex(psycopg2.InternalError, "Vous ne pouvez pas reserver autant davance.+"):
            self.db.cur.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2200-04-12','pers1234','toto',30,35)""")

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