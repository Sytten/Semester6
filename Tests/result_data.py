import pickle
import csv


class ResultData(object):
    @staticmethod
    def dump(filename, data):
        with open('./RESULTS/' + filename + '_serialized.p', "wb") as out:
            pickle.dump(data, out)
        with open('./RESULTS/' + filename + '_readable.csv', "w+") as out:
            csv_out = csv.writer(out)
            for row in data:
                csv_out.writerow(row)

    @staticmethod
    def load(filename):
        with open('./RESULTS/' + filename + '_serialized.p', 'rb') as f:
            return pickle.load(f)
