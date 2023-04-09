
FROM python:3.10.5-slim

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app /code/app

CMD ["uvicorn", "app.api.main:app", "--reload", "--reload-dir", "/code/app", "--host", "0.0.0.0", "--port", "80"]
