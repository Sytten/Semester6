from result_data import ResultData
from test_base import TestBase


class TestLogs(TestBase):
    def test_add_delete_member(self):
        self.run_sqlf_test("test_add_delete_member.sql")
        result = self.db.execute("""SELECT cip, numeropavillon, numerolocal, message FROM logs WHERE cip = 'logs1234'""")
        # ResultData.dump("test_add_delete_member.p", result)
        expected_result = ResultData.load("test_add_delete_member.p")

        self.assertEqual(expected_result, result)
