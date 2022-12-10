FROM python:3.11-alpine AS poetry_deps
RUN pip install poetry

COPY poetry.lock .
COPY pyproject.toml .
RUN poetry export > requirements.txt

FROM python:3.11-alpine
ENV PYTHONUNBUFFERED 1
ENV FLASK_APP poetry_docker.main

WORKDIR /app
COPY . /app

COPY --from=poetry_deps requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

ENTRYPOINT [ "flask", "run", "--host", "0.0.0.0" ]
EXPOSE 5000