from api.app import api, app, docs
from resources.awesome import AwesomeAPI

api.add_resource(AwesomeAPI, "/awesome")
docs.register(AwesomeAPI)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", use_reloader=True, port=8001)
