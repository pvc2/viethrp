## BUILDING
##   (from project root directory)
##   $ docker build -t python-for-pvc2-viethrp .
##
## RUNNING
##   $ docker run python-for-pvc2-viethrp

FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r7

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="tghqw7o" \
    STACKSMITH_STACK_NAME="Python for pvc2/viethrp" \
    STACKSMITH_STACK_PRIVATE="1"

# Install required system packages
RUN install_packages libc6 libssl1.0.0 libncurses5 libtinfo5 libreadline6 zlib1g libsqlite3-0

RUN bitnami-pkg install python-3.5.2-2 --checksum 6b4c3906c60994646fb1d4aec3ca5047bd16e84fccedad67158f7a7cb886a4b6

ENV PATH=/opt/bitnami/python/bin:$PATH

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Django template
COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
