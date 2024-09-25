from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_root():
    response = client.get("/api/v0/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World!"}


# python -m pytest
