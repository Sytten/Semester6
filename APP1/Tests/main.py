import unittest

from database import Database

if __name__ == '__main__':
    setup = Database()
    setup.setup()
    setup.close()

    loader = unittest.TestLoader()
    start_dir = './'
    suite = loader.discover(start_dir)

    runner = unittest.TextTestRunner()
    runner.run(suite)
