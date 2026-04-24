# Create first stage build for additional plugins
FROM netboxcommunity/netbox:v4.5.8 AS base

COPY ./plugin_requirements.txt /opt/netbox
# COPY netbox-proxbox/ /opt/netbox/netbox/netbox-proxbox
COPY extra_config_files/ /etc/netbox/config/
RUN /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt
# RUN /usr/local/bin/uv pip install -e ./netbox-proxbox

WORKDIR /opt/netbox/netbox

# Copy first stage build to final container 
FROM netboxcommunity/netbox:v4.5.8


RUN apt-get update && apt-get install xmlsec1 -y

COPY --from=base /opt/netbox/ /opt/netbox/
COPY --from=base /etc/netbox/config/ /etc/netbox/config/