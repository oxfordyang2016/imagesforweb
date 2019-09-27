from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
   return 'Hello World’


@app.route('/')
def index():
   return render_template('hello.html')




if __name__ == '__main__':
   app.run()