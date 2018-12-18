from database import Database

if __name__ == '__main__':
    setup = Database()
    setup.setup()
    setup.insert_data()
    setup.close()

