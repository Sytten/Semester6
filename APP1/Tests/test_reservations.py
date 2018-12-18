import psycopg2

from test_base import TestBase


class TestReservations(TestBase):
    
    def test_add_reservation(self):
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2200-04-05','girp2705','toto',30,35)""")

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

    def test_reservation_out_plage_horaire_apres(self):
        self.db.execute("""UPDATE categories SET blocfin = 70 WHERE categorieid = 110""")

        with self.assertRaisesRegex(psycopg2.InternalError, "Reservation en dehors de la plage de la categorie"):
            self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2200-04-05','girp2705','toto',50,73)""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 0)

    def test_reservation_out_plage_horaire_avant(self):
        self.db.execute("""UPDATE categories SET blocdebut = 15 WHERE categorieid = 110""")
        with self.assertRaisesRegex(psycopg2.InternalError, "Reservation en dehors de la plage de la categorie"):
            self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2200-04-05','girp2705','toto',3,10)""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 0)

    def test_reservation_override(self):
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3015,'2200-05-14','girp2705', 'toto',30,35)""")
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3015,'2200-05-14','girp2705', 'toto',31,34)""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 4)

    def test_reservation_with_sous_locaux(self):
        self.db.execute("""INSERT INTO privilegesreservation VALUES (3,211,1,1,1)""")
        self.db.execute("""INSERT INTO calendrier VALUES ('C2',251,'2020-04-05','girp2705','toto',30,35)""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 12)

    def test_reservation_override_sous_local_with_parent_reserved(self):
        self.db.execute("""INSERT INTO privilegesreservation VALUES (3,211,1,1,1)""")
        self.db.execute("""INSERT INTO calendrier VALUES ('C2',251,'2020-04-05','girp2705','toto',30,35)""")

        with self.assertRaisesRegex(psycopg2.InternalError, "Local est reserve pour cette periode"):
            self.db.execute("""INSERT INTO calendrier VALUES ('C2',25104,'2020-04-05','girp2705','toto',31,34)""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 12)

    def test_reservation_override_with_sous_locaux(self):
        self.db.execute("""INSERT INTO privilegesreservation VALUES (3,211,1,1,1)""")
        self.db.execute("""INSERT INTO calendrier VALUES ('C2',251,'2020-04-05','girp2705','toto',30,35)""")
        self.db.execute("""INSERT INTO calendrier VALUES ('C2',251,'2020-04-05','girp2705','toto',31,34)""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 8)

    def test_delete_reservation(self):
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3015,'2200-05-14','girp2705', 'toto',31,34)""")
        self.db.execute("""DELETE FROM calendrier WHERE numerolocal=3015 AND numeropavillon='D7'""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 0)

    def test_delete_reservation_without_override(self):
        self.db.execute("""UPDATE tempsavantreservation SET numerobloc=4000000 WHERE statusid=2""")
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2020-04-05','pers1234','toto',30,35)""")

        with self.assertRaisesRegex(psycopg2.InternalError, "Vous ne pouvez pas supprimer les evenements pour ce local"):
            self.db.execute("""DELETE FROM calendrier WHERE cip='pers1234'""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 6)

    def test_delete_reservation_sous_local_with_parent_reserved(self):
        self.db.execute("""INSERT INTO privilegesreservation VALUES (3,211,1,1,1)""")
        self.db.execute("""INSERT INTO calendrier VALUES ('C2',251,'2020-04-05','girp2705','toto',30,35)""")

        with self.assertRaisesRegex(psycopg2.InternalError, "Local est reserve pour cette periode"):
            self.db.execute("""DELETE FROM calendrier WHERE numerolocal=25104 AND numeropavillon='C2'""")

        result = self.db.execute_fetch("""SELECT * FROM reservations""")

        self.assertEqual(len(result), 12)
