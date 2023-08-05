#!/bin/bash

brew install tfenv

tfenv list-remote

tfenv install 1.5.4
tfenv install 1.6.0-alpha20230802

tfenv use 1.5.4
tfenv use 1.6.0-alpha20230802

terraform version
