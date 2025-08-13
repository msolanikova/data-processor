from data_processor.conf import config


def lambda_handler(event):
    print(config.customer)

    param = event.get("parameter1")
    print(param)

    if event.get("parameter1") == "exc":
        raise Exception(f"parameter1 has wrong value: {event.get("parameter1")}")

