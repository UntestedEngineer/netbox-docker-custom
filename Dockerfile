# Create first stage build for additional plugins
FROM netboxcommunity/netbox:v4.2.8 AS base

COPY ./plugin_requirements.txt /opt/netbox
COPY extra_config_files/ /etc/netbox/config/
## COPY netbox-proxbox/ /opt/netbox/netbox/netbox-proxbox
RUN /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt

# RUN cd /opt/netbox/netbox/netbox-proxbox \
#     && /opt/netbox/venv/bin/python3 setup.py develop

WORKDIR /opt/netbox/netbox

# Copy first stage build to final container 
FROM netboxcommunity/netbox:v4.2.8

RUN apt-get update && apt-get install xmlsec1 -y

COPY --from=base /opt/netbox/ /opt/netbox/
COPY --from=base /etc/netbox/config/ /etc/netbox/config/