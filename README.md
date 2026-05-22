# jobtrackr
A Job Application Tracker API built with Spring Boot

## Local Setup

1. Clone the repo
2. Copy config templates:
```bash
   cp src/main/resources/application-dev.yml.example \
      src/main/resources/application-dev.yml
```
3. Fill in your local PostgreSQL credentials in after renaming `application-dev.yml`
4. Create the database:
```sql
   CREATE DATABASE jobtrackr_dev;
```
5. Run the app:
```bash
   ./mvnw spring-boot:run
```