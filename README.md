# data-processor
Proof-of-concept for CI/CD of small python application. App spec and requirements:
* multiple python services
* multiple AWS Glue jobs
* IaaC in terraform
* AWS Codepipeline and AWS Codebuild for CI/CD

## Use case 1 - individual repository for each service
![CI_CD-High-level approach - repo per service.png](images/CI_CD-High-level%20approach%20-%20repo%20per%20service.png)

## Use case 2 - single repository for all services
![CI_CD-High-level approach - single repo for services.png](images/CI_CD-High-level%20approach%20-%20single%20repo%20for%20services.png)
