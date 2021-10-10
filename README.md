# dataops-engineer-challenge

### Approach
For this DataOps Engineering challenge ive chosen to tackle use case #1: Refunds.

My solution is a 'Lakehouse' solution built in an serverless AWS environemnt.

This repo contains 3 architecture diagrams and a SQL query to produce the required output.

The below diagram outlines the solution architecture:
![diagram1](https://github.com/bensharkey3/dataops-engineer-challenge/blob/bensharkey3-dev/diagram1.png?raw=true)




This diagram outlines the output tables that are produced in the data lake by the Glue Data Catalogue. The SQL query included in the repo should generate the required output for the challenge. That is, the total refunds per customer.
![diagram2](https://github.com/bensharkey3/dataops-engineer-challenge/blob/bensharkey3-dev/diagram2.png?raw=true)




Here is an outline of the CI/CD process that runs in Azure DevOps. 
![diagram3](https://github.com/bensharkey3/dataops-engineer-challenge/blob/bensharkey3-dev/diagram3.png?raw=true)
