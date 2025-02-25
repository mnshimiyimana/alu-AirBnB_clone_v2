#!/usr/bin/python3
"""
starts a web flask application
"""

from flask import Flask, render_template
from models import storage

app = Flask(__name__)


@app.teardown_appcontext
def teardown_db(exception):
    """Close storage"""
    storage.close()


@app.route('/cities_by_states', strict_slashes=False)
def cities_by_states():
    """List all cities by states"""
    states = storage.all("State")
    return render_template('8-cities_by_states.html', states=states)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
