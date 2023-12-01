# dbt Project Setup Guide

This directory contains the dbt (data build tool) project used for transforming and analyzing data for the Eurostat Self-Employment Analysis. Below is a detailed guide on setting up dbt in Visual Studio Code, prerequisites, and configuring a local PostgreSQL database.

## Prerequisites

- **Visual Studio Code**: An IDE for code editing and dbt integration.
- **Python**: Required for running dbt. [Download Python](https://www.python.org/downloads/)
- **PostgreSQL**: A local PostgreSQL database for storing and transforming data. [Download PostgreSQL](https://www.postgresql.org/download/)

## Setting Up dbt in Visual Studio Code

1. **Install Visual Studio Code**: If not already installed, [download and install VS Code](https://code.visualstudio.com/Download).

2. **Install the Python Extension**: Open VS Code, go to Extensions, and search for 'Python'. Install the Python extension by Microsoft.

3. **Create a Python Virtual Environment**:
    - Open the terminal in VS Code.
    - Navigate to the `etl` directory.
    - Run `python -m venv dbt-venv` and activate the virtual environment.

4. **Install dbt**:
    - In the activated virtual environment, run `pip install dbt-core`.

5. **Configure dbt**:
    - Create and configure the `profiles.yml` file with your PostgreSQL connection details.

6. **Run dbt Commands**:
    - Use the terminal to run dbt commands like `dbt run` and `dbt test`.

## Setting Up a Local PostgreSQL Database

1. **Install PostgreSQL**: Follow the installation process from the official PostgreSQL website.

2. **Create a New Database**: Use the PostgreSQL command line or a GUI tool like pgAdmin to create a new database.

3. **Configure Connection in dbt**:
    - Update the `profiles.yml` in your `~/.dbt/` directory with the credentials of your local PostgreSQL database.

## Using dbt

With dbt and PostgreSQL set up, you can now start building your data models. Refer to the dbt documentation for guidance on creating models, tests, and documentation.

## Additional Resources

- [dbt Documentation](https://docs.getdbt.com/docs/introduction)
- [PostgreSQL Official Documentation](https://www.postgresql.org/docs/)


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
