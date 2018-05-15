from result_data import ResultData
from test_base import TestBase


class TestReservations(TestBase):
    def test_tableau(self):
        self.db.execute("""INSERT INTO calendrier VALUES ('D7',3020,'2200-04-05','girp2705','toto',30,35)""")
        result = self.db.execute_fetch("""SELECT * FROM TABLEAU('2200-04-05', 0, 96, 110) ORDER BY tempsNom, localNom, evenementNom""")

        # ResultData.dump("test_tableau1", result)
        expected_result = ResultData.load("test_tableau1")

        self.assertEqual(expected_result, result)
