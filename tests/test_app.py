from data_processor.app import lambda_handler
import pytest


def test_lambda_handler_does_not_throw_exception_when_empty_event():
    try:
        lambda_handler({}, None)
    except Exception as e:
        pytest.fail("Unexpected MyError ..")

def test_lambda_handler_does_not_throw_exception_when_parameter_with_correct_value():
    try:
        lambda_handler({"parameter1": "correct value"}, None)
    except Exception as e:
        pytest.fail("Unexpected MyError ..")

def test_lambda_handler_does_throw_exception_when_wrong_parameter_value_provided():
    with pytest.raises(Exception):
        lambda_handler({"parameter1": "exc"}, None)
