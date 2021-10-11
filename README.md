# dataops-engineer-challenge

### Approach
For this DataOps Engineering challenge ive chosen to tackle use case #1: Refunds. My solution is a 'Lakehouse' built in a serverless AWS environment. This repo contains 3 architecture diagrams and a SQL query to produce the required output.

### Solution
The below diagram outlines my solution architecture:

![diagram1](https://github.com/bensharkey3/dataops-engineer-challenge/blob/bensharkey3-dev/diagram1.png?raw=true)




Ideally the source transactions would land in an AWS environment such as S3, but I have accounted for a range of potential ingestion sources. These sources would need to be 'pushed' by one of the various methods illustrated into the S3 Raw data bucket. From there the Glue job moves data through the pipeline and persists the data as tables in the 'base tables' bucket, available to query using SQL in Athena. Glue crawlers would need to be configured to create a data schema from whatever the source data source is to the tables illustrated in the below diagram. I would use Glue Studio to generate the PySpark code that created the output tables, which then can be version controled in the projects git repo. This ensures that the entire stack from Cloudformation infrastructure, to PySpark transformations, and the SQL query can be stored in version control.

Data validation on the source transactions is something worth considering. Since the Glue job is only required to run once a month to produce the required output, we might not detect an anomoly in the source data until its too late, which could potentially prevent the monthly report being run on time. To resolve this we could add an extra step, pehaps an AWS Lambda to run each day across the previous days source data to test for data cleanliness. Alternatively we could just run the entire pipeline on a daily basis, and monitor the Slack webook notifications and Cloudwatch logs.



The diagram below outlines the 'base tables' that are produced in the data lake by the Glue Data Catalogue. These tables would ideally be stores in S3 in Parquet format for query optimisation, and data partitioned by the transaction month would also help optimise query performance. The SQL query included in the repo when run in AWS Athena should generate the required output for the challenge. That is, the total refund amounts per customer. I have included only those fields that are likely essential in the tables, and not included other 'dimension' tables that would be part of the normalised data model, such as 'customer', 'merchant' etc.

![diagram2](https://github.com/bensharkey3/dataops-engineer-challenge/blob/bensharkey3-dev/diagram2.png?raw=true)




Below is an outline of the CI/CD process that runs in Azure DevOps. Firstly, I have decided to include a User Acceptance Testing (UAT) build environment that would contain production data, for the purposes of allowing a manual check before builds are released into production. This way CI/CD can be automated into the UAT environment, and a 'release' would need to be manually invoked to deploy into the production environment, once post deployment tests have been completed. This is likely required for our situation since CI testing doesnt include data accuracy, and query accuracy tests.

A Cloudformation template is version controlled in an Azure DevOps repo, and a commit triggers the Continuous Integration build. The CI build includes code linting tests and if passed deploys the build into the UAT environment. 

![diagram3](https://github.com/bensharkey3/dataops-engineer-challenge/blob/bensharkey3-dev/diagram3.png?raw=true)
