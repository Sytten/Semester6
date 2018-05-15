import unittest

from database import Database


class TestBase(unittest.TestCase):
    def setUp(self):
        self.db = Database()
        self.db.truncate_all_data()
        self.db.insert_data()

    def tearDown(self):
        self.db.close()
