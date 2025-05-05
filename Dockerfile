FROM jupyter/datascience-notebook:latest

# Install Microsoft ODBC Driver 18 for SQL Server using updated GPG method
USER root

RUN apt-get update && \
    apt-get install -y curl gnupg apt-transport-https && \
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg && \
    echo "deb [arch=arm64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev

USER $NB_UID

# Install pivot table plugins
RUN pip install pivottablejs qgrid