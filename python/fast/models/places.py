from typing import List, Optional

from api.db import Base, engine1
from pydantic import BaseModel
from sqlalchemy import Boolean, Column, Float, Integer, MetaData, String, Table


class DBPlace(Base):
    __tablename__ = "places"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50))
    description = Column(String, nullable=True)
    coffee = Column(Boolean)
    wifi = Column(Boolean)
    food = Column(Boolean)
    lat = Column(Float)
    lng = Column(Float)


Base.metadata.create_all(bind=engine1)


# A Pydantic place
class Place(BaseModel):
    name: str
    description: Optional[str] = None
    coffee: bool
    wifi: bool
    food: bool
    lat: float
    lng: float

    class ConfigDict:
        from_attributes = True
