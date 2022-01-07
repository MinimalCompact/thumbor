from locust import HttpUser, TaskSet, task


class HealthTaskSet(TaskSet):
    @task
    def my_task(self):
        self.client.get('/healthcheck')

class SimpleTaskSet(TaskSet):
    @task
    def crop(self):
        self.client.get('/unsafe/500x150/i.imgur.com/Nfn80ck.png')
        self.client.get('/unsafe/500x400/upload.wikimedia.org/wikipedia/commons/a/a9/St_Francis_Seminary.jpg')

    @task
    def fit_in(self):
        self.client.get('/unsafe/fit-in/100x150/i.imgur.com/Nfn80ck.png')
        self.client.get('/unsafe/fit-in/600x400/upload.wikimedia.org/wikipedia/commons/a/a9/St_Francis_Seminary.jpg')

    @task
    def filter(self):
        self.client.get('/unsafe/fit-in/600x400/filters:fill(white):watermark(raw.githubusercontent.com/cshum/imagor/master/testdata/gopher-front.png,repeat,bottom,10):hue(290):saturation(100):fill(yellow):format(jpeg):quality(80)/upload.wikimedia.org/wikipedia/commons/a/a9/St_Francis_Seminary.jpg')

    @task
    def top(self):
        self.client.get('/unsafe/100x150/top/i.imgur.com/Nfn80ck.png')
        self.client.get('/unsafe/400x400/top/upload.wikimedia.org/wikipedia/commons/a/a9/St_Francis_Seminary.jpg')


class Benchmark(HttpUser):
    tasks = [SimpleTaskSet]
