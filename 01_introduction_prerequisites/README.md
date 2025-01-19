# Module 1: Introduction & Prerequisites

This module helped me to the following tasks:
- Set up the environment using Github Codespaces.
  - Installed python libraries: pgcli, sqlalchemy, psycopg2, jupyter notebook.
  - Installed Terraform.
- Explore the NYC yellow taxi 2021 data with the terminal, pandas, and pgcli. 
- Create a Python script to ingest data into the Postgres database in Docker.
- Create a Dockerfile to run the python script in the container.
- Create a docker-compose file to run interactively the database and pgadmin images using the same network.

### Helpful commands:
- Connect to the db using pgcli
```
pgcli -h localhost -U root -p 5432 -d ny_taxi
```
- Convert a jupyter notebook into a python script.
```
jupyter nbconvert --to=script nyc_data_exploration.ipynb
```

### Extensions for VSC
- python
- docker

### Notes:
- I started setting the environment using git bash but I had issues (failed password) connecting to the db using pgcli.
- I tried also using a previous setting with wsl and was able to follow most of the content. The dockerization of the python script gave me errors.
- I finally decided to use Github Codespaces which was quite easy to set up and follow the content for this module.