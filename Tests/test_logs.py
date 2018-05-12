from test_base import TestBase


class TestLogs(TestBase):
    def test_add_delete_member(self):
        self.cur.execute(open("./SQL/test_add_delete_member.sql", "r").read())

        result = self.cur.fetchall()

        self.assertEqual(len(result), 1)
