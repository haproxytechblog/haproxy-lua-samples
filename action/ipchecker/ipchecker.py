#
# The contents of this file are Copyright (c) 2019. HAProxy Technologies. All Rights Reserved.
#
# This file is subject to the terms and conditions defined in
# file 'LICENSE', which is part of this source code package.

import random
from flask import Flask
app = Flask(__name__)

@app.route("/<address>")
def check(address=None):
    myrandom = random.randint(0, 1)
    if myrandom > 0:
        return 'allow'
    else:
        return 'deny'