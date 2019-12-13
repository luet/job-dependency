- `one_job.sh`: 
   - a simple job that returns its first two arguments.
   - `start` and `end` are numbers, integers in this particular case.
   - Fundamentaly, this is the task you need to run multiple
     times. Each individual job is run between `start` and `end`. You
     could use this as a wrapper to call your own code.
- `series.sh`: This is the main program where you set up the run the variables. It calls multiple 
  `one_job.sh` with dependecies and different strides.
  For instance, assume that you need to run your job with parameters between 0 and 100. And you want to 
  divide this task in 10 SLURM jobs. You will set
	```
	TOTAL_NUMBER_JOBS = 10
	STRIDE = 10
	```
	When the program is run, all the SLURM jobs are submitted. If one SLURM job fails, all the 
	subsequent jobs will be canceled.
- `submit_one_job.sh`: Slurm script to submit one instance of `one_job.sh`. This is used for testing.
