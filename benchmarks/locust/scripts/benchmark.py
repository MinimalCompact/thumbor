from locust import HttpUser, TaskSet, task


class HealthTaskSet(TaskSet):
    @task
    def my_task(self):
        self.client.get('/healthcheck')

class SimpleTaskSet(TaskSet):
    @task
    def crop(self):
        self.client.get('/unsafe/500x150/i.imgur.com/Nfn80ck.png')

    @task
    def fit_in(self):
        self.client.get('/unsafe/fit-in/100x150/i.imgur.com/Nfn80ck.png')

class Benchmark(HttpUser):
    tasks = [SimpleTaskSet]
