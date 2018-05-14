import pickle


class ResultData(object):
    @staticmethod
    def dump(filename, data):
        with open('./RESULTS/' + filename, "wb") as out:
            pickle.dump(data, out)

    @staticmethod
    def load(filename):
        with open('./RESULTS/' + filename, 'rb') as f:
            return pickle.load(f)
