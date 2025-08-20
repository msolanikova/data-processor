from data_processor.conf import config


def lambda_handler(event, context):
    print(config.customer)

    param1 = event.get("parameter1")
    print(param1)

    param2 = event.get("parameter2")
    print(param2)

    param3 = event.get("parameter3")
    print(param3)


    if event.get("parameter1") == "exc":
        raise Exception(f"parameter1 has wrong value: {event.get("parameter1")}")

