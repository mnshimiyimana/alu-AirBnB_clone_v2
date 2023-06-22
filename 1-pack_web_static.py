#!/usr/bin/python3
# generate .tgz archive


def do_pack():
    """generates a .tgz archive from the contents of the web_static folder"""
    from fabric.api import local
    from datetime import datetime
    import os

    now = datetime.now()
    date = now.strftime("%Y%m%d%H%M%S")
    filename = "versions/web_static_{}.tgz".format(date)
    local("mkdir -p versions")
    local("tar -cvzf {} web_static".format(filename))
    if os.path.exists(filename):
        return filename
    return None
