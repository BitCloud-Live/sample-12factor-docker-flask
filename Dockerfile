FROM python:latest
RUN apt-get updat
COPY . / requirements.txt/
RUN apt-get install cron -yqq curl
COPY ./opt/app
WORKDIR opt/app
RUN pip install -r requirements.txt
CMD ["python","./app.py"]
