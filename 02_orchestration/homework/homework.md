## Module 2 Homework: Orchestration with Kestra

This is the homework for the module 2: Questions & Answers.

## Quiz Questions
Complete the Quiz shown below. It’s a set of 6 multiple-choice questions to test your understanding of workflow orchestration, Kestra and ETL pipelines for data lakes and warehouses.

1) Within the execution for `Yellow` Taxi data for the year `2020` and month `12`: what is the uncompressed file size (i.e. the output file `yellow_tripdata_2020-12.csv` of the `extract` task)?

### Solution:
- `128.3 MB`

Reviewed the file details in Buckets > bucket-name > yellow_tripdata_2020-12.csv > size

2) What is the rendered value of the variable `file` when the inputs `taxi` is set to `green`, `year` is set to `2020`, and `month` is set to `04` during execution?

### Solution:
- `green_tripdata_2020-04.csv`

Checked the rendered file variable in the kestra console > logs

3) How many rows are there for the `Yellow` Taxi data for all CSV files in the year 2020?

### Solution:
- `24,648,499`

```
select count(1) cnt
from ny-taxi-project-448412.zoomcamp.yellow_tripdata
where filename like '%_2020%';
```

4) How many rows are there for the `Green` Taxi data for all CSV files in the year 2020?

### Solution:
- `1,734,051`

```
select count(1) cnt
from ny-taxi-project-448412.zoomcamp.green_tripdata
where filename like '%_2020%';
```

5) How many rows are there for the `Yellow` Taxi data for the March 2021 CSV file?

### Solution:
- `1,925,152`

```
select count(1) cnt
from ny-taxi-project-448412.zoomcamp.yellow_tripdata
where filename like '%_2021-03%';
```

6) How would you configure the timezone to New York in a Schedule trigger?

### Solution:
- Add a `timezone` property set to `America/New_York` in the `Schedule` trigger configuration

Based on the [documentation](https://kestra.io/docs/workflow-components/triggers/schedule-trigger), the green trigger will look like this:

```
triggers:
  - id: green_schedule
    type: io.kestra.plugin.core.trigger.Schedule
    cron: "0 9 1 * *"
    timezone: America/New_York
    inputs:
      taxi: green    
```