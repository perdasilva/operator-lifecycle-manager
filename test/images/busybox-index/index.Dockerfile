# The base image is expected to contain
# /bin/opm (with a serve subcommand) and /bin/grpc_health_probe
ARG OPM_VERSION=latest
FROM quay.io/operator-framework/opm:${OPM_VERSION}

# Set DC-specific label for the location of the DC root directory
# in the image
LABEL operators.operatorframework.io.index.configs.v1=/configs

# Copy declarative config root into image at /configs and pre-populate serve cache
COPY /configs /configs
RUN ["/bin/opm", "serve", "/configs", "--cache-dir=/tmp/cache", "--cache-only"]

# Configure the entrypoint and command
ENTRYPOINT ["/bin/opm"]
CMD ["serve", "/configs", "--cache-dir=/tmp/cache"]