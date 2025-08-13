from pydantic_settings import BaseSettings
from pydantic import Field

class Conf(BaseSettings):
    customer: str = Field("default value")
