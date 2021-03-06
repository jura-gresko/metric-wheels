#!/bin/bash

function install_twine {
    python --version
    python -m pip install twine
}

function upload_to_pypi {
    local pypi_server=${1:-$PYPI_SERVER}
    local wheelhouse=$(abspath ${WHEEL_SDIR:-wheelhouse})

    install_twine

    local OS_ID=manylinux
    if [ -n "$IS_OSX" ]; then OS_ID=macosx; fi

    TWINE_USERNAME=__token__ TWINE_PASSWORD=${PYPI_KEY} twine upload --repository-url ${pypi_server} ${wheelhouse}/*-${OS_ID}*.whl
}