#encoding:utf-8
#!/usr/bin/env python
import psutil
import time
from threading import Lock
from flask import Flask, render_template
from flask_socketio import SocketIO
import redis
 
async_mode = None
app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app, async_mode=async_mode)
thread = None
thread_lock = Lock()
# 尝试连接本地reids
r = redis.StrictRedis(host='localhost', port=6379)                          # Connect to local Redis instance
p = r.pubsub()                                                              # See https://github.com/andymccurdy/redis-py/#publish--subscribe
p.subscribe('channel_1') 
# 后台线程 产生数据，即刻推送至前端
def background_thread():
    count = 0
    while True:
        socketio.sleep(5)
        count += 1
        t = time.strftime('%M:%S', time.localtime())
        # 获取系统时间（只取分:秒）
        message = p.get_message()
        print("----------------i am here------------")
        if message:
            cpus = psutil.cpu_percent(interval=None, percpu=True)
            # 获取系统cpu使用率 non-blocking
            print("-----------我正在这里进行测试------------")        
            #if type(message["data"]) ==str:         
            socketio.emit('server_response',
                      {'data': [t, float(message["data"])], 'count': count},
                      namespace='/test')
            # 注意：这里不需要客户端连接的上下文，默认 broadcast = True
 
 
@app.route('/')
def index():
    return render_template('index.html', async_mode=socketio.async_mode)
 
@socketio.on('connect', namespace='/test')
def test_connect():
    global thread
    with thread_lock:
        if thread is None:
            thread = socketio.start_background_task(target=background_thread)
 
if __name__ == '__main__':
    socketio.run(app, debug=True)
