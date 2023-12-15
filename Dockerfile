FROM python:3.10

# copy the requirements file into the image
COPY requirements.txt /app/requirements.txt

# switch working directory
WORKDIR /app
RUN pip install --upgrade pip

RUN pip install wheel
RUN pip install cmake
RUN pip uninstall cmake -y
RUN pip install pyportfolioopt

# install the dependencies and packages in the requirements file
RUN pip install -r requirements.txt

ENV OPENAI_API_KEY=open-api-key

# copy every content from the local file to the image
COPY model.py /app
RUN echo "OPENAI_API_KEY=$OPENAI_API_KEY" > .env

CMD [ "streamlit","run","model.py","--server.port", "8501" ]
