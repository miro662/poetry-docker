import pytest
from poetry_docker.main import app


@pytest.fixture
def client():
    return app.test_client()


def test_hello(client):
    response = client.get("/")
    assert b"Hello, world!" == response.data
