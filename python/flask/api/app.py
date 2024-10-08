from apispec import APISpec
from apispec.ext.marshmallow import MarshmallowPlugin
from flask import Flask
from flask_apispec.extension import FlaskApiSpec
from flask_restful import Api

app = Flask(__name__)  # Flask app instance initiated
api = Api(app)  # Flask restful wraps Flask app around it.
app.config.update(
    {
        "APISPEC_SPEC": APISpec(
            title="Awesome Project",
            version="v1",
            plugins=[MarshmallowPlugin()],
            openapi_version="2.0.0",
        ),
        "APISPEC_SWAGGER_URL": "/swagger/",  # API Doc JSON
        "APISPEC_SWAGGER_UI_URL": "/swagger-ui/",  # UI of API Doc
    }
)
docs = FlaskApiSpec(app)
