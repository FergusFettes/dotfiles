import imp
import os

# Import from a dotfile ".ipython_local.py"
if os.path.isfile(".ipython_local.py"):
    print("Importing from .ipython_local.py")
    imp.load_source('ipython_local', '.ipython_local.py')
    from ipython_local import *
