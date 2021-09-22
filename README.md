# Test Management Service

A service for providing cross-instance and persistent functionality to
[Maze-runner](https://github.com/bugsnag/maze-runner/) instances.

# Running

The service is built and pushed in a docker container to Bugsnag platforms AWS
 infrastructure.  This docker-container can be pulled and run with the following
 configuration options:

- `BITBAR_ACCOUNT_MAX` : Environment variable that determines the maximum
  number of accounts available to Maze-runner instances utilising BitBar at once
