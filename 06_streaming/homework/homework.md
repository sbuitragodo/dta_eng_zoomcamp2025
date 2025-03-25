# Homework

## Question 1: Redpanda version

What's the version, based on the output of the command you executed? (copy the entire version)

### Solution:
`Version:     v24.2.18`
`Git ref:     f9a22d4430`
`Build date:  2025-02-14T12:52:55Z`
`OS/Arch:     linux/amd64`
`Go version:  go1.23.1`
`Redpanda Cluster   node-1  v24.2.18 - f9a22d443087b824803638623d6b7492ec8221f9`

## Question 2. Creating a topic

What's the output of the command for creating a topic? Include the entire output in your answer.

### Solution:
- `rpk topic create green-trips`

## Question 3. Connecting to the Kafka server

Provided that you can connect to the server, what's the output
of the last command?

### Solution:
- `True`

## Question 4: Sending the Trip Data

How much time did it take to send the entire dataset and flush? 

### Solution:
- `224 seconds`

## Question 5: Build a Sessionization Window (2 points)

Which pickup and drop off locations have the longest unbroken streak of taxi trips?

### Solution:
- `"East Harlem South" to "East Harlem North" with 5683 `