# Netbox Docker Custom

This application is based off of the original netbox-docker maintained by the netbox community [Netbox Docker](https://github.com/netbox-community/netbox-docker) but has several plugins installed.  The dockerfile uses the image as a base: [Netbox Dockerhub](https://hub.docker.com/r/netboxcommunity/netbox).

## Netbox 4.x compatibility
The following plugins are not yet compatible with Netbox 4.x so they are disabled in the startup configuration file (commented out).
- [netbox-proxbox](https://github.com/netdevopsbr/netbox-proxbox)

A **netbox-4.x-startup-config-configmap-example.yaml** has been provided to support the above plugins being disabled when using Netbox 4.x

## Installed plugins
- [django3-auth-saml2](https://github.com/jeremyschulman/django3-auth-saml2)
- [netbox-plugin-auth-saml2](https://github.com/jeremyschulman/netbox-plugin-auth-saml2)
- [netbox-plugin-dns](https://github.com/peteeckel/netbox-plugin-dns)
- [netbox-topology-views](https://github.com/mattieserver/netbox-topology-views)
- [netbox-proxbox](https://github.com/netdevopsbr/netbox-proxbox)

## Running with Kubernetes
Sample kubernetes .yaml files have been included and below are explanations of each element yaml.

**deployment-example.yaml**
An example deployment.  List of required secrets:
- _aws-s3-access-1_: Used for accessing an AWS S3 bucket for static image file storage
- _netbox-secret_: Netbox superuser account and superuser API token
- _netbox-db-redis_: Netbox database and redis account login

**netbox-config-configmap-example.yaml**
Netbox general configuration for connectivity to databases and redis.  The example provided assumes running a postgres and redis database in cluster, however external databases can be used as well.  In order to use a saml backend the HTTP_REMOTE_USER must be set

**netbox-sso-saml2-configmap-example.yaml**
Required configmap to insert the XML data for the SAML data.  This is essentially the idP certificate in XML form.  Create this configmap from the certificate file.

**netbox-startup-config-configmap-example.yaml**
Startup config relevant to Netbox.  This tells Netbox what plugins to enable and any plugin specific configurations.  It also has a few shell scripts that are required to be executed once the container is launched for optimal Netbox operation.

**netbox-svc-example.yaml**
The Kubernetes service that allows connectivity to the netbox container

**netbox-toplology-pvc-example.yaml**
This is a persistent volume claim that is used to store Netbox Topology Views images.  The example provided assumes using longhorn as the csi, however adapt as needed.  Since this is file based storage RWX based storage should be fine