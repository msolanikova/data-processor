from conf import Conf


def lambda_handler():
    config = Conf()
    print(config.customer)

