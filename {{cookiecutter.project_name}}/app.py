#!/usr/bin/env python3
""" CDK entry point """
import aws_cdk as cdk

from {{cookiecutter.project_slug}}.{{cookiecutter.project_slug}}_stack import ExampleStack


app = cdk.App()
ExampleStack(app, "cdk-example-stack")

app.synth()
