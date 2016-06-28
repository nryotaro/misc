#! /usr/bin/env python

from invoke import task, run

@task
def build():
    run("ping www.google.com")
