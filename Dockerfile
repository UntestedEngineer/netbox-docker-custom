# Create first stage build for additional plugins
FROM netboxcommunity/netbox:v4.1.3 AS base

COPY ./plugin_requirements.txt /
COPY extra_config_files/ /etc/netbox/config/
COPY netbox-proxbox/ /opt/netbox/netbox/netbox-proxbox
RUN /opt/netbox/venv/bin/pip install  --no-warn-script-location -r /plugin_requirements.txt

# RUN cd /opt/netbox/netbox/netbox-proxbox \
#     && /opt/netbox/venv/bin/python3 setup.py develop

WORKDIR /opt/netbox/netbox

# Copy first stage build to final container 
FROM netboxcommunity/netbox:v4.1.3

RUN apt-get update && apt-get install xmlsec1 -y

COPY --from=base /opt/netbox/ /opt/netbox/
COPY --from=base /etc/netbox/config/ /etc/netbox/config/