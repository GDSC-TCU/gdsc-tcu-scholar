from flask import Flask, request
from scholarly import scholarly
import json
q="graph neural netwoek"
app = Flask(__name__)

@app.route('/query')
def hello():
    q = request.args.get('q', default="graph neural network", type=str)
    query = scholarly.search_pubs(q)
    list =[]
    for i in range(10):
        pub =next(query)
        list.append(pub)
    json_str  =json.dumps(list)
    return json_str

if __name__ == "__main__":
    app.run(debug=True, port=8888, threaded=True) 