from locust import HttpLocust, TaskSet, task, between


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

class Benchmark(HttpLocust):
    task_set = SimpleTaskSet
    wait_time = between(0, 0.1)
