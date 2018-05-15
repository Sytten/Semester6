import psycopg2

from test_base import TestBase


class TestReservations(TestBase):
    
    def test_add_reservation(self):
        self.run_sqlf_test("test_add_reservation.sql")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 6)

    def test_add_reservation_without_write_right(self):
        with self.assertRaisesRegex(psycopg2.InternalError, "Vous ne pouvez pas reserver ce local"):
            self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2200-04-12','fuge2701','toto',30,35)""")

    def test_add_reservation_temps_avant_reservation_exceeded(self):
        with self.assertRaisesRegex(psycopg2.InternalError, "Vous ne pouvez pas reserver autant davance.+"):
            self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2200-04-12','pers1234','toto',30,35)""")

    def test_reservation_conflict(self):
        self.db.execute("""UPDATE tempsavantreservation SET numerobloc=4000000 WHERE statusid=2""")
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2020-04-05','pers1234','toto',30,35)""")
        with self.assertRaisesRegex(psycopg2.IntegrityError, "duplicate key value violates unique constraint \"pk_reservations\""):
            self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2020-04-05','pers1234','toto',34,37)""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 6)

    def test_reservation_out_plage_horaire_avant(self):
        with self.assertRaisesRegex(psycopg2.InternalError, "Reservation en dehors de la plage de la categorie"):
            self.run_sqlf_test("test_reservation_out_plage_horaire_avant.sql")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 0)

    def test_reservation_out_plage_horaire_apres(self):
        with self.assertRaisesRegex(psycopg2.InternalError, "Reservation en dehors de la plage de la categorie"):
            self.run_sqlf_test("test_reservation_out_plage_horaire_apres.sql")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 0)

    def test_reservation_override(self):
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3015,'2200-05-14','girp2705', 'toto',30,35)""")
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3015,'2200-05-14','girp2705', 'toto',31,34)""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 4)

    def test_delete_reservation_without_override(self):
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3015,'2200-05-14','', 'toto',30,35)""")

