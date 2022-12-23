# The docker file
FROM python:3.10

ADD wiki-scraper.py .

RUN pip install argparse wikipedia

CMD ["python3", "./wiki-scraper.py" ,"-s football -t summary"]