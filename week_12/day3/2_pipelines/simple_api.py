# run this server at your command line using `python3 simple_api.py`
# while running, in Insomnia, create a POST request to http://0.0.0.0:5000/api/
# In the body of the request, include the data for which you want a prediction, e.g.
# [0.0459, 52.5, 5.32, 0.0, 0.405, 6.315, 45.6, 7.3172, 6.0, 293.0, 16.6, 7.6]
# You can shut down the server when done by pressing CTRL+c

from flask import Flask, request, redirect, url_for, flash, jsonify
import numpy as np
import pickle 
import json


app = Flask(__name__)


@app.route('/api/', methods=['POST'])
def makecalc():
    data = request.get_json()
    data = np.array(data).reshape(1, -1)
    prediction = np.array2string(model.predict(data))

    return jsonify(prediction)

if __name__ == '__main__':
    modelfile = 'finalised_model.pkl'
    model = pickle.load(open(modelfile, 'rb'))
    app.run(debug=True, host='0.0.0.0')
