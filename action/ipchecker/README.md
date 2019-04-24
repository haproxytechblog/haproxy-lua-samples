# Sample Action - IP Checker

Demonstrates a custom HAProxy action.

Run the Python script:

```
sudo apt install -y python3 python3-flask

export FLASK_APP=ipchecker.py

flask run
 * Serving Flask app "ipchecker"
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```

Check that the app is running:

```
curl http://127.0.0.1:5000/192.168.50.1
```

Call the app as an *action* in HAProxy using the providing **haproxy.cfg**.