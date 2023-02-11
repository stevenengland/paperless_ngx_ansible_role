import os
import re
from urllib.request import urlopen
from pathlib import Path

def get_pngx_docs_configuration_vars(pattern: str) -> list:
    url = "https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docs/configuration.md"
    content = urlopen(url).read().decode('utf-8')
    return re.findall( pattern, content)

def get_role_readme_configuration_vars(pattern: str) -> list:
    file_path = os.path.dirname(__file__) + '/../../README.md'
    content = Path(file_path).read_text()
    return re.findall( pattern, content)